import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snackeverywhere/Class/order.dart';

class OrderDetailScreen extends StatefulWidget {
  final Order order;

  const OrderDetailScreen({Key key, this.order}) : super(key: key);
  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  double screenWidth;
  double screenHeight;
  final df1 = new DateFormat('dd-MM-yyyy hh:mm a');
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary
              ]),
            ),
          ),
          title: Text(
            "Order Status",
            style: TextStyle(color: Theme.of(context).primaryColorDark),
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Invoice ID: " + widget.order.invoice_id,
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "Order ID: #" + widget.order.order_id,
              style: TextStyle(fontSize: 16),
            ),
            Container(
              width: double.infinity,
              child: Card(
                elevation: 10,
                color: Theme.of(context).backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: 150,
                                width: 150,
                                child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        "https://hubbuddies.com/270607/snackeverywhere/images/product/${widget.order.product_id}.png")),
                          ],
                        ),
                      ),
                      Text(
                        "Product ID: " + widget.order.product_id,
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Product Name: " + widget.order.product_name,
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Product Price: RM " + widget.order.product_price,
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Size: " + widget.order.product_size,
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Quantity: " + widget.order.o_quantity,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Card(
                elevation: 10,
                color: Theme.of(context).backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Date Order: " +
                            df1.format(DateTime.parse(widget.order.date_order)),
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Collect Option: " + widget.order.collect_option,
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Collect Date: " + widget.order.collect_date,
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Payment Option: " + widget.order.payment_option,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
