class Inventory {
  constructor(items) {
    this.items = items;
  }

  updatePrice() {
    this.items.forEach((item) => {
      if (item.name !== 'Fine Art' && item.name !== 'Concert Tickets') {
        if (item.price > 0) {
          if (item.name !== 'Gold Coins') {
            item.price = item.price - 1;
          }
        }
      } else {
        if (item.price < 50) {
          item.price = item.price + 1;
          if (item.name === 'Concert Tickets') {
            if (item.sellBy < 11) {
              if (item.price < 50) {
                item.price = item.price + 1;
              }
            }
            if (item.sellBy < 6) {
              if (item.price < 50) {
                item.price = item.price + 1;
              }
            }
          }
        } 
      }
      if (item.name !== 'Gold Coins') {
        item.sellBy = item.sellBy - 1;
      }
      if (item.sellBy < 0) {
        if (item.name !== 'Fine Art') {
          if (item.name !== 'Concert Tickets') {
            if (item.price > 0) {
              if (item.name !== 'Cold Coins') {
                item.price = item.price - 1;
              }
            }
          } else {
            item.price = item.price - item.price;
          }
        } else {
          if (item.price < 50) {
            item.price = item.price + 1;
          }
        }
      }
    });
  }
}

class Item {
  constructor(name, sellBy, price) {
    this.name = name;
    this.sellBy = sellBy;
    this.price = price;
  }

  toString() {
    return `${this.name}, ${this.sellBy}, ${this.price}`
  }
}

module.exports = { Inventory, Item };