import 'package:al_datn_my_health/model/res/stat_drink_in_day_res.dart';
import 'package:flutter/material.dart';

import '../dialog/delete_stat_dialog.dart';

class ItemDrinkInDay extends StatelessWidget {
  final InfoDrinkInDay infoDrinkInDay;
  final VoidCallback onDelete;

  const ItemDrinkInDay({super.key, required this.infoDrinkInDay, required this.onDelete});

  String formatDateTime(DateTime dt) {
    String day = dt.day.toString().padLeft(2, '0');
    String month = dt.month.toString().padLeft(2, '0');
    String year = dt.year.toString();
    String hour = dt.hour.toString().padLeft(2, '0');
    String minute = dt.minute.toString().padLeft(2, '0');
    return "$day/$month/$year $hour:$minute";
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.all(4),
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: Colors.green, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(8),
              child: ClipRRect(
                child: Image.network(
                  infoDrinkInDay.thumbnail,
                  width: 32,
                  height: 32,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) => Image.asset(
                        'assets/images/ic_ingredients.png',
                        width: 32,
                        height: 32,
                        fit: BoxFit.cover,
                      ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Nước",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: "SVN_Comic",
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    "Đã thêm: ${formatDateTime(infoDrinkInDay.createdAt)}",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontFamily: "SVN_Comic",
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    "${infoDrinkInDay.amount} ${infoDrinkInDay.baseUnit} nước",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: "SVN_Comic",
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () async {
                final isDelete = await showDialog<bool>(
                  context: context,
                  builder: (context) => DeleteStatDialog(),
                );
                if (isDelete == true) {
                  onDelete();
                }
              },
              icon: Icon(Icons.delete, size: 28, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
