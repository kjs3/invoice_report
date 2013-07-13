require "minitest/autorun"
require_relative "../lib/invoice"

class TestInvoice < Minitest::Unit::TestCase
  def setup
    @invoice_comma = Invoice.new("line_items_comma.txt")
    @invoice_pipe = Invoice.new("line_items_pipe.txt")
  end

  def test_initialized_invoice_with_filename
    assert @invoice_comma.filename
    assert @invoice_comma.line_items
    assert @invoice_pipe.filename
    assert @invoice_pipe.line_items
  end
  def test_blank_filename_raises_error
    exception = assert_raises(RuntimeError) { Invoice.new("") }
    assert_equal "There was an error reading file: ", exception.message
  end
  def test_missing_file_raises_error
    exception = assert_raises(RuntimeError) { Invoice.new("foo.txt") }
    assert_equal "There was an error reading file: foo.txt", exception.message
  end

  def test_line_items_got_set
    assert !@invoice_comma.line_items.empty?
    assert @invoice_comma.line_items[0].is_a? FoodLineItem
  end
  def test_filename_changed_changes_line_items
    orig_line_item = @invoice_comma.line_items[0]
    @invoice_comma.filename = "line_items_pipe.txt"
    assert orig_line_item != @invoice_comma.line_items[0]
  end
end