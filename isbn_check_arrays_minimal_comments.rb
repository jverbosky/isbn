# Program to determine if a specified ISBN number is valid or not (returns true/false)
# Start with is_to_small?() method

# Method to convert hyphenated or space-delimited ISBN number to raw number
def output_raw_number(isbn)
  raw_number = []
  isbn_array = isbn.split("")
  isbn_array.each do |character|
    if character != "-" && character != " " then raw_number.push(character) end
  end
  return raw_number.join("")
end

# Method to create an array of multipliers for calculating the checksum value (based on ISBN type)
def create_multipliers(isbn)
  multipliers = []
  if output_raw_number(isbn).length == 10 then multipliers = (1..9).to_a
    else 6.times { multipliers.push(1); multipliers.push(3) }
  end
  return multipliers
end

# Method to create the intermediate sum value during checksum calculation
# This method consolidates the common statements for both ISBN types
def create_sum(isbn)
  all_but_last = output_raw_number(isbn)[0..-2]
  zipped = create_multipliers(isbn).zip(all_but_last.split(""))
  results = []
  sum = 0
  zipped.each { |x, y| results.push(x * y.to_i) }
  results.each { |number| sum += number }
  return sum
end

# Method to create the checksum value for a specified ISBN-10 or ISBN-13 number
def create_checksum(isbn)
  sum = create_sum(isbn)
  if output_raw_number(isbn).length == 10 then checksum = sum % 11
    else checksum = (10 - (sum % 10)) % 10
  end
  return checksum
end

# Method to validate the calculated checksum value (via create_checksum) against the final digit of the ISBN number
def valid_checksum?(isbn)
  final = isbn[-1]
  checksum = create_checksum(isbn)
  if final == "x" then return true if checksum.to_s == "10"
    elsif checksum.to_s == final then return true
    else return false
  end
end

# Method to filter raw number if x is anywhere but the last character
def is_x_bad?(isbn)
  first_nine = output_raw_number(isbn).split("")[0..-2]
  invalid_character_count = 0
  first_nine.each do |character|
    if character == "x" || character == "X" then invalid_character_count += 1; break end
  end
  if invalid_character_count > 0 then return false else valid_checksum?(isbn) end
end

# Method to filter number if it contains invalid characters
def are_characters_valid?(isbn)
  isbn_array = isbn.split("")
  valid_characters = "0123456789 -xX".split("")
  invalid_character_count = 0
  isbn_array.each do |character|
    unless valid_characters.include?(character) then invalid_character_count += 1; break end
  end
  if invalid_character_count > 0 then return false else is_x_bad?(isbn) end
end

# !!!First method to run!!!
# Method to filter number if it is too short to be ISBN10
def is_too_small?(isbn)
  if isbn.length < 10 then return false else are_characters_valid?(isbn) end
end

# Sandbox testing
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