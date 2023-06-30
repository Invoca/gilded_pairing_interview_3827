# Requirements Specification

Hi and welcome to the team. As you know, we are a small shop with a prime location in a
prominent city run by a friendly shopkeep named Allison. We buy and sell many of the finest goods.
Unfortunately, our goods are constantly decreasing in price as they approach their sell by date. We
have a system in place that updates our inventory for us. It was developed by a no-nonsense type named
Leeroy, who has moved on to new adventures.

Your task is to refactor our system to make it more maintainable and extensible. First, an introduction to our system:

- All items have a `sell_by` value which denotes the number of days we have left to sell the item before it expires
- All items have a `price` value which denotes how much the item costs
- At the end of each day our system adjusts both values for every item

Pretty simple, right? Well this is where it gets interesting:

- Once the sell by date has passed, `price` decreases twice as fast
- The `price` of an item is never negative
- **Fine Art** actually increases in `price` the older it gets
  - And, similar to normal items, **Fine Art** increases in `price` twice as fast once the sell by date has passed
- **Gold Coins**, being an hard asset, never have to be sold and they never decrease in `price`
- The `price` of an item is never more than 50. Except for **Gold Coins**. They are so valuable that their `price` is 80
- **Concert Tickets** increase in `price` the closer `sell_by` gets to zero:
  - `price` increases by 2 when there are 10 days or less and by 3 when there are 5 days or less
  - `price` drops to 0 after the concert

While our system does work as specified above, it is a little convoluted. Whenever we need to fix bugs in our system, or add new functionality to it, we find that we need to take extra time to re-parse and re-understand the code.

We need you to refactor the system to make it easier to understand and work with, while maintaining all the same functionality.

### Interview Guidelines:
* There are sub-directories that hold implementations of our system in four different languages: Java, Javascript, Python, and Ruby. Choose whichever language you're most comfortable with to complete your refactor.
* This is not timed, but we recommend you spend about 60 minutes on the refactor.
* Feel free to Google things while you work.
* Add/change code as much as you like, as long as everything still works correctly.
* Commit and push your code when your refactor is complete.
* We will schedule a follow-up call to review your refactor, so you can walk us through your approach and considerations.
