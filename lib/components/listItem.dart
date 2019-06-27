import 'package:flutter/material.dart';

class ListItem extends StatefulWidget{
  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem>{
 @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      child: Text('123'),
    );
  }
}