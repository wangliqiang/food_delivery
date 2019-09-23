import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/bloc/cart_list_bloc.dart';
import 'package:food_delivery/bloc/list_style_color_bloc.dart';
import 'package:food_delivery/cart.dart';
import 'package:food_delivery/model/food_item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => CartListBloc()),
        Bloc((i) => ColorBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Food Delivery",
        home: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            FistHalf(),
            SizedBox(height: 45),
            for (var foodItem in foodItemList.foodItems)
              ItemContainer(foodItem: foodItem),
          ],
        ),
      ),
    );
  }
}

class ItemContainer extends StatelessWidget {
  final FoodItem foodItem;

  ItemContainer({Key key, @required this.foodItem}) : super(key: key);

  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

  addToCart(FoodItem foodItem) {
    bloc.addToList(foodItem);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        addToCart(foodItem);

        final snackbar = SnackBar(
          content: Text("${foodItem.title} added to the cart"),
          duration: Duration(milliseconds: 550),
        );

        Scaffold.of(context).showSnackBar(snackbar);
      },
      child: Items(
        hotel: foodItem.hotel,
        itemName: foodItem.title,
        itemPrice: foodItem.price,
        imgUrl: foodItem.imgUrl,
        leftAligned: (foodItem.id % 2 == 0) ? true : false,
      ),
    );
  }
}

class Items extends StatelessWidget {
  final bool leftAligned;
  final String imgUrl;
  final String hotel;
  final String itemName;
  final double itemPrice;

  Items({
    Key key,
    @required this.leftAligned,
    @required this.imgUrl,
    @required this.hotel,
    @required this.itemName,
    @required this.itemPrice,
  });

  @override
  Widget build(BuildContext context) {
    double containerPadding = 45;
    double containerBorderRadius = 10;

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: leftAligned ? 0 : containerPadding,
            right: leftAligned ? containerPadding : 0,
          ),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 200,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.horizontal(
                    left: leftAligned
                        ? Radius.circular(0)
                        : Radius.circular(containerBorderRadius),
                    right: leftAligned
                        ? Radius.circular(containerBorderRadius)
                        : Radius.circular(0),
                  ),
                  child: Image.network(
                    imgUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.only(
                  left: leftAligned ? 20 : 0,
                  right: leftAligned ? 0 : 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            itemName,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Text(
                          "\$${itemPrice}",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                          ),
                          children: [
                            TextSpan(text: "by "),
                            TextSpan(
                              text: hotel,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: containerPadding),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// 首页上半部分
class FistHalf extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(35, 35, 0, 0),
      child: Column(
        children: <Widget>[
          CustomAppBar(),
          SizedBox(height: 30),
          title(),
          SizedBox(height: 30),
          searchBar(),
          SizedBox(height: 30),
          categories(),
        ],
      ),
    );
  }

  // title
  Widget title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: 25),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Food",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
            ),
            Text(
              "Delivery",
              style: TextStyle(fontWeight: FontWeight.w200, fontSize: 30),
            ),
          ],
        ),
      ],
    );
  }

  // searchbar
  Widget searchBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Icon(
          Icons.search,
          color: Colors.black45,
        ),
        SizedBox(width: 20),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search...",
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              hintStyle: TextStyle(color: Colors.black87),
            ),
          ),
        ),
      ],
    );
  }

  // category
  Widget categories() {
    return Container(
      height: 145,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          CategoryListItem(
            categoryIcon: Icons.bug_report,
            categoryName: "Burgers",
            availability: 12,
            selected: true,
          ),
          CategoryListItem(
            categoryIcon: Icons.bug_report,
            categoryName: "Pizzas",
            availability: 12,
            selected: false,
          ),
          CategoryListItem(
            categoryIcon: Icons.bug_report,
            categoryName: "Rolls",
            availability: 12,
            selected: false,
          ),
          CategoryListItem(
            categoryIcon: Icons.bug_report,
            categoryName: "Burgers",
            availability: 12,
            selected: false,
          ),
          CategoryListItem(
            categoryIcon: Icons.bug_report,
            categoryName: "Burgers",
            availability: 12,
            selected: false,
          ),
          CategoryListItem(
            categoryIcon: Icons.bug_report,
            categoryName: "Burgers",
            availability: 12,
            selected: false,
          ),
          CategoryListItem(
            categoryIcon: Icons.bug_report,
            categoryName: "Burgers",
            availability: 12,
            selected: false,
          ),
        ],
      ),
    );
  }
}

// appbar
class CustomAppBar extends StatelessWidget {
  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(Icons.menu),
          StreamBuilder(
            stream: bloc.listStream,
            builder: (context, snapshot) {
              List<FoodItem> foodItems = snapshot.data;
              int length = foodItems != null ? foodItems.length : 0;

              return buildGestureDetector(length, context, foodItems);
            },
          ),
        ],
      ),
    );
  }

  GestureDetector buildGestureDetector(
      int length, BuildContext context, List<FoodItem> foodItems) {
    return GestureDetector(
      onTap: () {
        if (length > 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Cart(),
            ),
          );
        } else {
          return;
        }
      },
      child: Container(
        margin: EdgeInsets.only(right: 30),
        child: Text(
          length.toString(),
          style: TextStyle(color: Colors.white),
        ),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.yellow[800],
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}

// categroy item
class CategoryListItem extends StatelessWidget {
  final IconData categoryIcon;
  final String categoryName;
  final int availability;
  final bool selected;

  CategoryListItem({
    Key key,
    @required this.categoryIcon,
    @required this.categoryName,
    @required this.availability,
    @required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      padding: EdgeInsets.fromLTRB(5, 5, 5, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: selected ? Color(0xfffeb325) : Colors.white,
        border: Border.all(
          color: selected ? Colors.transparent : Colors.grey[200],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[100],
            blurRadius: 15,
            offset: Offset(25, 0),
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: selected ? Colors.transparent : Colors.grey,
                width: 1,
              ),
            ),
            child: Icon(
              categoryIcon,
              color: Colors.black,
              size: 20,
            ),
          ),
          SizedBox(height: 5),
          Container(
            width: 50,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                categoryName,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
            width: 1,
            height: 10,
            color: Colors.black26,
          ),
          Text(
            availability.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
