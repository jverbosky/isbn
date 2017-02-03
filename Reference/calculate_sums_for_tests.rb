# Method to convert hyphenated or space-delimited ISBN number to raw number
def output_raw_number(isbn)
  raw_number = []  # initialize an empty array to hold each numerical character
  isbn_array = isbn.split("")  # create an array from characters in isbn number
  isbn_array.each do |character|  # iterate through array to check each character in isbn number
    if character != "-"  # if the character is not a hyphen
      if character != " "  # and if the character is not a space
        raw_number.push(character)  # then push the character (number) to the raw_number array
      end
    end
  end
  return raw_number.join("")  # use the .join method to convert the array into a numerical string and return it
end

def all_but_last(isbn)
  raw_number = output_raw_number(isbn)  # run the output_raw_number method on the isbn number
  trimmed = raw_number[0..-2]  # use reverse indexing to return all but the last number
end

def create_mutlipliers(isbn)
  raw_number = output_raw_number(isbn)  # get the raw isbn number
  if raw_number.length == 10  # if the number is isbn10
    multipliers = (1..9).to_a  # create an array of integers (1 - 9) to multiply each isbn digit
  else
    multipliers = []  # initialize an empty array to hold multipliers
    6.times { multipliers.push(1); multipliers.push(3) }  # create a 12-element array of alternating 1s and 3s
  end
  return multipliers
end

def create_checksum_isbn10(isbn)
  trimmed = all_but_last(isbn)  # run the all_but_last method to get all but the last digit from raw isbn number
  isbn_array = trimmed.split("")  # split trimmed to create an array of numerical strings

  multipliers = (1..9).to_a  # create an array of integers (1 - 9) to multiply each isbn digit
  # unique to isbn10

  zipped = multipliers.zip(isbn_array)  # pair up each item from the isbn_array and multipliers arrays in a multi-d array
  results = []  # initialize an empty array to hold the results from multiplying each pair of items in the zipped array
  sum = 0  # initialize a placeholder for adding up the resulting numbers from multiplying each pair in results array
  zipped.each do |x, y|  # iterate through each inner array (item from isbn_array & item from multipliers array)
    result = x * y.to_i  # multiply each pair of items in the inner array (convert the isbn_array digit to an integer)
    results.push(result)  # push the resulting product to the results (placeholder) array
  end
  results.each do |number|  # next iterate through all of the products in the results array
    sum += number  # add each product to the accumulating sum (i.e. 0+2=2, 2+1=3, 3+4=7, 7+2=9, 9+ etc...)
  end

  return sum

  # isbn10_checksum = sum % 11  # create the checksum by determining the remainder of the sum divided by 11 and return it
  # unique to isbn10

end

def create_checksum_isbn13(isbn)
  trimmed = all_but_last(isbn)  # run the all_but_last method to get all but the last digit from raw isbn number
  isbn_array = trimmed.split("")  # split trimmed to create an array of numerical strings

  multipliers = []  # initialize an empty array to hold multipliers
  6.times { multipliers.push(1); multipliers.push(3) }  # create a 12-element array of alternating 1s and 3s
  # unique to isbn13

  zipped = multipliers.zip(isbn_array)  # pair up each item from the isbn_array and multipliers arrays in a multi-d array
  results = []  # initialize an empty array to hold the results from multiplying each pair of items in the zipped array
  sum = 0  # initialize a placeholder for adding up the resulting numbers from multiplying each pair in results array
  zipped.each do |x, y|  # iterate through each inner array (item from isbn_array & item from multipliers array)
    result = x * y.to_i  # multiply each pair of items in the inner array (convert the isbn_array digit to an integer)
    results.push(result)  # push the resulting product to the results (placeholder) array
  end
  results.each do |number|  # next iterate through all of the products in the results array
    sum += number  # add each product to the accumulating sum (i.e. 0+2=2, 2+1=3, 3+4=7, 7+2=9, 9+ etc...)
  end

  return sum

  # remainder = sum % 10  # determine the remainder of the sum divided by 10
  # difference = 10 - remainder  # subtract the modulus from 10 to determine the difference
  # isbn13_checksum = difference % 10  # create the checksum by determining the remainder of the difference divided by 10 and return it
  # unique to isbn13

end


puts create_checksum_isbn10("0-321-14653-0")  # ISBN-10
puts create_checksum_isbn10("877 1 95 869x")  # ISBN-10
puts create_checksum_isbn10("0471958697")  # ISBN-10
puts create_checksum_isbn13("978-0-13-149505-0")  # ISBN-13
puts create_checksum_isbn13("978 0 471 48648 0")  # ISBN-13
puts create_checksum_isbn13("9780470059029")  # ISBN-13

