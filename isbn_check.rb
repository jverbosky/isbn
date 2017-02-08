# Program to determine if a specified ISBN number is valid or not (returns true/false)
# Start with is_to_small?() method

# Method to convert hyphenated or space-delimited ISBN number to raw number
def output_raw_number(isbn)
    isbn.delete " -"  # the intersection (difference) of the number and delimiting characters
end

# Method to create an array of multipliers for calculating the checksum value (based on ISBN type)
def create_multipliers(isbn)
  multipliers = []  # initialize an empty array to hold multipliers
  # if the number is isbn10 create an array of integers (1 - 9) to multiply each isbn digit
  # otherwise it's isbn13 so create a 12-element array of alternating 1s and 3s
  output_raw_number(isbn).length == 10 ? (multipliers = (1..9).to_a) : 6.times { multipliers.push(1); multipliers.push(3) }
  return multipliers
end

# Method to create the intermediate sum value during checksum calculation
# This method consolidates the common statements for both ISBN types
def create_sum(isbn)
  all_but_last = output_raw_number(isbn).chop  # assign all but the last character in the isbn number to a variable
  multipliers = create_multipliers(isbn)  # collect the array of multipliers from the create_multipliers method
  sum = 0  # initialize a placeholder for adding up the resulting numbers from multiplying each pair in results array
  count = 0  # initialize a counter for iterating through the all_but_last string and multipliers array
  # iterate through every letter in the string, multiply it by every item in the array and then sum the products
  all_but_last.length.times { sum = sum + all_but_last[count].to_i * multipliers[count]; count += 1 }
  return sum  # return the sum
end

# Method to create the checksum value for a specified ISBN-10 or ISBN-13 number
def create_checksum(isbn)
  sum = create_sum(isbn)  # run the create_sum method to calculate the intermediate sum value
  # if the number is isbn10 create the ISBN-10 checksum, 0therwise the number is isbn13 so create the ISBN-13 checksum
  output_raw_number(isbn).length == 10 ? (checksum = sum % 11) : (checksum = (10 - (sum % 10)) % 10)
  return checksum  # return the checksum
end

# Method to validate the calculated checksum value (via create_checksum) against the final digit of the ISBN number
def valid_checksum?(isbn)
  if isbn.index("x") == (isbn.length - 1) then true  # if the number contains "x" and it is the last character, return true
    elsif isbn[-1] == create_checksum(isbn).to_s then true  # if the last character and the checksum are equal, return true
    else false  # otherwise, return false
  end
end

# Method to filter raw number if x is anywhere but the last character
def is_x_bad?(isbn)
  first_nine = isbn.chop  # assign the first nine characters to a variable
  # if x is in the first nine characters return false, otherwise run valid_checksum?()
  (first_nine.include? "x") ? false : valid_checksum?(isbn)
end

# Method to filter number if it contains invalid characters
def are_characters_valid?(isbn)
  invalid = isbn.delete "xX0123456789 -"  # the intersection (difference) of the number and valid characters
  # if the number has invalid characters return false, otherwise run is_x_bad?()
  invalid.length > 0 ? false : is_x_bad?(isbn)
end

# !!!First method to run!!!
# Method to filter number if it is too short to be ISBN-10
def is_too_small?(isbn)
  # if the number is less than 10 characters long, it's not a valid isbn number
  isbn.length < 10 ? (return false) : are_characters_valid?(isbn)
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