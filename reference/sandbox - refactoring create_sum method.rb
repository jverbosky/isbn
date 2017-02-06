isbn = "0471958697"
#isbn = "877 1 95 869x"
#isbn = "7421394761"
#isbn = "0-321-14653-0"

#isbn = "978-0-13-149505-0"
#isbn = "978 0 471 48648 0"
#isbn = "9780470059029"



# Method to filter raw number if x is anywhere but the last character
# def is_x_bad?(isbn)
#   first_nine = output_raw_number(isbn).split("")[0..-2]
#   invalid_character_count = 0
#   first_nine.each do |character|
#     if character == "x" || character == "X" then invalid_character_count += 1; break end
#   end
#   invalid_character_count > 0 ? (return false) : valid_checksum?(isbn)
# end

#puts is_x_bad?(isbn)


# def is_x_bad?(isbn)
#   first_nine = isbn.chop # string method, returns all but last character
#   (first_nine.include? "x") ? false : valid_checksum?(isbn)
# end

def create_multipliers(isbn)
  multipliers = []
  output_raw_number(isbn).length == 10 ? (multipliers = (1..9).to_a) : 6.times { multipliers.push(1, 3) }
  return multipliers
end

def output_raw_number(isbn)
    isbn.delete("-" " ")
end

def create_sum(isbn)
  all_but_last = output_raw_number(isbn)[0..-2]
  zipped = create_multipliers(isbn).zip(all_but_last.split(""))
  results = []
  sum = 0
  zipped.each { |x, y| results.push(x * y.to_i) }
  results.each { |number| sum += number }
  return sum
end

#isbn = "0471958697"
#isbn = "877195x869"

# def output_raw_number(isbn)
#     isbn.delete("-" " ")
# end

  all_but_last = output_raw_number(isbn).chop
  multipliers = create_multipliers(isbn)
  i = 0
  sum = 0
  all_but_last.length.times { sum = sum + all_but_last[i].to_i * multipliers[i]; i += 1 }
  puts sum  #240


puts create_sum(isbn)



