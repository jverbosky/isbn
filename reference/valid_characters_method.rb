def valid_characters?(isbn)
  isbn_array = isbn.split("")  # create an array from characters in isbn number
  first_nine = isbn_array[0..-2]  # first nine elements of isbn_array to check for x
  valid_characters = "0123456789 -xX".split("")  # create an array of valid isbn number characters
  invalid_character_count = 0  # counter for invalid characters

  if isbn.length < 10
    return false
  end

  isbn_array.each do |character|  # iterate through array to check each character in isbn number
    unless valid_characters.include?(character)  # if the current character is not in the valid characters array
      puts "\n"
      puts character
      invalid_character_count += 1  # then increment the invalid character counter
      break  # one invalid character is enough, so break if we find one to save cycles
    end
  end

  first_nine.each do |character|  # iterate through array to check each character in the first nine
    if character == "x" || character == "X"  # if the current character is an x/X
      puts "\n"
      puts character
      invalid_character_count += 1  # then increment the invalid character counter
      break  # one invalid character is enough, so break if we find one to save cycles
    end
  end

  if invalid_character_count > 0  # if there are any invalid characters
    return false  # then return false
  else
    #valid_checksum?(isbn)  # otherwise, pass the isbn number to the valid_checksum? method
    return true
  end

end

# puts valid_characters?("0-321-14653-0")  # ISBN-10
# puts valid_characters?("877 1 95 869x")  # ISBN-10
# puts valid_characters?("0471958697")  # ISBN-10
# puts valid_characters?("7421394761")  # ISBN-10
# puts valid_characters?("978-0-13-149505-0")  # ISBN-13
# puts valid_characters?("978 0 471 48648 0")  # ISBN-13
# puts valid_characters?("9780470059029")  # ISBN-13

# Bad ISBN numbers
puts valid_characters?("4780470059029")  # passes character check, but fails on checksum check
puts valid_characters?("0-321@146e3-0")
puts valid_characters?("877195x8x9")
puts valid_characters?("")
puts valid_characters?(" ")
puts valid_characters?("-")