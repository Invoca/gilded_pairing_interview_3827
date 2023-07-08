class Inventory
  def initialize(items)
    @items = items
  end

  def update_price
    @items.each do |item|
      item.update_item_for_day
    end
  end
end
