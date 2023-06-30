class Inventory

  def initialize(items)
    @items = items
  end

  def update_price
    @items.each do |item|
      if item.name != "Fine Art" and item.name != "Concert Tickets"
        if item.price > 0
          if item.name != "Gold Coins"
            item.price = item.price - 1
          end
        end
      else
        if item.price < 50
          item.price = item.price + 1
          if item.name == "Concert Tickets"
            if item.sell_by < 11
              if item.price < 50
                item.price = item.price + 1
              end
            end
            if item.sell_by < 6
              if item.price < 50
                item.price = item.price + 1
              end
            end
          end
        end
      end
      if item.name != "Gold Coins"
        item.sell_by = item.sell_by - 1
      end
      if item.sell_by < 0
        if item.name != "Fine Art"
          if item.name != "Concert Tickets"
            if item.price > 0
              if item.name != "Gold Coins"
                item.price = item.price - 1
              end
            end
          else
            item.price = item.price - item.price
          end
        else
          if item.price < 50
            item.price = item.price + 1
          end
        end
      end
    end
  end
end

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
