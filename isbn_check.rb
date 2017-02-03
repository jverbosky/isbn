# Program to determine if a specified ISBN number is valid or not (returns true/false)

# Method to convert hyphenated or space-delimited ISBN number to raw number
def output_raw_number(isbn)
  raw_number = []  # initialize an empty array to hold each numerical character
  isbn_array = isbn.split("")  # create an array from characters in isbn number
  isbn_array.each do |character|  # iterate through array to check each character in isbn number
    if character != "-"  # if the character is not a hyphen
      if character != " "  # and if the character is not a space
          raw_number.push(character)  # then push the character (number) to the raw_number array
      end
  	end
  end
  return raw_number.join("")  # use the .join method to convert the array into a numerical string and return it
end

# Method to output all digits from an ISBN number except the last one (i.e. the checksum)
def all_but_last(isbn)
	raw_number = output_raw_number(isbn)  # run the output_raw_number method on the isbn number
	trimmed = raw_number[0..-2]  # use reverse indexing to return all but the last number
end

# Method to create an array of multipliers for calculating the checksum value (based on ISBN type)
def create_multipliers(isbn)
	raw_number = output_raw_number(isbn)  # get the raw isbn number
	if raw_number.length == 10  # if the number is isbn10
		multipliers = (1..9).to_a  # create an array of integers (1 - 9) to multiply each isbn digit
	else
		multipliers = []  # initialize an empty array to hold multipliers
		6.times { multipliers.push(1); multipliers.push(3) }  # create a 12-element array of alternating 1s and 3s
	end
	return multipliers
end

# Method to create the intermediate sum value during checksum calculation
# This method consolidates the common statements for both ISBN types
def create_sum(isbn)
	trimmed = all_but_last(isbn)  # run the all_but_last method to get all but the last digit from raw isbn number
	isbn_array = trimmed.split("")  # split trimmed to create an array of numerical strings
	multipliers = create_multipliers(isbn)
	zipped = multipliers.zip(isbn_array)  # pair up each item from the isbn_array and multipliers arrays in a multi-d array
	results = []  # initialize an empty array to hold the results from multiplying each pair of items in the zipped array
	sum = 0  # initialize a placeholder for adding up the resulting numbers from multiplying each pair in results array
	zipped.each do |x, y|  # iterate through each inner array (item from isbn_array & item from multipliers array)
	  result = x * y.to_i  # multiply each pair of items in the inner array (convert the isbn_array digit to an integer)
	  results.push(result)  # push the resulting product to the results (placeholder) array
	end
	results.each do |number|  # next iterate through all of the products in the results array
		sum += number  # add each product to the accumulating sum (i.e. 0+2=2, 2+1=3, 3+4=7, 7+2=9, 9+ etc...)
	end
	return sum
end

# Method to create the checksum value for a specified ISBN10 or ISBN13 number
def create_checksum(isbn)
	sum = create_sum(isbn)  # run the create_sum method to calculate the intermediate sum value
	raw_number = output_raw_number(isbn)  # get the raw isbn number
	if raw_number.length == 10  # if the number is isbn10
		checksum = sum % 11  # create the checksum by determining the remainder of the sum divided by 11 and return it
	else  # otherwise the number is isbn13
		remainder = sum % 10  # determine the remainder of the sum divided by 10
		difference = 10 - remainder  # subtract the modulus from 10 to determine the difference
		checksum = difference % 10  # create the checksum by determining the remainder of the difference divided by 10 and return it
	end
	return checksum  # return the checksum
end

# Method to validate the calculated checksum value (via create_checksum) against the final digit of the ISBN number
def valid_checksum?(isbn)
	final = isbn[-1]  # use reverse indexing to get the last character from the isbn number
	checksum = create_checksum(isbn)  # run the create_checksum method to calculate the corresponding checksum
	if final == "x"  # if the last character in the isbn number is an "x"
		return true if checksum.to_s == "10"  # then return true if the checksum is "10" (x == 10)
	elsif checksum.to_s == final  # if not, see if the checksum (converted to a string) equals the last character
		return true  # and if so, then return true
	else
		return false  # otherwise, return false
	end
end

# Method to screen out ISBN numbers with invalid characters (before passing to other methods)
def valid_characters?(isbn)
  isbn_array = isbn.split("")  # create an array from characters in isbn number
  first_nine = isbn_array[0..-2]  # first nine elements of isbn_array to check for x/X
  valid_characters = "0123456789 -xX".split("")  # create an array of valid isbn number characters
  invalid_character_count = 0  # counter for invalid characters
  if isbn.length < 10  # if the number is less than 10, it's not a valid isbn number
    return false  # so return false
  end
  isbn_array.each do |character|  # iterate through array to check each character in isbn number
    unless valid_characters.include?(character)  # if the current character is not in the valid characters array
      invalid_character_count += 1  # then increment the invalid character counter
      break  # since one invalid character is enough, break if we find one to save cycles
    end
  end
  first_nine.each do |character|  # iterate through array to check each character in the first nine
    if character == "x" || character == "X"  # if the current character is an x/X
      invalid_character_count += 1  # then increment the invalid character counter
      break  # since one invalid character is enough, break if we find one to save cycles
    end
  end
  if invalid_character_count > 0  # if there are any invalid characters
    return false  # then return false
  else
    valid_checksum?(isbn)  # otherwise, pass the isbn number to the valid_checksum? method
  end
end

# Sandbox testing:
# puts output_raw_number("0-321-14653-0")  # ISBN-10
# puts output_raw_number("877 1 95 869x")  # ISBN-10
# puts output_raw_number("0471958697")  # ISBN-10
# puts output_raw_number("7421394761")  # ISBN-10
# puts output_raw_number("978-0-13-149505-0")  # ISBN-13
# puts output_raw_number("978 0 471 48648 0")  # ISBN-13
# puts output_raw_number("9780470059029")  # ISBN-13

# puts all_but_last("0-321-14653-0")  # ISBN-10
# puts all_but_last("877 1 95 869x")  # ISBN-10
# puts all_but_last("0471958697")  # ISBN-10
# puts all_but_last("7421394761")  # ISBN-10
# puts all_but_last("978-0-13-149505-0")  # ISBN-13
# puts all_but_last("978 0 471 48648 0")  # ISBN-13
# puts all_but_last("9780470059029")  # ISBN-13

# p create_multipliers("0-321-14653-0")  # ISBN-10
# p create_multipliers("877 1 95 869x")  # ISBN-10
# p create_multipliers("0471958697")  # ISBN-10
# p create_multipliers("7421394761")  # ISBN-10
# p create_multipliers("978-0-13-149505-0")  # ISBN-13
# p create_multipliers("978 0 471 48648 0")  # ISBN-13
# p create_multipliers("9780470059029")  # ISBN-13

# puts create_sum("0-321-14653-0")  # ISBN-10
# puts create_sum("877 1 95 869x")  # ISBN-10
# puts create_sum("0471958697")  # ISBN-10
# puts create_sum("7421394761")  # ISBN-10
# puts create_sum("978-0-13-149505-0")  # ISBN-13
# puts create_sum("978 0 471 48648 0")  # ISBN-13
# puts create_sum("9780470059029")  # ISBN-13

# puts create_checksum("0-321-14653-0")  # ISBN-10
# puts create_checksum("877 1 95 869x")  # ISBN-10
# puts create_checksum("0471958697")  # ISBN-10
# puts create_checksum("7421394761")  # ISBN-10
# puts create_checksum("978-0-13-149505-0")  # ISBN-13
# puts create_checksum("978 0 471 48648 0")  # ISBN-13
# puts create_checksum("9780470059029")  # ISBN-13

# puts valid_checksum?("0-321-14653-0")  # ISBN-10
# puts valid_checksum?("877 1 95 869x")  # ISBN-10
# puts valid_checksum?("0471958697")  # ISBN-10
# puts valid_checksum?("7421394761")  # ISBN-10
# puts valid_checksum?("978-0-13-149505-0")  # ISBN-13
# puts valid_checksum?("978 0 471 48648 0")  # ISBN-13
# puts valid_checksum?("9780470059029")  # ISBN-13

# puts valid_characters?("0-321-14653-0")  # ISBN-10
# puts valid_characters?("877 1 95 869x")  # ISBN-10
# puts valid_characters?("0471958697")  # ISBN-10
# puts valid_characters?("7421394761")  # ISBN-10
# puts valid_characters?("978-0-13-149505-0")  # ISBN-13
# puts valid_characters?("978 0 471 48648 0")  # ISBN-13
# puts valid_characters?("9780470059029")  # ISBN-13

# Bad ISBN numbers
# puts valid_characters?("4780470059029")
# puts valid_characters?("0-321@14653-0")
# puts valid_characters?("877195x869")
# puts valid_characters?("")
# puts valid_characters?(" ")
# puts valid_characters?("-")