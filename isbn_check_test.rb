
require "minitest/autorun"
require_relative "isbn_check.rb"

class TestISBN < Minitest::Test

	def test_1_output_raw_number_source_with_hyphens
		isbn = "0-321-14653-0"
		results = output_raw_number(isbn)
		assert_equal("0321146530", results)
	end

	def test_2_output_raw_number_source_with_spaces
		isbn = "877 1 95 869x"
		results = output_raw_number(isbn)
		assert_equal("877195869x", results)
	end

	def test_3_no_change_in_ouput_if_raw_isbn_number
		isbn = "0471958697"
		results = output_raw_number(isbn)
		assert_equal("0471958697", results)
	end

	def test_4_return_all_but_last
		isbn = "7421394761"
		results = all_but_last(isbn)
		assert_equal("742139476", results)
	end

end