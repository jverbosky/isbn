# Program to determine if a specified ISBN number is valid or not (returns true/false)

def output_raw_number(isbn)
  isbn.delete("-" " ")
end

def create_multipliers(isbn)
  multipliers = []
  output_raw_number(isbn).length == 10 ? (multipliers = (1..9).to_a) : 6.times { multipliers.push(1, 3) }
  return multipliers
end

def create_sum(isbn)
  all_but_last = output_raw_number(isbn).chop
  multipliers = create_multipliers(isbn)
  sum = 0
  count = 0
  all_but_last.length.times { sum = sum + all_but_last[count].to_i * multipliers[count]; count += 1 }
  return sum
end

def create_checksum(isbn)
  sum = create_sum(isbn)
  output_raw_number(isbn).length == 10 ? (checksum = sum % 11) : (checksum = (10 - (sum % 10)) % 10)
  return checksum
end

def valid_checksum?(isbn)
  if isbn.index("x") == (isbn.length - 1) then true
    elsif isbn[-1] == create_checksum(isbn).to_s then true
    else false
  end
end

def is_x_bad?(isbn)
  first_nine = isbn.chop
  (first_nine.include? "x") ? false : valid_checksum?(isbn)
end

def are_characters_valid?(isbn)
  invalid = isbn.delete "xX0123456789 -"
  invalid.length > 0 ? false : is_x_bad?(isbn)
end

def is_too_small?(isbn)
  isbn.length < 10 ? false : are_characters_valid?(isbn)
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