
require "minitest/autorun"
require_relative "isbn_check.rb"
#require_relative "isbn_check_minimal_comments.rb"

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

	def test_7_create_multipliers_array_isbn_10
		isbn = "7421394761"
		multipliers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
		results = create_multipliers(isbn)
		assert_equal(multipliers, results)
	end

	def test_8_create_multipliers_array_isbn_13
		multipliers = [1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3]
		isbn = "9780470059029"
		results = create_multipliers(isbn)
		assert_equal(multipliers, results)
	end

	def test_9_create_sum_isbn10_hyphen
		isbn = "0-321-14653-0"
		results = create_sum(isbn)
		assert_equal(154, results)
	end

	def test_10_create_sum_isbn10_spaces
		isbn = "877 1 95 869x"
		results = create_sum(isbn)
		assert_equal(307, results)
	end

	def test_11_create_sum_isbn10_raw
		isbn = "0471958697"
		results = create_sum(isbn)
		assert_equal(293, results)
	end

	def test_12_create_sum_isbn13_hyphen
		isbn = "978-0-13-149505-0"
		results = create_sum(isbn)
		assert_equal(100, results)
	end

	def test_13_create_sum_isbn13_spaces
		isbn = "978 0 471 48648 0"
		results = create_sum(isbn)
		assert_equal(130, results)
	end

	def test_14_create_sum_isbn13_raw
		isbn = "9780470059029"
		results = create_sum(isbn)
		assert_equal(101, results)
	end

	def test_15_create_checksum_isbn10_hyphen
		isbn = "0-321-14653-0"
		results = create_checksum(isbn)
		assert_equal(0, results)
	end

	def test_16_create_checksum_isbn10_spaces
		isbn = "877 1 95 869x"
		results = create_checksum(isbn)
		assert_equal(10, results)
	end

	def test_17_create_checksum_isbn10_raw
		isbn = "0471958697"
		results = create_checksum(isbn)
		assert_equal(7, results)
	end

	def test_18_create_checksum_isbn13_hyphen
		isbn = "978-0-13-149505-0"
		results = create_checksum(isbn)
		assert_equal(0, results)
	end

	def test_19_create_checksum_isbn13_spaces
		isbn = "978 0 471 48648 0"
		results = create_checksum(isbn)
		assert_equal(0, results)
	end

	def test_20_create_checksum_isbn13_raw
		isbn = "9780470059029"
		results = create_checksum(isbn)
		assert_equal(9, results)
	end

	def test_21_validate_checksum_isbn10_with_hyphens
		isbn = "0-321-14653-0"
		results = valid_checksum?(isbn)
		assert_equal(true, results)
	end

	def test_22_validate_checksum_isbn10_with_spaces
		isbn = "877 1 95 869x"
		results = valid_checksum?(isbn)
		assert_equal(true, results)
	end

	def test_23_validate_checksum_isbn10_raw
		isbn = "7421394761"
		results = valid_checksum?(isbn)
		assert_equal(true, results)
	end

	def test_24_validate_checksum_isbn13_with_hyphens
		isbn = "978-0-13-149505-0"
		results = valid_checksum?(isbn)
		assert_equal(true, results)
	end

	def test_25_validate_checksum_isbn13_with_spaces
		isbn = "978 0 471 48648 0"
		results = valid_checksum?(isbn)
		assert_equal(true, results)
	end

	def test_26_validate_checksum_isbn13_raw
		isbn = "9780470059029"
		results = valid_checksum?(isbn)
		assert_equal(true, results)
	end

  def test_27_return_true_if_no_misplaced_x
    isbn = "877 1 95 869x"
    results = is_x_bad?(isbn)
    assert_equal(true, results)
  end

  def test_28_return_false_if_x_not_last
    isbn = "877 1 95 86x9"
    results = is_x_bad?(isbn)
    assert_equal(false, results)
  end

	def test_29_return_true_if_all_characters_valid
		isbn = "978-0-13-149505-0"
		results = are_characters_valid?(isbn)
		assert_equal(true, results)
	end

	def test_30_return_false_if_any_characters_invalid
		isbn = "0-321@14653-0"
		results = are_characters_valid?(isbn)
		assert_equal(false, results)
	end

  def test_31_return_true_if_number_10_or_greater
    isbn = "978-0-13-149505-0"
    results = is_too_small?(isbn)
    assert_equal(true, results)
  end

  def test_32_return_false_if_number_less_than_10
    isbn = "-"
    results = is_too_small?(isbn)
    assert_equal(false, results)
  end

end