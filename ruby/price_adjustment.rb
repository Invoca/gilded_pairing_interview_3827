# frozen_string_literal: true

##
# This module provides a system to adjust the price of an item with respect to
# defined pricing strategies, which can depend on item's sell_by date.
# The strategies can either increase (appreciation) or decrease (depreciation) the price.
# It also provides a system to set a maximum and minimum price for the items.
#
module PriceAdjustment
  MAX_PRICE = 50
  MIN_PRICE = 0

  ##
  # Represents a single price adjustment strategy. It encapsulates the price change
  # value and potentially a date that it's applicable up to.
  #
  class Strategy
    attr_reader :price_change, :applicable_sell_by_date

    def initialize(price_change, applicable_sell_by_date: nil)
      @price_change = price_change
      @applicable_sell_by_date = applicable_sell_by_date
    end

    def apply(item)
      item.price += price_change if applicable?(item)
    end

    private

    def applicable?(item)
      return true if @applicable_sell_by_date.nil?

      item.sell_by <= @applicable_sell_by_date
    end
  end

  def self.included(base)
    base.extend ClassMethods
  end

  def pricing_strategies
    self.class.pricing_strategies
  end

  def maximum_price
    self.class.maximum_price
  end

  def minimum_price
    self.class.minimum_price
  end

  ##
  # This module provides class level methods for managing pricing strategies, max and min prices.
  #
  module ClassMethods
    def pricing_strategies
      @pricing_strategies ||= []
    end

    def maximum_price
      @maximum_price ||= MAX_PRICE
    end

    def has_maximum_price(maximum)
      @maximum_price = maximum
    end

    def minimum_price
      @minimum_price ||= MIN_PRICE
    end

    def has_minimum_price(minimum)
      @minimum_price = minimum
    end

    def add_appreciation_strategy(price_increase = 1, applicable_sell_by_date: nil)
      pricing_strategies << Strategy.new(price_increase.abs, applicable_sell_by_date:)
    end

    def add_depreciation_strategy(price_decrease = 1, applicable_sell_by_date: nil)
      pricing_strategies << Strategy.new(price_decrease.abs * -1, applicable_sell_by_date:)
    end
  end
end
