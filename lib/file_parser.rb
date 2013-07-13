
#
# The job of this class is to take a file and transform it
# into an array of arrays corresponding to lines of the file.
#
# This can then be read by another object and it can decide
# how to interpret the values in each row.
#
# This class also guesses if the file is comma or pipe separated
#

class FileParser

  attr_reader :filename, :type, :errors

  def initialize(filename, type=nil)
    raise "type argument needs to be 'csv' or 'psv'" unless type == 'csv' or type == 'psv' || !type
    @filename = filename
    # take the user defined type or determine it programmatically
    @type = type ? type : set_type
  end

  def rows
    data = []
    # run through each row in the file returning an array of values
    File.open(@filename, "r").each_line do |line|
      data << (@type == "csv" ? parse_csv_row(line) : parse_psv_row(line))
    end
    # return the array of arrays
    data
  rescue
    set_file_error
  end

  private

  def parse_csv_row(line)
    line.split(",").each {|s| s.strip!}.each {|s| s.gsub!(/[$€¢£¥₩₪₫₴₹]+/,"")}
  end
  def parse_psv_row(line)
    line.split("|").each {|s| s.strip!}.each {|s| s.gsub!(/[$€¢£¥₩₪₫₴₹]+/,"")}
  end

  def set_type
    commas = 0
    pipes = 0
    # read each line of the file and add up commas and pipes
    File.open(@filename, "r").each_line do |line|
      commas += line.count(",")
      pipes += line.count("|")
    end
    # whichever is greater is considered the type
    # this is obviously not bulletproof
    return commas > pipes ? "csv" : "psv"
  rescue Exception => e
    set_file_error
  end

  def set_file_error
    raise "There was an error reading file: #{@filename}"
  end

end