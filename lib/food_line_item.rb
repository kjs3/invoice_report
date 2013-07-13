#
# This class takes an array of values and translates 
# it into expected values of a food line item.
#

class FoodLineItem

  attr_accessor :date, :item, :quantity, :unit_price, :ext_price

  def initialize(line_array=nil, type=nil)
    if line_array and type
      case type
      when 'csv' then set_items_for_csv(line_array)
      when 'psv' then set_items_for_psv(line_array)
      end

      set_quantity_to_integer
      set_prices_in_cents
    end
  end

  private

  def set_items_for_csv(line_array)
    attr_order = %w(date item quantity unit_price ext_price)
    line_array.each_with_index do |attribute, i| 
      self.instance_variable_set("@#{attr_order[i]}", attribute)
    end
  end

  def set_items_for_psv(line_array)
    attr_order = %w(item quantity unit_price ext_price date)
    line_array.each_with_index do |attribute, i| 
      self.instance_variable_set("@#{attr_order[i]}", attribute)
    end
    tmp_date = @date.split("-")
    @date = [tmp_date[1], tmp_date[2], tmp_date[0]].join('/')
  end

  def set_quantity_to_integer
    @quantity = @quantity.to_i
  end

  def set_prices_in_cents
    @unit_price = (@unit_price.to_f * 100).to_i
    @ext_price = (@ext_price.to_f * 100).to_i
  end

end