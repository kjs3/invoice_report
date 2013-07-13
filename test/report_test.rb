require "minitest/autorun"
require_relative "../lib/report"

class TestReport < Minitest::Unit::TestCase

  def test_initialized_report_takes_array_of_files_and_creates_invoices
    @report = Report.new(["line_items_comma.txt", "line_items_pipe.txt"])
    assert @report.invoices.is_a? Array
    assert @report.invoices[0].is_a? Invoice
  end
  def test_some_blank_files_adds_error
    @report_some_blank_files = Report.new(["line_items_comma.txt", "line_items_pipe.txt", "", ""])
    assert @report_some_blank_files.invoices.is_a? Array
    assert (@report_some_blank_files.invoices[0].is_a? Invoice)
    assert @report_some_blank_files.invoices.length == 2
    assert !@report_some_blank_files.errors.empty?
  end
  def test_some_nonexistent_files
    @report_some_bad_files = Report.new(["line_items_comma.txt", "line_items_pipe.txt", "foo.txt", "bar.txt"])
    assert @report_some_bad_files.invoices.is_a? Array
    assert (@report_some_bad_files.invoices[0].is_a? Invoice)
    assert @report_some_bad_files.invoices.length == 2
    assert !@report_some_bad_files.errors.empty?
  end
  def test_some_blank_and_nonexistent_files
    @report_some_bad_files = Report.new([" ", "", "line_items_comma.txt", "", " ", "line_items_pipe.txt", "foo.txt", "bar.txt"])
    assert @report_some_bad_files.invoices.is_a? Array
    assert (@report_some_bad_files.invoices[0].is_a? Invoice)
    assert @report_some_bad_files.invoices.length == 2
    assert !@report_some_bad_files.errors.empty?
  end

  def test_calculate_item_totals
    @report = Report.new(["line_items_comma.txt", "line_items_pipe.txt"])
    assert @report.totals.is_a? Array
    assert_equal @report.totals[0].last, 6400 
    assert_equal @report.totals[1].last, 4400
    assert_equal @report.totals[2].last, 3400
    assert_equal @report.totals[3].last, 2800 
    assert_equal @report.totals[4].last, 1700
  end

  def test_sorting_line_items_by_date_and_alpha
    @report = Report.new(["line_items_comma.txt", "line_items_pipe.txt"])
    assert_equal "Apple Golden Delicious", @report.line_items.first.item
    assert_equal "Rice Basmati 50#", @report.line_items[1].item
    assert_equal "Beans Kidney", @report.line_items[2].item
    assert_equal "Watermelon", @report.line_items[3].item
    assert_equal "Flour White 50#", @report.line_items[4].item
    assert_equal "Watermelon", @report.line_items[5].item
    assert_equal "Apple Golden Delicious", @report.line_items[6].item
    assert_equal "Beans Kidney", @report.line_items.last.item
  end

end