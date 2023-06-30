import java.util.List;

public class Inventory {
  private List<Item> items;

  public Inventory(List<Item> items) {
    this.items = items;
  }

  public List<Item> getItems() {
    return items;
  }

  public void updatePrice() {
    items.forEach(item -> {
      if (item.name != "Fine Art" && item.name != "Concert Tickets") {
        if (item.price > 0) {
          if (item.name != "Gold Coins") {
            item.price = item.price - 1;
          }
        }
      } else {
        if (item.price < 50) {
          item.price = item.price + 1;
          if (item.name == "Concert Tickets") {
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
      if (item.name != "Gold Coins") {
        item.sellBy = item.sellBy - 1;
      }
      if (item.sellBy < 0) {
        if (item.name != "Fine Art") {
          if (item.name != "Concert Tickets") {
            if (item.price > 0) {
              if (item.name != "Gold Coins") {
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


  static class Item {
    public String name;
    public Integer sellBy;
    public Integer price;

    Item(String name, Integer sellBy, Integer price) {
      this.name = name;
      this.sellBy = sellBy;
      this.price = price;
    }

    public String toString() {
      return String.format("%s, %d, %d", name, sellBy, price);
    }
  }
}
