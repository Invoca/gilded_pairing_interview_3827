# frozen_string_literal: true

##
# This class represents an inventory containing a list of items.
# It provides the ability to update the price of each item in the inventory.
#
class Inventory
  def initialize(items)
    @items = items
  end

  def update_price
    @items.each(&:update_item_for_day)
  end
end
