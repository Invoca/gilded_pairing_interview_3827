import unittest

from main import Inventory, Item

class UnitTests(unittest.TestCase):
    def add_item_and_update_price(self, item):
        inventory = Inventory([item])
        inventory.update_price()
        return item

    def test_reduces_price_and_sellby_for_normal_items(self):
        item = self.add_item_and_update_price(Item(name="Normal Item", sell_by=10, price=9) )
        self.assertEqual(item.sell_by, 9)
        self.assertEqual(item.price, 8)

    def test_reduces_price_for_normal_items_past_sellby(self):
        item = self.add_item_and_update_price(Item(name="Normal Item", sell_by=-1, price=9))
        self.assertEqual(item.sell_by, -2)
        self.assertEqual(item.price, 7)

    def test_does_not_allow_price_to_go_negative(self):
        item = self.add_item_and_update_price(Item(name="Normal Item", sell_by=10, price=0))
        self.assertEqual(item.sell_by, 9)
        self.assertEqual(item.price, 0)     

    def test_increases_price_for_fine_art(self):
        item = self.add_item_and_update_price(Item(name="Fine Art", sell_by=10, price=20))
        self.assertEqual(item.price, 21)     

    def test_does_not_allow_price_of_fine_art_to_exceed_50(self):
        item = self.add_item_and_update_price(Item(name="Fine Art", sell_by=10, price=50))
        self.assertEqual(item.price, 50)

    def test_does_not_allow_price_of_concert_tickets_to_exceed_50(self):
        item = self.add_item_and_update_price(Item(name="Concert Tickets", sell_by=10, price=50))
        self.assertEqual(item.price, 50)

    def test_does_not_allow_gold_coins_to_exceed_80(self):
        item = self.add_item_and_update_price(Item(name="Gold Coins", sell_by=10, price=80))
        self.assertEqual(item.price, 80)
    
    def test_does_not_reduce_sell_by_for_gold_coins(self):
        item = self.add_item_and_update_price(Item(name="Gold Coins", sell_by=10, price=80))
        self.assertEqual(item.sell_by, 10)

    def test_increases_price_for_concert_tickets_by_1_when_sellby_is_more_than_10(self):
        item = self.add_item_and_update_price(Item(name="Concert Tickets", sell_by=12, price=20))
        self.assertEqual(item.price, 21)

    def test_increases_price_for_concert_tickets_by_2_when_sellby_is_between_6_and_10(self):
        item = self.add_item_and_update_price(Item(name="Concert Tickets", sell_by=7, price=20))
        self.assertEqual(item.price, 22)

    def test_increases_price_for_concert_tickets_by_3_when_sellby_is_less_than_6(self):
        item = self.add_item_and_update_price(Item(name="Concert Tickets", sell_by=5, price=20))
        self.assertEqual(item.price, 23)        

    def test_increases_price_for_concert_tickets_to_0_when_sellby_is_less_than_1(self):
        item = self.add_item_and_update_price(Item(name="Concert Tickets", sell_by=0, price=20))
        self.assertEqual(item.price, 0)        

unittest.main()
