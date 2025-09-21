import 'package:al_datn_my_health/model/req/stat_meal_in_day_req.dart';
import 'package:al_datn_my_health/model/res/stat_meal_in_day_res.dart';
import 'package:al_datn_my_health/view/act/client/choose_dish_act.dart';
import 'package:al_datn_my_health/view/custom_view/item_meal_in_day.dart';
import 'package:flutter/material.dart';

import '../../../api/sever_api.dart';
import '../../../common_utils.dart';

class AddFoodSchedule extends StatefulWidget {
  final String mealType;
  final DateTime selectedDate;
  const AddFoodSchedule({
    super.key,
    required this.mealType,
    required this.selectedDate,
  });

  @override
  _AddFoodScheduleState createState() => _AddFoodScheduleState();
}

class _AddFoodScheduleState extends State<AddFoodSchedule> {
  List<InfoMealInDay> listItems = [];
  bool isReset = false;

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
      final value = await _statMealInDay(
        result,
        formattedDate,
        widget.mealType,
      );
      setState(() {
        listItems = value;
      });
    }
  }

  Future<List<InfoMealInDay>> _statMealInDay(
    int userId,
    String date,
    String mealType,
  ) async {
    final req = StatMealInDayReq(
      userId: userId,
      date: date,
      mealType: mealType,
    );
    final res = await SeverApi().statMealInDay(req);
    if (res != null && res.message == "Find successful") {
      return res.list;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.pop(context, isReset);
        }
      },
      child: Scaffold(
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
                        'Ghi lại thực phẩm',
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
                        final isReload = await Navigator.push<bool>(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => ChooseDishAct(
                                  mealType: widget.mealType,
                                  selectedDate: widget.selectedDate,
                                ),
                          ),
                        );
                        if (isReload == true) {
                          _loadData();
                          isReset = true;
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
                              Image.asset('assets/images/ic_food_time.jpg'),
                              Text(
                                'It\'s ${widget.mealType} time',
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
                            return ItemMealInDay(
                              infoMealInDay: listItems[index],
                              onDelete: () async {
                                final success = await _delete(
                                  listItems[index].id,
                                );
                                if (success) {
                                  setState(() {
                                    listItems.removeAt(index);
                                    isReset=true;
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
      ),
    );
  }

  Future<bool> _delete(int id) async {
    final res = await SeverApi().deleteMealOfUser(id);
    if (res != null && res.message == "Delete successful") {
      return true;
    } else {
      return false;
    }
  }
}
