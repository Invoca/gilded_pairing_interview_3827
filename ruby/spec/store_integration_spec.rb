# frozen_string_literal: true

require 'spec_helper'

describe 'Gilded Rose store' do
  context 'A mixed inventory of items' do
    let(:items) do
      [
        {
          item: Item.new('Normal Item', 10, 20, 'Apple'),
          becomes: { sell_by: 9, price: 19 }
        },
        {
          item: Item.new('Fine Art', 10, 20, 'Mona Lisa'),
          becomes: { sell_by: 9, price: 21 }
        },
        {
          item: Item.new('Concert Tickets', 9, 20, 'Nickelback'),
          becomes: { sell_by: 8, price: 22 }
        },
        {
          item: Item.new('Gold Coins', 10, 80, 'Spanish Doubloons'),
          becomes: { sell_by: 10, price: 80 }
        },
        {
          item: Item.new('Materials', 10, 20, 'Copper Wire'),
          becomes: { sell_by: 9, price: 19 }
        }
      ]
    end
    let(:inventory) { Inventory.new(items.map { |item| item[:item] }) }
    before { inventory.update_price }

    it 'updated prices and sell_by for each item' do
      items.each do |test_case|
        item = test_case[:item]

        expect(item.sell_by).to eq(test_case[:becomes][:sell_by])
        expect(item.price).to eq(test_case[:becomes][:price])
      end
    end
  end
end
