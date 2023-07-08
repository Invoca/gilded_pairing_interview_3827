# frozen_string_literal: true

require 'rspec'
require_relative '../main'

require 'simplecov'
SimpleCov.start

def item_should(description, &test_case)
  it description do
    test_case.call => {item:, becomes:}

    item = Item.new(asset_type, item[:sell_by], item[:price])
    item.update_item_for_day

    expect(item.sell_by).to eq(becomes[:sell_by])
    expect(item.price).to eq(becomes[:price])
  end
end
