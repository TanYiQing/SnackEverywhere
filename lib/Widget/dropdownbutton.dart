import 'package:flutter/material.dart';
import 'package:snackeverywhere/Class/s_address.dart';

class DropDownButton extends StatefulWidget {
  final S_Address s_address;// ignore: non_constant_identifier_names

  const DropDownButton({Key key, this.s_address}) : super(key: key);// ignore: non_constant_identifier_names
  @override
  _DropDownButtonState createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: DropdownButton(
          underline: SizedBox(),
          value: (widget.s_address.s_city != "") ? widget.s_address.s_city : "--",
          items: [
            DropdownMenuItem(
                child: Text("--", style: TextStyle(fontSize: 20)), value: "--"),
            DropdownMenuItem(
                child: Text("Balik Pulau", style: TextStyle(fontSize: 20)),
                value: "Balik Pulau"),
            DropdownMenuItem(
                child: Text("Batu Kawan", style: TextStyle(fontSize: 20)),
                value: "Batu Kawan"),
            DropdownMenuItem(
                child: Text("Bayan Lepas", style: TextStyle(fontSize: 20)),
                value: "Bayan Lepas"),
            DropdownMenuItem(
                child: Text("Bukit Mertajam", style: TextStyle(fontSize: 20)),
                value: "Bukit Mertajam"),
            DropdownMenuItem(
                child: Text("Bukit Tambun", style: TextStyle(fontSize: 20)),
                value: "Bukit Tambun"),
            DropdownMenuItem(
                child: Text("Butterworth", style: TextStyle(fontSize: 20)),
                value: "Butterworth"),
            DropdownMenuItem(
                child: Text("Gertak Sanggul", style: TextStyle(fontSize: 20)),
                value: "Gertak Sanggul"),
            DropdownMenuItem(
                child: Text("Kepala Batas", style: TextStyle(fontSize: 20)),
                value: "Kepala Batas"),
            DropdownMenuItem(
                child: Text("Mak Mandin", style: TextStyle(fontSize: 20)),
                value: "Mak Mandin"),
            DropdownMenuItem(
                child: Text("Nibong Tebal", style: TextStyle(fontSize: 20)),
                value: "Nibong Tebal"),
            DropdownMenuItem(
                child: Text("Penanti", style: TextStyle(fontSize: 20)),
                value: "Penanti"),
            DropdownMenuItem(
                child: Text("Perai", style: TextStyle(fontSize: 20)),
                value: "Perai"),
            DropdownMenuItem(
                child: Text("Permatang Pauh", style: TextStyle(fontSize: 20)),
                value: "Permatang Pauh"),
            DropdownMenuItem(
                child: Text("Pinang Tungal", style: TextStyle(fontSize: 20)),
                value: "Pinang Tunggal"),
            DropdownMenuItem(
                child: Text("Simpang Ampat", style: TextStyle(fontSize: 20)),
                value: "Simpang Ampat"),
            DropdownMenuItem(
                child: Text("Tasek Gelugor", style: TextStyle(fontSize: 20)),
                value: "Tasek Gelugor"),
            DropdownMenuItem(
                child: Text("Teluk Air Tawar", style: TextStyle(fontSize: 20)),
                value: "Teluk Air Tawar"),
            DropdownMenuItem(
                child: Text("Teluk Bahang", style: TextStyle(fontSize: 20)),
                value: "Teluk Bahang"),
            DropdownMenuItem(
                child: Text("Teluk Kumbar", style: TextStyle(fontSize: 20)),
                value: "Teluk Kumbar"),
            DropdownMenuItem(
                child: Text("Valdor", style: TextStyle(fontSize: 20)),
                value: "Valdor"),
          ],
          onChanged: (value) {
            _changecity(value);
          },
        ),
      ),
    );
  }

  void _changecity(String value) {
    setState(() {
      widget.s_address.s_city = value;
    });
  }
}
