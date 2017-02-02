# Program to determine if ISBN number is valid or not (true/false)

# Method to convert hyphenated or space-delimited ISBN number to raw number
def output_raw_number(isbn)
	raw_number = []
	hyphen = "-"
	space = " "
	isbn_array = isbn.split("")
	isbn_array.each do |character|
		if character != hyphen
			if character != space
				raw_number.push(character)
			end
		end
	end
	return raw_number.join("")
end

def all_but_last(isbn)
	raw_number = output_raw_number(isbn)
	trimmed = raw_number[0..-2]
	return trimmed
end

def create_checksum(isbn)
	trimmed = all_but_last(isbn)  # get all but last digit from raw isbn number
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
	checksum = sum % 11  # create the checksum by determining the remainder of the sum divided by 11 and return it
end

def compare_checksum(isbn)
	checksum = create_checksum(isbn)
	final = isbn[-1]
	if final == "x"
		return true if checksum.to_s == "10"
	elsif checksum.to_s == final
		return true
	else
		return false
	end
end

# puts output_raw_number("0-321-14653-0")
# puts output_raw_number("877 1 95 869x")
# puts output_raw_number("0471958697")
# puts output_raw_number("7421394761")

# puts all_but_last("0-321-14653-0")
# puts all_but_last("877 1 95 869x")
# puts all_but_last("0471958697")
# puts all_but_last("7421394761")

# puts create_checksum("0-321-14653-0")
# puts create_checksum("877 1 95 869x")
# puts create_checksum("0471958697")
# puts create_checksum("7421394761")

# puts compare_checksum("0-321-14653-0")
# puts compare_checksum("877 1 95 869x")
# puts compare_checksum("0471958697")
# puts compare_checksum("7421394761")
