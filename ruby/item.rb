# frozen_string_literal: true

require_relative './price_adjustment'
require_relative './expiration'

##
# This module provides a factory pattern for creating different types of items.
# It defines the Base class from which specific item types inherit. Each item type
# includes the PriceAdjustment and Expiration modules, and can be further customized.
# 
module Item
  def self.class_for(asset_type)
    {
      'Fine Art' => FineArt,
      'Concert Tickets' => ConcertTickets,
      'Gold Coins' => GoldCoins
    }.fetch(asset_type, NormalItem)
  end

  def self.new(asset_type, sell_by, price, name = nil)
    class_for(asset_type).new(sell_by, price, name)
  end

  ##
  # Base class for items. It includes functionality from the PriceAdjustment and Expiration modules.
  # The Base class can be subclassed to create specific item types.
  #
  class Base
    include PriceAdjustment
    include Expiration

    attr_accessor :name, :sell_by, :price

    def initialize(sell_by, price, name)
      @name = name
      @sell_by = sell_by
      @price = price
    end

    def update_item_for_day
      update_sell_by
      update_price
      ensure_price_range
    end

    def to_s
      [asset_type, @sell_by, @price, @name].compact.join(', ')
    end

    private

    def asset_type
      self.class.name.split('::').last
    end

    def update_sell_by
      @sell_by -= 1 if expires?
    end

    def update_price
      pricing_strategies.each { |strategy| strategy.apply(self) }
    end

    def ensure_price_range
      @price = [minimum_price, [maximum_price, @price].min].max
    end
  end

  ##
  # NormalItem is a type of item that depreciates in price over time.
  #
  class NormalItem < Base
    add_depreciation_strategy
    add_depreciation_strategy applicable_sell_by_date: 0
  end

  ##
  # FineArt is a type of item that appreciates in price over time.
  #
  class FineArt < Base
    add_appreciation_strategy
    add_appreciation_strategy applicable_sell_by_date: 0
  end

  ##
  # ConcertTickets is a type of item that appreciates in price as the sell-by date approaches,
  # but becomes worthless after the sell-by date.
  #
  class ConcertTickets < Base
    add_appreciation_strategy
    add_appreciation_strategy applicable_sell_by_date: 10
    add_appreciation_strategy applicable_sell_by_date: 5
    add_depreciation_strategy Float::INFINITY, applicable_sell_by_date: 0
  end

  ##
  # GoldCoins is a type of item that does not expire and always retains a fixed price.
  #
  class GoldCoins < Base
    does_not_expire
    has_minimum_price 80
    has_maximum_price 80
  end
end
