require_relative "tabstat/version"
require "optparse"
require "ostruct"
require_relative 'tabstat/operators/operators'
require_relative 'tabstat/core/core'


class TabStat

  def initialize
    @operator_map = { cut: Cut, max: Max }
    @default_delimiter = ","
    @delimiter = @default_delimiter
  end

  def parse_operation(op)
    p "parsing #{ op }"
    /(?<operation>\w+)\s*(?<params>.*)/ =~ op
    Operation.new(operation, params)
  end

  def parse_expression(e)
    if e == nil
      throw "No expression provided"
    end
    # TODO: This has to be fool proof to avoid escaped pipes
    @expressions = e.chomp.split('|').map { |op| parse_operation op }
  end

  def parse_params
    OptionParser.new do |opt|
      opt.on('-f', '--file_name FILENAME', 'Name of the file') { |o| @file_name = o }
      opt.on('-d', '--delimiter DELIMITER', 'Delimiter with which the tabular data to be split') { |o| @delimiter = (o or @default_delimiter) }
      opt.on('-e', '--exp expression', 'The expression to run on the data') { |e| @expression = parse_expression(e) }
    end.parse!
  end

  def read_data
    file = File.new(@file_name)

    @headers = file.gets.chomp.split(@delimiter).map{|s| s.strip}
    @result = []
    file.each do |row|
      # TODO Take care of avoid including the quotes and
      # take care of , coming in between the string.
      @result << @headers.zip(row.chomp.split(@delimiter)).to_h
    end
  end

  def row_to_csv_str(row)
    if row == nil
      ""
    else
      row.join(",").concat("\n")
    end

  end

  def to_csv_content(ctx)
    csv = ""
    headers = ctx.data.flat_map(&:keys).uniq
    csv.concat(row_to_csv_str(headers))
    ctx.data.each { |row|
      csv.concat(row_to_csv_str(row.values_at(*headers)))
    }
    csv
  end

  def run_expressions
    exp = @expression[0]
    @operator_map[exp.operator.to_sym].apply(Context.new(@result), exp.param)
  end

  def run
    parse_params
    read_data
    puts to_csv_content(run_expressions)
  end
end

TabStat.new.run
