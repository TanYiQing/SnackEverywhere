import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:snackeverywhere/Class/product.dart';
import 'package:snackeverywhere/Screen/Category/allitemScreen.dart';
import 'package:snackeverywhere/Screen/Category/candiesScreen.dart';
import 'package:snackeverywhere/Screen/Category/drinksScreen.dart';
import 'package:snackeverywhere/Screen/Category/nutsScreen.dart';
import 'package:snackeverywhere/Screen/Category/snackScreen.dart';
import 'package:snackeverywhere/Screen/Category/toysScreen.dart';
import 'package:snackeverywhere/Screen/Shopping%20Screen/cartListScreen.dart';
import 'package:snackeverywhere/Screen/Shopping%20Screen/productScreen.dart';
import 'package:snackeverywhere/Screen/searchScreen.dart';
import 'package:snackeverywhere/Widget/searchBar.dart';
import 'package:snackeverywhere/Class/user.dart';
import 'package:http/http.dart' as http;
import '../../Widget/drawer.dart';

class PlumsScreen extends StatefulWidget {
  final User user;

  const PlumsScreen({Key key, this.user}) : super(key: key);

  @override
  _PlumsScreenState createState() => _PlumsScreenState();
}

class _PlumsScreenState extends State<PlumsScreen> {
  double screenWidth;
  double screenHeight;
  var _screenRatio = 2;
  String _titlecenter = "Loading...";
  List _plumList;
  List _cartList;
  bool _isgridview = true;

  @override
  void initState() {
    super.initState();
    _loadproducts();
    _loadcart();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      endDrawer: SlidingDrawer(user: widget.user),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
            gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary
            ]),
          ),
        ),
        actions: [
          Stack(children: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (content) =>
                              CartListScreen(user: widget.user)));
                },
                icon: Icon(Icons.shopping_cart_outlined)),
            Positioned(
              right: 6.0,
              bottom: 6.0,
              child: Container(
                height: 18,
                width: 18,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Center(
                    child: Text(
                  (_cartList == null)
                      ? "0"
                      : _cartList[_cartList.length - 1]["t_quantity"],
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ]),
        ],
        title: GestureDetector(
              onTap: () {
               Navigator.push(context,MaterialPageRoute(builder: (content)=>SearchScreen(user:widget.user)));
              },
              child: SearchBar()),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(50))),
        bottom: PreferredSize(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(" Plums",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold)),
                    Container(
                        height: 40,
                        width: 40,
                        child: Image.asset("assets/images/plum.png"))
                  ],
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
            preferredSize: Size.fromHeight(70)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: screenWidth / 1.2,
                    height: 40,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (content) =>
                                            AllItemScreen(user: widget.user)));
                              },
                              child: category("All Items")),
                          SizedBox(width: 10),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (content) =>
                                            CandiesScreen(user: widget.user)));
                              },
                              child: category("Candy")),
                          SizedBox(width: 10),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (content) =>
                                            DrinksScreen(user: widget.user)));
                              },
                              child: category("Drink")),
                          SizedBox(width: 10),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (content) =>
                                            NutsScreen(user: widget.user)));
                              },
                              child: category("Nut")),
                          SizedBox(width: 10),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (content) =>
                                            PlumsScreen(user: widget.user)));
                              },
                              child: category("Plum")),
                          SizedBox(width: 10),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (content) =>
                                            SnackScreen(user: widget.user)));
                              },
                              child: category("Snack")),
                          SizedBox(width: 10),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (content) =>
                                            ToysScreen(user: widget.user)));
                              },
                              child: category("Toy"))
                        ]))),
                IconButton(
                  onPressed: () {
                    _changeGrid();

                    if (_isgridview == true) {
                      _screenRatio = 2;
                    } else {
                      _screenRatio = 1;
                    }
                    print(_isgridview);
                    print(_screenRatio);
                  },
                  icon: (_isgridview == true)
                      ? Icon(Icons.format_list_bulleted_sharp)
                      : Icon(Icons.grid_view),
                ),
               
              ],
            ),
            Container(
                child: _plumList == null
                    ? Flexible(
                        child: Center(
                            child: Container(
                          height: 20.0,
                          child: AnimatedTextKit(
                            animatedTexts: [
                              WavyAnimatedText(_titlecenter,
                                  textStyle: TextStyle(
                                      fontSize: 20,
                                      color:
                                          Theme.of(context).primaryColorDark))
                            ],
                            isRepeatingAnimation: true,
                          ),
                        )),
                      )
                    : Flexible(
                        child: Center(
                            child: GridView.count(
                                crossAxisCount: _screenRatio,
                                childAspectRatio:
                                    (screenWidth / screenHeight) / 0.65, //0.61,
                                children:
                                    List.generate(_plumList.length, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        _viewProduct(index);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color:
                                              Theme.of(context).backgroundColor,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                height: (_isgridview == true)
                                                    ? screenHeight / 5
                                                    : screenHeight / 2,
                                                width: double.infinity,
                                                child: CachedNetworkImage(
                                                    fit: BoxFit.cover,
                                                    imageUrl:
                                                        "https://hubbuddies.com/270607/snackeverywhere/images/product/${_plumList[index]['product_id']}.png")),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                child: Text(
                                                  checkProductName(
                                                      _plumList[index]
                                                          ['product_name']),
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: (_plumList[index][
                                                              'instock_qtysmall'] ==
                                                          "0" &&
                                                      _plumList[index][
                                                              'instock_qtylarge'] ==
                                                          "0")
                                                  ? Text("SOLD OUT",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color:
                                                              Colors.amber[800],
                                                          fontWeight:
                                                              FontWeight.bold))
                                                  : Row(
                                                      children: [
                                                        Text("RM ",
                                                            style: TextStyle(
                                                                fontSize: 12)),
                                                        Text(
                                                          _plumList[index][
                                                              'product_small_price'],
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color: Colors
                                                                  .amber[800],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        (_plumList[index][
                                                                    'product_large_price'] ==
                                                                "0.00")
                                                            ? Text("")
                                                            : Row(
                                                                children: [
                                                                  Text(" ~ "),
                                                                  Text("RM ",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12)),
                                                                  Text(
                                                                      _plumList[
                                                                              index]
                                                                          [
                                                                          'product_large_price'],
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                          color: Colors.amber[
                                                                              800],
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                ],
                                                              )
                                                      ],
                                                    ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                })))))
          ],
        ),
      ),
    );
  }

  Widget category(String title) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Center(
          child: Text(title,
              style: TextStyle(
                  color: Theme.of(context).primaryColorLight, fontSize: 18))),
    );
  }

  void _changeGrid() {
    setState(() {
      _isgridview = !_isgridview;
    });
  }

  String checkProductName(String productName) {
    if (productName.length < 15) {
      return productName;
    } else {
      return productName.substring(0, 15) + "...";
    }
  }

  void _loadproducts() {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/270607/snackeverywhere/php/loadProductsCategory.php"),
        body: {"product_cat": "Plum"}).then((response) {
      print(response.body);
      if (response.body == "nodata") {
        _titlecenter = "No Product";
        setState(() {});
        return;
      } else {
        var jsondata = json.decode(response.body);
        _plumList = jsondata["products"];
        setState(() {});
        print(_plumList);
      }
    });
  }

  void _viewProduct(int index) {
    Product product = new Product(
      product_id: _plumList[index]["product_id"],
      product_name: _plumList[index]["product_name"],
      product_desc: _plumList[index]["product_desc"],
      product_small_price: _plumList[index]["product_small_price"],
      product_small_qty: _plumList[index]["product_small_qty"],
      product_large_price: _plumList[index]["product_large_price"],
      product_large_qty: _plumList[index]["product_large_qty"],
      product_cat: _plumList[index]["product_cat"],
      instock_qtysmall: _plumList[index]["instock_qtysmall"],
      instock_qtylarge: _plumList[index]["instock_qtylarge"],
      datePublished: _plumList[index]["datePublished"],
    );

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (content) =>
                ProductScreen(product: product, user: widget.user)));
  }

  void _loadcart() {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/270607/snackeverywhere/php/loadCart.php"),
        body: {"email": widget.user.email}).then((response) {
      print(response.body);
      if (response.body == "Cart Empty") {
        _cartList = null;
        setState(() {});
        return;
      } else {
        var jsondata = json.decode(response.body);
        _cartList = jsondata["cart"];
        setState(() {});
        print(_cartList);
      }
    });
  }
}
