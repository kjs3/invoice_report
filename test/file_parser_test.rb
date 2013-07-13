require "minitest/autorun"
require_relative "../lib/file_parser"

class TestFileParser < Minitest::Unit::TestCase
  def setup
    @file_comma = FileParser.new("line_items_comma.txt")
    @file_pipe = FileParser.new("line_items_pipe.txt")
    
  end

  def test_file_initialized
    assert @file_comma
    assert_equal "line_items_comma.txt", @file_comma.filename
  end
  def test_forcing_csv_on_psv_file
    @file = FileParser.new("line_items_pipe.txt", "csv")
    assert_equal "csv", @file.type
  end
  def test_forcing_psv_on_csv_file
    @file = FileParser.new("line_items_comma.txt", "psv")
    assert_equal "psv", @file.type
  end
  def test_error_raised_on_incorrect_type
    exception = assert_raises(RuntimeError) { FileParser.new("line_items_pipe.txt", "bar") }
    assert_equal "type argument needs to be 'csv' or 'psv'", exception.message
  end
  def test_file_error_raised_with_bad_file
    exception = assert_raises(RuntimeError) { FileParser.new("foo.txt") }
    assert_equal "There was an error reading file: foo.txt", exception.message
  end
  def test_file_error_raised_with_blank_filename
    exception = assert_raises(RuntimeError) { FileParser.new("") }
    assert_equal "There was an error reading file: ", exception.message
  end

  def test_comma_separated_file_sets_type_to_csv
    assert_equal "csv", @file_comma.type
  end
  def test_pipe_separated_file_sets_type_to_psv
    assert_equal "psv", @file_pipe.type
  end

  def test_comma_file_rows_returns_array_of_arrays
    assert (@file_comma.rows.is_a? Array)
    assert (@file_comma.rows[0].is_a? Array)
  end
  def test_pipe_file_rows_returns_array_of_arrays
    assert (@file_pipe.rows.is_a? Array)
    assert (@file_pipe.rows[0].is_a? Array)
  end
end