
require "minitest/autorun"
require_relative "isbn_check.rb"

class TestISBN < Minitest::Test

	def test_1_output_raw_number_source_with_hyphens
		isbn = "978-0-13-149505-0"
		results = output_raw_number(isbn)
		assert_equal(9780131495050, results)
	end

	def test_2_output_raw_number_source_with_spaces
		isbn = "978 0 13 149505 0"
		results = output_raw_number(isbn)
		assert_equal(9780131495050, results)
	end

end