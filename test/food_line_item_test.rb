require "minitest/autorun"
require_relative "../lib/food_line_item"

class TestFoodLineItem < Minitest::Unit::TestCase

  def test_initialized_empty_line_item
    @line_item = FoodLineItem.new()
    assert_nil @line_item.date
    assert_nil @line_item.item
    assert_nil @line_item.quantity
    assert_nil @line_item.unit_price
    assert_nil @line_item.ext_price
  end

  def test_initialize_items_for_csv

    # expected output from parser
    items_array = ["7/13/2013", "Apple Golden Delicious", "2", "15.00", "30.00"]

    @line_item = FoodLineItem.new(items_array, "csv")

    assert_equal "7/13/2013", @line_item.date, "date is wrong"
    assert_equal "Apple Golden Delicious", @line_item.item, "item is wrong"
    assert_equal 2, @line_item.quantity, "quantity is wrong"
    assert_equal 1500, @line_item.unit_price, "unit_price is wrong"
    assert_equal 3000, @line_item.ext_price, "ext_price is wrong"
  end

  def test_initialize_items_for_psv

    # expected output from parser
    items_array = ["Beans Kidney", "2", "11", "22", "2013-7-11"]

    @line_item = FoodLineItem.new(items_array, "psv")

    assert_equal "7/11/2013", @line_item.date, "date is wrong"
    assert_equal "Beans Kidney", @line_item.item, "item is wrong"
    assert_equal 2, @line_item.quantity, "quantity is wrong"
    assert_equal 1100, @line_item.unit_price, "unit_price is wrong"
    assert_equal 2200, @line_item.ext_price, "ext_price is wrong"
  end

end