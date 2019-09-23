import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/bloc/cart_list_bloc.dart';
import 'package:food_delivery/bloc/list_style_color_bloc.dart';
import 'package:food_delivery/model/food_item.dart';

class Cart extends StatelessWidget {
  CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

  @override
  Widget build(BuildContext context) {
    List<FoodItem> foodItems;
    return StreamBuilder(
      stream: bloc.listStream,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          foodItems = snapshot.data;
          return Scaffold(
            body: SafeArea(
              child: Container(
                child: CartBody(foodItems),
              ),
            ),
            bottomNavigationBar: BottomBar(foodItems),
          );
        } else {
          return Scaffold();
        }
      },
    );
  }
}

// 底部详情栏(总价，人数，时长，订单提交)
class BottomBar extends StatelessWidget {
  final List<FoodItem> foodItems;

  BottomBar(this.foodItems);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 35, bottom: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          totalAmount(foodItems),
          Divider(
            height: 1,
            color: Colors.grey[700],
          ),
          persons(),
          nextButtonBar(),
        ],
      ),
    );
  }

  Container nextButtonBar() {
    return Container(
      margin: EdgeInsets.only(right: 25),
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Color(0xfffeb324),
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "15-25min",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              "Next",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container persons() {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Persons",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          CustomPersonWidget(),
        ],
      ),
    );
  }

  Container totalAmount(List<FoodItem> foodItems) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Total:",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            "\$${returnTotalAmount(foodItems)}",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 28,
            ),
          ),
        ],
      ),
    );
  }

  String returnTotalAmount(List<FoodItem> foodItems) {
    double totalAmount = 0.0;

    for (int i = 0; i < foodItems.length; i++) {
      totalAmount = totalAmount + foodItems[i].price * foodItems[i].quantity;
    }
    return totalAmount.toStringAsFixed(2);
  }
}

// 自定义人数
class CustomPersonWidget extends StatefulWidget {
  @override
  _CustomPersonWidgetState createState() => _CustomPersonWidgetState();
}

class _CustomPersonWidgetState extends State<CustomPersonWidget> {
  int noOfPersons = 1;
  double _buttonWidth = 30;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 25),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300], width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(vertical: 5),
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            width: _buttonWidth,
            height: _buttonWidth,
            child: FlatButton(
              child: Text(
                "-",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                setState(() {
                  if (noOfPersons > 1) {
                    noOfPersons--;
                  }
                });
              },
            ),
          ),
          Text(
            noOfPersons.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          SizedBox(
            width: _buttonWidth,
            height: _buttonWidth,
            child: FlatButton(
              child: Text(
                "+",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                setState(() {
                  noOfPersons++;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

// 产品整体页面
class CartBody extends StatelessWidget {
  final List<FoodItem> foodItems;

  CartBody(this.foodItems);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 40, 25, 0),
      child: Column(
        children: <Widget>[
          CustomeAppBar(),
          title(),
          Expanded(
            flex: 1,
            child: foodItems.length > 0 ? foodItemList() : noItemContainer(),
          ),
        ],
      ),
    );
  }

  Container noItemContainer() {
    return Container(
      child: Center(
        child: Text(
          "No more items left in the cart",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey[500],
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  ListView foodItemList() {
    return ListView.builder(
      itemCount: foodItems.length,
      itemBuilder: (build, index) {
        return CartListItem(foodItem: foodItems[index]);
      },
    );
  }

  Widget title() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "My",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 35,
                ),
              ),
              Text(
                "Order",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 35,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// 产品列表
class CartListItem extends StatelessWidget {
  final FoodItem foodItem;

  CartListItem({Key key, this.foodItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable(
      maxSimultaneousDrags: 1,
      data: foodItem,
      child: DraggableChild(foodItem: foodItem),
      feedback: DraggableChildFeedback(foodItem: foodItem),
      childWhenDragging: foodItem.quantity > 1
          ? DraggableChild(foodItem: foodItem)
          : Container(),
    );
  }
}

class DraggableChildFeedback extends StatelessWidget {
  final FoodItem foodItem;

  DraggableChildFeedback({Key key, this.foodItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorBloc colorBloc = BlocProvider.getBloc<ColorBloc>();

    return Opacity(
      opacity: 0.7,
      child: Material(
        child: StreamBuilder(
          stream: colorBloc.colorStream,
          builder: (context, snapshot) {
            return Container(
              margin: EdgeInsets.only(bottom: 25),
              decoration: BoxDecoration(
                color: snapshot.data != null ? snapshot.data : Colors.white,
              ),
              child: ItemContent(foodItem: foodItem),
            );
          },
        ),
      ),
    );
  }
}

class DraggableChild extends StatelessWidget {
  final FoodItem foodItem;

  DraggableChild({Key key, this.foodItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: ItemContent(foodItem: foodItem),
    );
  }
}

// 单条产品数据
class ItemContent extends StatelessWidget {
  final FoodItem foodItem;

  ItemContent({Key key, @required this.foodItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              foodItem.imgUrl,
              fit: BoxFit.fitHeight,
              height: 55,
              width: 80,
            ),
          ),
          RichText(
            text: TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
                children: [
                  TextSpan(text: foodItem.quantity.toString()),
                  TextSpan(text: " x "),
                  TextSpan(text: foodItem.title),
                ]),
          ),
          Text(
            "\$${foodItem.quantity * foodItem.price}",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}

// 自定义Appbar
class CustomeAppBar extends StatelessWidget {
  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(5),
          child: GestureDetector(
            child: Icon(
              Icons.arrow_back,
              size: 30,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        DragTargetWidget(bloc),
      ],
    );
  }
}

class DragTargetWidget extends StatefulWidget {
  final CartListBloc bloc;

  DragTargetWidget(this.bloc);

  @override
  _DragTargetWidgetState createState() => _DragTargetWidgetState();
}

class _DragTargetWidgetState extends State<DragTargetWidget> {
  final ColorBloc colorBloc = BlocProvider.getBloc<ColorBloc>();

  @override
  Widget build(BuildContext context) {
    FoodItem currentFoodItem;

    return DragTarget<FoodItem>(
      onAccept: (FoodItem foodItem) {
        currentFoodItem = foodItem;
        widget.bloc.removeFromList(currentFoodItem);
        colorBloc.setColor(Colors.white);
      },
      onWillAccept: (FoodItem foodItem) {
        colorBloc.setColor(Colors.red);
        return true;
      },
      onLeave: (FoodItem foodItem) {
        colorBloc.setColor(Colors.white);
      },
      builder: (BuildContext context, List incoming, List rejected) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(
            Icons.delete,
            size: 30,
          ),
        );
      },
    );
  }
}
