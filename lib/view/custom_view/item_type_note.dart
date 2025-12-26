import 'package:flutter/material.dart';

class ItemTypeNote extends StatelessWidget {
  final String pathImg;
  final String text;
  final String text2;
  final VoidCallback? onPressed;

  const ItemTypeNote({
    super.key,
    required this.pathImg,
    required this.text,
    required this.onPressed,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(pathImg, width: 82, height: 82),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontFamily: "SVN_Comic",
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: onPressed,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue,
                    backgroundColor: Color.fromARGB(255, 215, 236, 255),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  icon: Icon(Icons.add_circle, size: 16),
                  label: Text(
                    text2,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: TextStyle(fontSize: 14, fontFamily: "SVN_Comic"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
