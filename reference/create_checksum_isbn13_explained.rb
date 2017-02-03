# Original ISBN13 number: 9780470059029
# Checksum is 9

trimmed = "978047005902"

def create_checksum_isbn13(trimmed)
  # trimmed = all_but_last(isbn)  # run the all_but_last method to get all but the last digit from raw isbn number
  isbn_array = trimmed.split("")  # split trimmed to create an array of numerical strings
  puts "Contents of isbn_array: #{isbn_array}"
  multipliers = []  # initialize an empty array to hold multipliers
  6.times { multipliers.push(1); multipliers.push(3) }  # create a 12-element array of alternating 1s and 3s
  puts "Contents of multipliers array: #{multipliers}"
  zipped = multipliers.zip(isbn_array)  # pair up each item from the isbn_array and multipliers arrays in a multi-d array
  puts "Contents of zipped array: #{zipped}"
  results = []  # initialize an empty array to hold the results from multiplying each pair of items in the zipped array
  sum = 0  # initialize a placeholder for adding up the resulting numbers from multiplying each pair in results array
  counter = 1
  zipped.each do |x, y|  # iterate through each inner array (item from isbn_array & item from multipliers array)
    result = x * y.to_i  # multiply each pair of items in the inner array (convert the isbn_array digit to an integer)
    puts "Iteration #{counter} - result: #{result}"
    results.push(result)  # push the resulting product to the results (placeholder) array
    puts "Iteration #{counter} - curent contents of results: #{results}"
    counter += 1
  end
  puts "Final contents of results array: #{results}"
  counter = 1
  results.each do |number|  # next iterate through all of the products in the results array
    sum += number  # add each product to the accumulating sum (i.e. 0+2=2, 2+1=3, 3+4=7, 7+2=9, 9+ etc...)
    puts "Iteration #{counter} - current sum: #{sum}"
    counter += 1
  end
  remainder = sum % 10  # determine the remainder of the sum divided by 10
  difference = 10 - remainder  # subtract the modulus from 10 to determine the difference
  isbn13_checksum = difference % 10  # create the checksum by determining the remainder of the difference divided by 10 and return it
  puts "ISBN13 checksum - #{sum} % 11: #{isbn13_checksum}"
end

create_checksum_isbn13(trimmed)