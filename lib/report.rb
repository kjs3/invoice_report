require_relative 'invoice'

class Report

  attr_reader :invoices, :errors, :totals, :line_items

  def initialize(files=[])
    @errors = []
    @invoices = []
    @line_items = []
    @totals = []
    generate_invoices(files)
    sort_line_items
    calculate_totals
  end

  def calculate_totals
    tmp_totals = Hash.new(0)
    @line_items.each do |line|
      i = line.item
      q = line.quantity
      p = line.unit_price
      tmp_totals[i] += p * q
      @totals = tmp_totals.sort_by {|k,v| v}.reverse
    end
  end

  def sort_line_items
    @invoices.each do |invoice|
      invoice.line_items.each { |line| @line_items << line }
    end
    @line_items.sort!{|a,b| [a.date, a.item] <=> [b.date, b.item]}
  end

  def print(errors=nil)
    printf("\n\nAll Line Items\n\n")
    printf("%-10s %-24s %-7s %-12s %-12s\n", "Date", "Item", "Quant", "Unit Price", "Ext Price")
    @line_items.each do |line|
      printf("%-10s %-24s %-7s $%-11.2f $%-11.2f\n", line.date, line.item, line.quantity, line.unit_price.to_f/100, line.ext_price.to_f/100)
    end
    printf("\n\nTotal Spent per Item\n\n")
    printf("%-24s %-12s\n", "Item", "Total")
    @totals.each do |item|
      printf("%-24s %-12.2f\n", item[0], item[1].to_f/100)
    end
    printf("\n\n")
    if errors and !@errors.empty?
      printf("\nErrors\n\n")
      @errors.each do |e|
        puts e.message
      end
      puts "\n\n"
    end
  end

  private

  def generate_invoices(files)

    # rescue error and retry for as many files as there are
    # but don't allow an infinite loop
    error_retries = files.length

    files.each do |f|
      begin
        invoice = Invoice.new(f)
        @invoices << invoice
      rescue Exception => e
        if error_retries > 0
          error_retries -= 1
          @errors << e
          next
        else
          raise e
        end
      end
    end

  end

end