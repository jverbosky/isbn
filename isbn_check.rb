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
	trimmed = isbn[0..-2]
	return trimmed
end

def create_checksum(trimmed)
	isbn_array = trimmed.split("")  # strings
	digits = trimmed.length
	multipliers = (1..digits).to_a  # integers
	results = []
	sum = 0
	zipped = multipliers.zip(isbn_array)
	zipped.each do |x, y|
	  result = x * y.to_i
	  results.push(result)
	end
	results.each do |number|
		sum += number
	end
	checksum = sum % 11
end

def compare_checksum(isbn, checksum)

end

# puts output_raw_number("0-321-14653-0")
# puts output_raw_number("877 1 95 869x")
# puts output_raw_number("0471958697")
# puts all_but_last("7421394761")
puts create_checksum("742139476")

