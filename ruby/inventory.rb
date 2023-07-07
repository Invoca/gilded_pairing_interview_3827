class Inventory
  def initialize(items)
    @items = items
  end

  def update_price
    @items.each do |item|
      if (item.name != 'Fine Art') && (item.name != 'Concert Tickets')
        item.price = item.price - 1 if item.price.positive? && (item.name != 'Gold Coins')
      elsif item.price < 50
        item.price = item.price + 1
        if item.name == 'Concert Tickets'
          item.price = item.price + 1 if item.sell_by < 11 && (item.price < 50)
          item.price = item.price + 1 if item.sell_by < 6 && (item.price < 50)
        end
      end
      item.sell_by = item.sell_by - 1 if item.name != 'Gold Coins'
      if item.sell_by.negative?
        if item.name != 'Fine Art'
          if item.name != 'Concert Tickets'
            item.price = item.price - 1 if item.price.positive? && (item.name != 'Gold Coins')
          else
            item.price = item.price - item.price
          end
        elsif item.price < 50
          item.price = item.price + 1
        end
      end
    end
  end
end
