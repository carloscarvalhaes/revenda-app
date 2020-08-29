import 'package:flutter/material.dart';

class Bullet extends StatelessWidget {
  final String label;
  final bool enabled;

  const Bullet({Key key, this.label, this.enabled}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 15),
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            color: enabled ? Colors.blue : Colors.white,
            borderRadius: BorderRadius.circular(100),
            border: !enabled ? Border.all(color: Colors.grey) : null,
            boxShadow: enabled ? [
              BoxShadow(blurRadius: 1, spreadRadius: 10, color: Colors.grey[300])
            ] : null,
          ),
        ),
        Text(label)
      ],
    );
  }
}
