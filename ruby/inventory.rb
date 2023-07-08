# frozen_string_literal: true

class Inventory
  def initialize(items)
    @items = items
  end

  def update_price
    @items.each(&:update_item_for_day)
  end
end
