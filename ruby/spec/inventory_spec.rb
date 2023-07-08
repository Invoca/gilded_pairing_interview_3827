# frozen_string_literal: true

require 'spec_helper'

describe 'Inventory' do
  context '#update_price' do
    let(:item) { double('item') }
    let(:inventory) { Inventory.new([item]) }

    it 'calls update_item_for_day on each item in the inventory' do
      expect(item).to receive(:update_item_for_day)
      inventory.update_price
    end
  end
end
