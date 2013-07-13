require_relative 'file_parser'
require_relative 'food_line_item'

class Invoice

  attr_accessor :filename
  attr_reader :line_items

  def initialize(filename=nil)
    @filename = filename
    @line_items = filename ? read_file : []
  end

  # make sure to update line_items if filename is changed
  def filename=(filename)
    initialize(filename)
  end

  private

  def read_file
    line_items = []
    parser = FileParser.new(filename)
    parser.rows.each do |row|
      line_items << FoodLineItem.new(row, parser.type)
    end
    line_items
  rescue Exception => e
    raise e
  end
  
end