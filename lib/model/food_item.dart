import 'package:flutter/material.dart';

FoodItemList foodItemList = FoodItemList(
  foodItems: [
    FoodItem(
      id: 1,
      title: "Beach BBQ Burger",
      hotel: "Las Vegas Hotel",
      price: 14.49,
      imgUrl:
          "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2361378440,2461312186&fm=26&gp=0.jpg",
    ),
    FoodItem(
        id: 2,
        title: "Kick Ass Burgers",
        hotel: "Dudleys",
        price: 11.99,
        imgUrl:
            "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2361378440,2461312186&fm=26&gp=0.jpg"),
    FoodItem(
        id: 3,
        title: "Supreme Pizza Burger",
        hotel: "Golf Course",
        price: 8.49,
        imgUrl:
            "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=907240224,3289246591&fm=26&gp=0.jpg"),
    FoodItem(
        id: 4,
        title: "Chilly Cheeze Burger",
        hotel: "Las Vegas Hotel",
        price: 14.49,
        imgUrl:
            "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1552784564,860854916&fm=26&gp=0.jpg"),
    FoodItem(
        id: 5,
        title: "Chilly Cheeze Burger",
        hotel: "Las Vegas Hotel",
        price: 14.49,
        imgUrl:
            "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1552784564,860854916&fm=26&gp=0.jpg"),
    FoodItem(
        id: 6,
        title: "Chilly Cheeze Burger",
        hotel: "Las Vegas Hotel",
        price: 14.49,
        imgUrl:
            "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1552784564,860854916&fm=26&gp=0.jpg"),
  ],
);

class FoodItemList {
  List<FoodItem> foodItems;

  FoodItemList({@required this.foodItems});
}

class FoodItem {
  int id;
  String title;
  String hotel;
  double price;
  String imgUrl;
  int quantity;

  FoodItem({
    @required this.id,
    @required this.title,
    @required this.hotel,
    @required this.price,
    @required this.imgUrl,
    this.quantity = 1,
  });

  void incrementQuantity() {
    this.quantity = this.quantity + 1;
  }

  void decrementQuantity() {
    this.quantity = this.quantity - 1;
  }
}
