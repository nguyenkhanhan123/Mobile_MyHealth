import 'package:flutter/material.dart';

class ItemTitle extends StatelessWidget {
  final IconData icon;
  final String text;

  const ItemTitle({super.key,required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
           icon,
            color: Colors.black,
            size: 24,
          ),
          SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: "SVN_Comic",
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
