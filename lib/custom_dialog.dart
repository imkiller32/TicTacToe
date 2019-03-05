import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final title;
  final content;
  final VoidCallback callback;
  final actionText;
  
  CustomDialog(this.title, this.content, this.callback,
      [this.actionText = "Reset"]);
  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: new Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      content: new Text(content),
      actions: <Widget>[
        new FlatButton(
          onPressed: callback,
          //color: Colors.white,
          child: new Text(actionText),
        )
      ],
    );
  }
}