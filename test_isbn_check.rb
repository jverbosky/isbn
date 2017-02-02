
require "minitest/autorun"
require_relative "isbn_check.rb"

class TestIsbnCheck < Minitest::Test

	def test_1_output_raw_number_source_with_hyphens_isbn10
		isbn = "0-321-14653-0"
		results = output_raw_number(isbn)
		assert_equal("0321146530", results)
	end

	def test_2_output_raw_number_source_with_spaces_isbn10
		isbn = "877 1 95 869x"
		results = output_raw_number(isbn)
		assert_equal("877195869x", results)
	end

	def test_3_no_change_in_ouput_if_raw_isbn_number_isbn10
		isbn = "0471958697"
		results = output_raw_number(isbn)
		assert_equal("0471958697", results)
	end

	def test_4_output_raw_number_source_with_hyphens_isbn13
		isbn = "978-0-13-149505-0"
		results = output_raw_number(isbn)
		assert_equal("9780131495050", results)
	end

	def test_5_output_raw_number_source_with_spaces_isbn13
		isbn = "978 0 471 48648 0"
		results = output_raw_number(isbn)
		assert_equal("9780471486480", results)
	end

	def test_6_no_change_in_ouput_if_raw_isbn_number_isbn13
		isbn = "9780470059029"
		results = output_raw_number(isbn)
		assert_equal("9780470059029", results)
	end

	def test_7_return_all_but_last_isbn10_hyphens
		isbn = "0-321-14653-0"
		results = all_but_last(isbn)
		assert_equal("032114653", results)
	end

	def test_8_return_all_but_last_isbn10_spaces
		isbn = "877 1 95 869x"
		results = all_but_last(isbn)
		assert_equal("877195869", results)
	end

		def test_9_return_all_but_last_isbn10_raw
		isbn = "0471958697"
		results = all_but_last(isbn)
		assert_equal("047195869", results)
	end

	def test_10_return_all_but_last_isbn13_hyphens
		isbn = "978-0-13-149505-0"
		results = all_but_last(isbn)
		assert_equal("978013149505", results)
	end

	def test_11_return_all_but_last_isbn13_spaces
		isbn = "978 0 471 48648 0"
		results = all_but_last(isbn)
		assert_equal("978047148648", results)
	end

	def test_12_return_all_but_last_isbn13_raw
		isbn = "9780470059029"
		results = all_but_last(isbn)
		assert_equal("978047005902", results)
	end

	def test_13_create_checksum_isbn10_hyphen
		isbn = "0-321-14653-0"
		results = create_checksum_isbn10(isbn)
		assert_equal(0, results)
	end

	def test_14_create_checksum_isbn10_spaces
		isbn = "877 1 95 869x"
		results = create_checksum_isbn10(isbn)
		assert_equal(10, results)
	end

	def test_15_create_checksum_isbn10_raw
		isbn = "0471958697"
		results = create_checksum_isbn10(isbn)
		assert_equal(7, results)
	end

	def test_16_create_checksum_isbn13_hyphen
		isbn = "978-0-13-149505-0"
		results = create_checksum_isbn13(isbn)
		assert_equal(0, results)
	end

	def test_17_create_checksum_isbn13_spaces
		isbn = "978 0 471 48648 0"
		results = create_checksum_isbn13(isbn)
		assert_equal(0, results)
	end

	def test_18_create_checksum_isbn13_raw
		isbn = "9780470059029"
		results = create_checksum_isbn13(isbn)
		assert_equal(9, results)
	end

	def test_19_compare_checksum_isbn10_with_hyphens
		isbn = "0-321-14653-0"
		results = compare_checksum(isbn)
		assert_equal(true, results)
	end

	def test_20_compare_checksum_isbn10_with_spaces
		isbn = "877 1 95 869x"
		results = compare_checksum(isbn)
		assert_equal(true, results)
	end

	def test_21_compare_checksum_isbn10_raw
		isbn = "7421394761"
		results = compare_checksum(isbn)
		assert_equal(true, results)
	end

	def test_22_compare_checksum_isbn13_with_hyphens
		isbn = "978-0-13-149505-0"
		results = compare_checksum(isbn)
		assert_equal(true, results)
	end

	def test_23_compare_checksum_isbn13_with_spaces
		isbn = "978 0 471 48648 0"
		results = compare_checksum(isbn)
		assert_equal(true, results)
	end

	def test_24_compare_checksum_isbn13_raw
		isbn = "9780470059029"
		results = compare_checksum(isbn)
		assert_equal(true, results)
	end

	def test_25_create_multipliers_array_isbn_10
		multipliers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
		results = create_mutlipliers(isbn)
		assert_equal(multipliers, results)
	end

	def test_25_create_multipliers_array_isbn_13
		multipliers = [1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3]
		results = create_mutlipliers(isbn)
		assert_equal(multipliers, results)
	end


end