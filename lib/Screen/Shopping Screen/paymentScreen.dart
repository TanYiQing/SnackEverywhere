import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:snackeverywhere/Class/order.dart';
import 'package:snackeverywhere/Class/user.dart';
import 'package:snackeverywhere/Widget/bottombar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final Order order;

  const PaymentScreen({Key key, this.order}) : super(key: key);
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            IconButton(icon: Icon(Icons.arrow_back_outlined), onPressed: () {backhomepage();}),
        title: Text('Payment'),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: WebView(
                  initialUrl:
                      'https://hubbuddies.com/270607/snackeverywhere/php/generate_bill.php?email=' +
                          widget.order.email +
                          '&name=' +
                          widget.order.firstname +
                          " " +
                          widget.order.lastname +
                          '&subtotal=' +
                          widget.order.subtotal +
                          '&deliverycharge=' +
                          widget.order.deliverycharge +
                          '&discount=' +
                          widget.order.discount +
                          '&orderamount=' +
                          widget.order.orderAmount +
                          '&paymentoption=' +
                          widget.order.payment_option +
                          '&collectoption=' +
                          widget.order.collect_option +
                          '&collectdate=' +
                          widget.order.collect_date +
                          '&address=' +
                          widget.order.shipping_id,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void backhomepage() {
    String _email = widget.order.email;

    http.post(
        Uri.parse(
            "https://hubbuddies.com/270607/snackeverywhere/php/loginUser.php"),
        body: {"email": _email,}).then((response) {
      print(response.body);
      if (response.body == "Failed") {
      } else {
        List userdata = response.body.split("#");
        User user = new User(
          first_name: userdata[1],
          last_name: userdata[2],
          email: userdata[3],
          date_register: userdata[4],
          c_qty: userdata[5],
        );

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (content) => BottomBar(
                      user: user,
                    )));
      }
    });
  }
}
