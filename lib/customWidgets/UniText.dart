import 'package:flutter/material.dart';

class uniTilte extends StatelessWidget {
  final String text;

  uniTilte({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.blue.shade900,
        fontSize: 17.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
