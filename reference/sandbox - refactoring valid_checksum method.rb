#isbn = "0471958697"
#isbn = "877195x869"
#isbn = "0-321-14653-0"
isbn = "877 1 95 869x"

# def valid_checksum?(isbn)
#   final = isbn[-1]
#   checksum = create_checksum(isbn)
#   if final == "x" then true if checksum.to_s == "10"
#     elsif checksum.to_s == final then true
#     else false
#   end
# end

#if isbn.index(-1) == "x" then print "yes" end

# print isbn.index("x")  # 12
# print isbn.length  # 13

if isbn.index("x") == (isbn.length - 1) then true
  elsif isbn[-1] == checksum.to_s then true
  else false
end
