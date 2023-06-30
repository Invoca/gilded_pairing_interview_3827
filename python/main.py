class Inventory:
  def __init__(self, items):
    self.items = items

  def update_price(self):
    for item in self.items:
      if item.name != "Fine Art" and item.name != "Concert Tickets":
        if item.price > 0:
          if item.name != "Gold Coins":
            item.price = item.price - 1
      else:
        if item.price < 50:
          item.price = item.price + 1
          if item.name == "Concert Tickets":
            if item.sell_by < 11:
              if item.price < 50:
                item.price = item.price + 1
            if item.sell_by < 6:
              if item.price < 50:
                item.price = item.price + 1
      if item.name != "Gold Coins":
        item.sell_by = item.sell_by - 1
      if item.sell_by < 0:
        if item.name != "Fine Art":
          if item.name != "Concert Tickets":
            if item.price > 0:
              if item.name != "Gold Coins":
                item.price = item.price - 1
          else:
            item.price = item.price - item.price
        else:
          if item.price < 50:
            item.price = item.price + 1

class Item:
  def __init__(self, name, sell_by, price):
    self.name = name
    self.sell_by = sell_by
    self.price = price

  def __repr__(self):
    return f'{self.name}, {self.sell_by}, {self.price}'
