import 'package:food_delivery/model/food_item.dart';

class CartProvider {
  List<FoodItem> foodItems = [];

  List<FoodItem> addToList(FoodItem foodItem) {
    bool isPresent = false;

    if (foodItems.length > 0) {
      for (int i = 0; i < foodItems.length; i++) {
        if (foodItems[i].id == foodItem.id) {
          increaseItemQuantity(foodItem);
          isPresent = true;
          break;
        } else {
          isPresent = false;
        }
      }

      if (!isPresent) {
        foodItems.add(foodItem);
      }
    } else {
      foodItems.add(foodItem);
    }

    return foodItems;
  }

  List<FoodItem> removeFromList(FoodItem foodItem) {
    if (foodItem.quantity > 1) {
      decreaseItemQuantity(foodItem);
    } else {
      foodItems.remove(foodItem);
    }
    return foodItems;
  }

  void increaseItemQuantity(FoodItem foodItem) => foodItem.incrementQuantity();

  void decreaseItemQuantity(FoodItem foodItem) => foodItem.decrementQuantity();
}
