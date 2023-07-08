# frozen_string_literal: true

require 'spec_helper'

describe Item do
  context '#to_s' do
    it 'prints the string equivalent of the item' do
      item = Item.new('TestItem', 10, 20, 'TestItem')

      expect(item.to_s).to eq('NormalItem, 10, 20, TestItem')
    end
  end

  describe 'Items with unknown asset types' do
    let(:asset_type) { 'Unknown' }

    item_should 'reduce price and sell_by by one each day' do
      {
        item: { sell_by: 10, price: 20 },
        becomes: { sell_by: 9, price: 19 }
      }
    end
  end

  describe Item::NormalItem do
    let(:asset_type) { 'Normal Item' }

    item_should 'reduce price and sell_by by one each day' do
      {
        item: { sell_by: 10, price: 20 },
        becomes: { sell_by: 9, price: 19 }
      }
    end

    item_should 'reduce price by 2 past sell_by' do
      {
        item: { sell_by: -1, price: 20 },
        becomes: { sell_by: -2, price: 18 }
      }
    end

    item_should 'not have a negative price' do
      {
        item: { sell_by: 10, price: 0 },
        becomes: { sell_by: 9, price: 0 }
      }
    end
  end

  describe Item::FineArt do
    let(:asset_type) { 'Fine Art' }

    item_should 'increase in price each day' do
      {
        item: { sell_by: 10, price: 20 },
        becomes: { sell_by: 9, price: 21 }
      }
    end

    item_should 'not increase in price above 50' do
      {
        item: { sell_by: 10, price: 50 },
        becomes: { sell_by: 9, price: 50 }
      }
    end

    item_should 'increase in price by two after sell_by' do
      {
        item: { sell_by: -1, price: 20 },
        becomes: { sell_by: -2, price: 22 }
      }
    end
  end

  describe Item::ConcertTickets do
    let(:asset_type) { 'Concert Tickets' }

    item_should 'increase in price each day' do
      {
        item: { sell_by: 40, price: 20 },
        becomes: { sell_by: 39, price: 21 }
      }
    end

    item_should 'increases price by two within 11 days of the concert' do
      {
        item: { sell_by: 10, price: 20 },
        becomes: { sell_by: 9, price: 22 }
      }
    end

    item_should 'increases price by three within 6 days of the concert' do
      {
        item: { sell_by: 5, price: 20 },
        becomes: { sell_by: 4, price: 23 }
      }
    end

    item_should 'be priced at 0 after the concert' do
      {
        item: { sell_by: -1, price: 20 },
        becomes: { sell_by: -2, price: 0 }
      }
    end
  end

  describe Item::GoldCoins do
    let(:asset_type) { 'Gold Coins' }

    item_should 'not increase in price or change sell_by time' do
      {
        item: { sell_by: 10, price: 80 },
        becomes: { sell_by: 10, price: 80 }
      }
    end

    item_should 'have a price of at least 80' do
      {
        item: { sell_by: 10, price: 50 },
        becomes: { sell_by: 10, price: 80 }
      }
    end

    item_should 'have a price of at most 80' do
      {
        item: { sell_by: 1, price: 100 },
        becomes: { sell_by: 1, price: 80 }
      }
    end
  end
end
