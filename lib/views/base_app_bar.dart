import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget{
  final AppBar appBar;
  final List<Widget> widgets;

  const BaseAppBar({this.appBar, this.widgets});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Simple'),
            Text('News', style: TextStyle(color:Colors.blue, fontWeight: FontWeight.bold),)
          ],),
      elevation: 0,
      centerTitle: true,
      actions: widgets
    );
  }

  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}

