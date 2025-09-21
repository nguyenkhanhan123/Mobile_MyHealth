import 'package:al_datn_my_health/model/req/stat_drink_in_day_req.dart';
import 'package:al_datn_my_health/model/res/stat_drink_in_day_res.dart';
import 'package:al_datn_my_health/view/custom_view/item_drink_in_day.dart';
import 'package:al_datn_my_health/view/dialog/amount_drink_dialog.dart';
import 'package:flutter/material.dart';

import '../../../api/sever_api.dart';
import '../../../common_utils.dart';

class AddDrinkSchedule extends StatefulWidget {
  final DateTime selectedDate;
  const AddDrinkSchedule({super.key, required this.selectedDate});

  @override
  _AddDrinkScheduleState createState() => _AddDrinkScheduleState();
}

class _AddDrinkScheduleState extends State<AddDrinkSchedule> {
  List<InfoDrinkInDay> listItems = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final idUserInfo = await CommonUtils().getPref("idUserInfo");
    final result = int.tryParse(idUserInfo.toString());

    final formattedDate =
        "${widget.selectedDate.year}-${widget.selectedDate.month.toString().padLeft(2, '0')}-${widget.selectedDate.day.toString().padLeft(2, '0')}";

    if (result != null) {
      final value = await _statDrinkInDay(result, formattedDate);
      setState(() {
        listItems = value;
      });
    }
  }

  Future<List<InfoDrinkInDay>> _statDrinkInDay(int userId, String date) async {
    final req = StatDrinkInDayReq(userId: userId, date: date);
    final res = await SeverApi().statDrinkInDay(req);
    if (res != null && res.message == "Find successful") {
      return res.list;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Image.asset(
                    'assets/images/ic_logo_app.png',
                    width: 56,
                    height: 56,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      'Ghi lại nước',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: "SVN_SAF",
                        fontSize: 24,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: IconButton(
                    onPressed: () async {
                      final isReset = await showDialog<bool>(
                        context: context,
                        builder:
                            (context) => AmountDrinkDialog(
                              selectedDate: widget.selectedDate,
                            ),
                      );
                      if (isReset == true) {
                        _loadData();
                      }
                    },
                    icon: Icon(Icons.add, color: Colors.green, size: 32),
                  ),
                ),
              ],
            ),
            Container(height: 1, color: Colors.green),
            Expanded(
              child:
                  listItems.isEmpty
                      ? Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(15),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/ic_drink_time.png'),
                            Text(
                              'It\'s drink time',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "SVN_SAF",
                                fontSize: 24,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      )
                      : ListView.builder(
                        itemCount: listItems.length,
                        itemBuilder: (context, index) {
                          return ItemDrinkInDay(
                            infoDrinkInDay: listItems[index],
                            onDelete: () async {
                              final success = await _delete(
                                listItems[index].id,
                              );
                              if (success) {
                                setState(() {
                                  listItems.removeAt(index);
                                });
                              }
                            },
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _delete(int id) async {
    final res = await SeverApi().deleteDrinkOfUser(id);
    if (res != null && res.message == "Delete successful") {
      return true;
    } else {
      return false;
    }
  }
}
