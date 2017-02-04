# Program to determine if a specified ISBN number is valid or not (returns true/false)
# Start with is_to_small?() method

# Method to convert hyphenated or space-delimited ISBN number to raw number
def output_raw_number(isbn)
  raw_number = []  # initialize an empty array to hold each numerical character
  isbn_array = isbn.split("")  # create an array from characters in isbn number
  isbn_array.each do |character|  # iterate through array to check each character in isbn number
    if character != "-" && character != " "   # if the character is not a hyphen or a space
      raw_number.push(character)  # then push the character (number) to the raw_number array
    end
  end
  return raw_number.join("")  # use the .join method to convert the array into a numerical string and return it
end

# Method to create an array of multipliers for calculating the checksum value (based on ISBN type)
def create_multipliers(isbn)
  if output_raw_number(isbn).length == 10  # if the number is isbn10
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
  # run the output_raw_number method on the isbn number and use reverse indexing to return all but the last number
  all_but_last = output_raw_number(isbn)[0..-2]
  zipped = create_multipliers(isbn).zip(all_but_last.split(""))  # pair up each isbn character and multiplier in a multi-d array
  results = []  # initialize an empty array to hold the results from multiplying each pair of items in the zipped array
  sum = 0  # initialize a placeholder for adding up the resulting numbers from multiplying each pair in results array
  # iterate through each inner array, multiply each pair of items and push the product to the results array
  zipped.each { |x, y| results.push(x * y.to_i) }
  # next iterate through all of the products in the results array and add each product to the accumulating sum
  results.each { |number| sum += number }
  return sum  # return the sum
end

# Method to create the checksum value for a specified ISBN-10 or ISBN-13 number
def create_checksum(isbn)
  sum = create_sum(isbn)  # run the create_sum method to calculate the intermediate sum value
  if output_raw_number(isbn).length == 10  # if the number is isbn10
    checksum = sum % 11  # create the ISBN-10 checksum
  else  # otherwise the number is isbn13
    checksum = (10 - (sum % 10)) % 10 # create the ISBN-13 checksum
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

# Method to filter raw number if x is anywhere but the last character
def is_x_bad?(isbn)
  first_nine = output_raw_number(isbn).split("")[0..-2]  # create an array from first nine characters in raw isbn number
  invalid_character_count = 0  # counter for invalid characters
  first_nine.each do |character|  # iterate through array to check each character in the first nine
    if character == "x" || character == "X"  # if the current character is an x/X
      invalid_character_count += 1  # then increment the invalid character counter
      break  # since one invalid character is enough, break if we find one to save cycles
    end
  end
  # if x is anywhere but the last character return false, otherwise run valid_checksum?()
  if invalid_character_count > 0 then return false else valid_checksum?(isbn) end
end

# Method to filter number if it contains invalid characters
def are_characters_valid?(isbn)
  isbn_array = isbn.split("")  # create an array from characters in isbn number
  valid_characters = "0123456789 -xX".split("")  # create an array of valid isbn number characters
  invalid_character_count = 0  # counter for invalid characters
  isbn_array.each do |character|  # iterate through array to check each character in isbn number
    unless valid_characters.include?(character)  # if the current character is not in the valid characters array
      invalid_character_count += 1  # then increment the invalid character counter
      break  # since one invalid character is enough, break if we find one to save cycles
    end
  end
  # if the number has invalid characters return false, otherwise run is_x_bad?()
  if invalid_character_count > 0 then return false else is_x_bad?(isbn) end
end

# !!!First method to run!!!
# Method to filter number if it is too short to be ISBN10
def is_too_small?(isbn)
  # if the number is less than 10 characters long, it's not a valid isbn number
  if isbn.length < 10 then return false else are_characters_valid?(isbn) end
end

# Sandbox testing:
# puts output_raw_number("0-321-14653-0")  # ISBN-10
# puts output_raw_number("877 1 95 869x")  # ISBN-10
# puts output_raw_number("0471958697")  # ISBN-10
# puts output_raw_number("7421394761")  # ISBN-10
# puts output_raw_number("978-0-13-149505-0")  # ISBN-13
# puts output_raw_number("978 0 471 48648 0")  # ISBN-13
# puts output_raw_number("9780470059029")  # ISBN-13

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

# puts is_x_bad?("877 1 95 86x9")  # bad ISBN number
# puts is_x_bad?("877 1 95 869x")  # ISBN-10

# puts are_characters_valid?("0-321@14653-0")  # bad ISBN number
# puts are_characters_valid?("0-321-14653-0")  # ISBN-10
# puts are_characters_valid?("978 0 471 48648 0")  # ISBN-13

#####################################################################
# Run is_to_small?() to completely test ISBN-10 and ISBN-13 numbers #
#####################################################################

# puts is_too_small?("0-321-14653-0")  # ISBN-10
# puts is_too_small?("877 1 95 869x")  # ISBN-10
# puts is_too_small?("0471958697")  # ISBN-10
# puts is_too_small?("7421394761")  # ISBN-10
# puts is_too_small?("978-0-13-149505-0")  # ISBN-13
# puts is_too_small?("978 0 471 48648 0")  # ISBN-13
# puts is_too_small?("9780470059029")  # ISBN-13

# puts is_too_small?("4780470059029")  # bad ISBN number
# puts is_too_small?("0-321@14653-0")  # bad ISBN number
# puts is_too_small?("877195x869")  # bad ISBN number
# puts is_too_small?("")  # bad ISBN number
# puts is_too_small?(" ")  # bad ISBN number
# puts is_too_small?("-")  # bad ISBN number