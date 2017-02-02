# Program to determine if ISBN number is valid or not (true/false)

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

def all_but_last(isbn)
	raw_number = output_raw_number(isbn)  # run the output_raw_number method on the isbn number
	trimmed = raw_number[0..-2]  # use reverse indexing to return all but the last number
end

def create_checksum_isbn10(isbn)
	trimmed = all_but_last(isbn)  # run the all_but_last method to get all but the last digit from raw isbn number
	isbn_array = trimmed.split("")  # split trimmed to create an array of numerical strings
	digits = trimmed.length  # create a count of the number of digits in the trimmed isbn number
	multipliers = (1..digits).to_a  # create an array of integers (1 - n) to multiple each isbn digit
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
	isbn10_checksum = sum % 11  # create the checksum by determining the remainder of the sum divided by 11 and return it
end

def create_checksum_isbn13(isbn)
	trimmed = all_but_last(isbn)  # run the all_but_last method to get all but the last digit from raw isbn number
	isbn_array = trimmed.split("")  # split trimmed to create an array of numerical strings
	digits = trimmed.length  # create a count of the number of digits in the trimmed isbn number
	multipliers = []  # initialize an empty array to hold multipliers
	6.times { multipliers.push(1); multipliers.push(3) }  # create a 12-element array of alternating 1s and 3s
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
	remainder = sum % 10  # determine the remainder of the sum divided by 10
	difference = 10 - remainder  # subtract the modulus from 10 to determine the difference
	isbn13_checksum = difference % 10  # create the checksum by determining the remainder of the difference divided by 10 and return it
end

def compare_checksum(isbn)
	checksum = create_checksum_isbn10(isbn)  # run the create_checksum method to get the checksum for the isbn number
	final = isbn[-1]  # use reverse indexing to get the last character from the isbn number
	if final == "x"  # if the last character in the isbn number is an "x"
		return true if checksum.to_s == "10"  # then return true if the checksum is "10" (x == 10)
	elsif checksum.to_s == final  # if not, see if the checksum (converted to a string) equals the last character
		return true  # and if so, then return true
	else
		return false  # otherwise, return false
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

# puts create_checksum_isbn10("0-321-14653-0")  # ISBN-10
# puts create_checksum_isbn10("877 1 95 869x")  # ISBN-10
# puts create_checksum_isbn10("0471958697")  # ISBN-10
# puts create_checksum_isbn10("7421394761")  # ISBN-10
# puts create_checksum_isbn13("978-0-13-149505-0")  # ISBN-13
# puts create_checksum_isbn13("978 0 471 48648 0")  # ISBN-13
# puts create_checksum_isbn13("9780470059029")  # ISBN-13

# puts compare_checksum("0-321-14653-0")  # ISBN-10
# puts compare_checksum("877 1 95 869x")  # ISBN-10
# puts compare_checksum("0471958697")  # ISBN-10
# puts compare_checksum("7421394761")  # ISBN-10
# puts compare_checksum("978-0-13-149505-0")  # ISBN-13
# puts compare_checksum("978 0 471 48648 0")  # ISBN-13
# puts compare_checksum("9780470059029")  # ISBN-13
