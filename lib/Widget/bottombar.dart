import 'package:flutter/material.dart';
import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
 
class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomBarWithSheet(
        selectedIndex: 0,
        sheetChild: Container(height:0),
        bottomBarTheme: BottomBarTheme(
            mainButtonPosition: MainButtonPosition.Middle,
            selectedItemBackgroundColor: Colors.yellow,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
            backgroundColor: Theme.of(context).colorScheme.primary,
            itemIconColor: Theme.of(context).primaryColorDark),
        mainActionButtonTheme: MainActionButtonTheme(
            size: 60,
            color: Colors.amber,
            icon: Icon(
              Icons.shopping_cart_sharp,
              color: Colors.white,
              size: 35,
            ),
            iconOpened: Icon(Icons.close, color: Colors.white, size: 35)),
        onSelectItem: (index) => print('item $index was pressed'),
        items: [
          BottomBarWithSheetItem(icon: Icons.home),
          BottomBarWithSheetItem(
            icon: Icons.favorite_outlined,
          ),
          BottomBarWithSheetItem(icon: Icons.message_rounded),
          BottomBarWithSheetItem(icon: Icons.settings)
        ],
      );
  }
}