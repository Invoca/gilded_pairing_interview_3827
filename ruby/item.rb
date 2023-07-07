class Item
    attr_accessor :name, :sell_by, :price
  
    def initialize(name, sell_by, price)
      @name = name
      @sell_by = sell_by
      @price = price
    end
  
    def to_s
      "#{@name}, #{@sell_by}, #{@price}"
    end
  end
  