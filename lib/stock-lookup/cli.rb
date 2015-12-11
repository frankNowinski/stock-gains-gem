module StockLookup
end 
class StockLookup::CLI
  attr_accessor :total

  def initialize
    @total = 0
  end

  def call
    list
    calculate_net
    print_net_profit
  end

  def list
    puts "\n"
    puts "Stocks in Your Portfolio".center(42)
    puts " " + "-" * 38
    StockLookup::Stocks.all.each.with_index(1) do |stock, i| 
      puts " #{i}. #{stock.name} "
    end
    puts 
  end

  def calculate_net
    StockLookup::Stocks.all.each do |s|
      @total += (s.current_price.to_f * s.shares.to_i) - (s.previous_close.to_f * s.shares.to_f)
    end
    @total = @total.round(2).to_f 
  end

  def print_net_profit
    puts "\n"
    puts " " * 8 + ":" + "-" * 21 + ":"
    puts " " * 8 + "| NET #{total > 0 ? "PROFIT:" : "LOSS:"} $#{total}#{extra_spaces}|"
    puts " " * 8 + ":" + "-" * 21 + ":"
    puts "\n"
  end

  def extra_spaces
    spaces = ""
    case total.to_s.each_char.count 
    when 8 
      return spaces = " "
    when 6 
      spaces = " "
    when 5
      spaces = "  "
    when 4
      spaces = "   "
    when 3
      spaces = "    "
    end
    spaces += "  " if total < 0
    spaces
  end
end





