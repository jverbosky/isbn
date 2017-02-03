# # Method to screen out ISBN numbers with invalid characters (before passing to other methods)
# def valid_characters?(isbn)
#   isbn_array = isbn.split("")  # create an array from characters in isbn number
#   first_nine = isbn_array[0..-2]  # first nine elements of isbn_array to check for x/X
#   valid_characters = "0123456789 -xX".split("")  # create an array of valid isbn number characters
#   invalid_character_count = 0  # counter for invalid characters
#   if isbn.length < 10  # if the number is less than 10, it's not a valid isbn number
#     return false  # so return false
#   end
#   isbn_array.each do |character|  # iterate through array to check each character in isbn number
#     unless valid_characters.include?(character)  # if the current character is not in the valid characters array
#       invalid_character_count += 1  # then increment the invalid character counter
#       break  # since one invalid character is enough, break if we find one to save cycles
#     end
#   end
#   first_nine.each do |character|  # iterate through array to check each character in the first nine
#     if character == "x" || character == "X"  # if the current character is an x/X
#       invalid_character_count += 1  # then increment the invalid character counter
#       break  # since one invalid character is enough, break if we find one to save cycles
#     end
#   end
#   if invalid_character_count > 0  # if there are any invalid characters
#     return false  # then return false
#   else
#     valid_checksum?(isbn)  # otherwise, pass the isbn number to the valid_checksum? method
#   end
# end

###############################################

def invalid_characters?(count)
  if count > 0  # if there are any invalid characters
    return true  # then return true
  else
    return false  # otherwise all characters are valid, so return false
    #valid_checksum?(isbn)  # otherwise, pass the isbn number to the valid_checksum? method
  end
end

def is_x_bad?(isbn)
  isbn_array = isbn.split("")  # create an array from characters in isbn number
  # Refactor this line so previous line isn't necessary:
  first_nine = isbn_array[0..-2]  # first nine elements of isbn_array to check for x/X
  invalid_character_count = 0  # counter for invalid characters
  first_nine.each do |character|  # iterate through array to check each character in the first nine
    if character == "x" || character == "X"  # if the current character is an x/X
      invalid_character_count += 1  # then increment the invalid character counter
      break  # since one invalid character is enough, break if we find one to save cycles
    end
  end
  #puts "is_x_bad invalid characters count: #{invalid_character_count}"
  if invalid_characters?(invalid_character_count) then return false else valid_checksum?(isbn) end
end

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
  #puts "are_characters_valid invalid characters count: #{invalid_character_count}"
  if invalid_characters?(invalid_character_count) then return false else is_x_bad?(isbn) end
end

def is_too_small?(isbn)
  isbn_array = isbn.split("")  # create an array from characters in isbn number
  # if isbn.length < 10  # if the number is less than 10, it's not a valid isbn number
  #   #puts "\nISBN: #{isbn}"
  #   #puts "is_too_small - false"
  #   return false  # so return false
  # else
  #   #puts "\nISBN: #{isbn}"
  #   are_characters_valid?(isbn)
  # end
  if isbn.lenth < 10 then return false else are_characters_valid?(isbn) end
end

# Bad ISBN numbers
is_too_small?("4780470059029")
is_too_small?("0-321@14653-0")
is_too_small?("877195x869")
is_too_small?("")
is_too_small?(" ")
is_too_small?("-")