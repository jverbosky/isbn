#isbn = "0471958697"
isbn = "0-321@14653-0"

def are_characters_valid?(isbn)
  isbn_array = isbn.split("")
  valid_characters = "0123456789 -xX".split("")
  invalid_character_count = 0
  isbn_array.each do |character|
    unless valid_characters.include?(character) then invalid_character_count += 1; break end
  end
  invalid_character_count > 0 ? (return false) : (return true) #is_x_bad?(isbn)
end

#puts are_characters_valid?(isbn)

#valid_characters = "0123456789 -xX"

invalid = isbn.delete "xX0123456789 -"
invalid.length > 0 (return false) : return true

print invalid