#isbn = "0471958697"
#isbn = "877195x869"
#isbn = "0-321-14653-0"
isbn = "877 1 95 869x"

# def output_raw_number(isbn)
#   raw_number = []
#   isbn_array = isbn.split("")
#   isbn_array.each do |character|
#     raw_number.push(character) if character != "-" && character != " "
#   end
#   return raw_number.join("")
# end

def output_raw_number(isbn)
    isbn.delete("-" " ")
end

print output_raw_number(isbn)