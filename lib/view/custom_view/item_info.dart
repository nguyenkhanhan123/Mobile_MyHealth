import 'package:flutter/material.dart';

class ItemInfo extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;

  const ItemInfo({
    super.key,
    required this.icon,
    required this.text,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.black, size: 24),
              SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: "SVN_Comic",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Align(
           alignment: Alignment.centerRight,
           child: Text(
             text,
             style: TextStyle(
               color: Colors.black,
               fontSize: 18,
               fontFamily: "SVN_Comic",
             ),
           ),
          )
        ],
      ),
    );
  }
}
