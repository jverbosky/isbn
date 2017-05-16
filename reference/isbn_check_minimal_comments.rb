# Program to determine if a specified ISBN number is valid or not (returns true/false)

# Method to convert hyphenated or space-delimited ISBN number to raw number
def output_raw_number(isbn)
  isbn.delete " -"
end

# Method to create an array of multipliers for calculating the checksum value (based on ISBN type)
def create_multipliers(isbn)
  multipliers = []
  output_raw_number(isbn).length == 10 ? (multipliers = (1..9).to_a) : 6.times { multipliers.push(1, 3) }
  return multipliers
end

# Method to create the intermediate sum value during checksum calculation
def create_sum(isbn)
  all_but_last = output_raw_number(isbn).chop
  multipliers = create_multipliers(isbn)
  sum = 0
  count = 0
  all_but_last.length.times { sum = sum + all_but_last[count].to_i * multipliers[count]; count += 1 }
  return sum
end

# Method to create the checksum value for a specified ISBN-10 or ISBN-13 number
def create_checksum(isbn)
  sum = create_sum(isbn)
  output_raw_number(isbn).length == 10 ? (checksum = sum % 11) : (checksum = (10 - (sum % 10)) % 10)
  return checksum
end

# Method to validate the calculated checksum value (via create_checksum) against the final digit of the ISBN number
def valid_checksum?(isbn)
  if isbn.index("x") == (isbn.length - 1) then true
    elsif isbn[-1] == create_checksum(isbn).to_s then true
    else false
  end
end

# Method to filter raw number if x is anywhere but the last character
def is_x_bad?(isbn)
  first_nine = isbn.chop
  (first_nine.include? "x") ? false : valid_checksum?(isbn)
end

# Method to filter number if it contains invalid characters
def are_characters_valid?(isbn)
  invalid = isbn.delete "xX0123456789 -"
  invalid.length > 0 ? false : is_x_bad?(isbn)
end

# Method to filter number if it is too short to be ISBN-10
def is_too_small?(isbn)
  isbn.length < 10 ? false : are_characters_valid?(isbn)
end

# Sandbox testing
puts is_too_small?("0-321-14653-0")  # ISBN-10
puts is_too_small?("877 1 95 869x")  # ISBN-10
puts is_too_small?("0471958697")  # ISBN-10
puts is_too_small?("7421394761")  # ISBN-10
puts is_too_small?("978-0-13-149505-0")  # ISBN-13
puts is_too_small?("978 0 471 48648 0")  # ISBN-13
puts is_too_small?("9780470059029")  # ISBN-13

puts is_too_small?("4780470059029")  # bad ISBN number
puts is_too_small?("0-321@14653-0")  # bad ISBN number
puts is_too_small?("877195x869")  # bad ISBN number
puts is_too_small?("")  # bad ISBN number
puts is_too_small?(" ")  # bad ISBN number
puts is_too_small?("-")  # bad ISBN number