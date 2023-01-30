import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CreateRowWidget extends StatefulWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onPressed;

  CreateRowWidget(this.text, this.icon,this.onPressed, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _CreateRowWidgetState();
  }}

class _CreateRowWidgetState extends State<CreateRowWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0) ,
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.text, style: TextStyle(color: Theme.of(context).textTheme.bodyText1?.color)),
          CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).primaryColor,
            child: IconButton(onPressed: widget.onPressed, icon: Icon(widget.icon), color: Theme.of(context).appBarTheme.foregroundColor),
          )
        ],
      ),
    );
  }

}