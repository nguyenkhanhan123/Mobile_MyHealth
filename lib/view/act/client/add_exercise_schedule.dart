import 'package:al_datn_my_health/model/res/stat_exercise_in_day_res.dart';
import 'package:al_datn_my_health/view/act/client/choose_exercise_act.dart';
import 'package:al_datn_my_health/view/custom_view/item_exercise_in_day.dart';
import 'package:flutter/material.dart';

import '../../../api/sever_api.dart';
import '../../../common_utils.dart';
import '../../../model/req/stat_exercise_in_day_req.dart';

class AddExerciseSchedule extends StatefulWidget {
  final DateTime selectedDate;
  const AddExerciseSchedule({super.key, required this.selectedDate});

  @override
  _AddExerciseScheduleState createState() => _AddExerciseScheduleState();
}

class _AddExerciseScheduleState extends State<AddExerciseSchedule> {
  List<InfoExerciseInDay> listItems = [];
  bool isReset = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadAllData();
  }

  Future<void> _loadAllData() async {
    setState(() {
      isLoading = true;
    });

    await _loadData();

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _loadData() async {
    final idUserInfo = await CommonUtils().getPref("idUserInfo");
    final result = int.tryParse(idUserInfo.toString());

    final formattedDate =
        "${widget.selectedDate.year}-${widget.selectedDate.month.toString().padLeft(2, '0')}-${widget.selectedDate.day.toString().padLeft(2, '0')}";

    if (result != null) {
      final value = await _statExerciseInDay(result, formattedDate);
      setState(() {
        listItems = value;
      });
    }
  }

  Future<List<InfoExerciseInDay>> _statExerciseInDay(
    int userId,
    String date,
  ) async {
    final req = StatExerciseInDayReq(userId: userId, date: date);
    final res = await SeverApi().statExerciseInDay(req);
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
                        'Ghi lại bài tập',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
                        final isUpdate = await showDialog<bool>(
                          context: context,
                          builder:
                              (context) => ChooseExerciseAct(
                                selectedDate: widget.selectedDate,
                              ),
                        );
                        if (isUpdate == true) {
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
                    isLoading
                        ? Center(
                          child: CircularProgressIndicator(color: Colors.green),
                        )
                        : (listItems.isEmpty
                            ? SingleChildScrollView(
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(
                                  vertical: 45,
                                  horizontal: 15,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/ic_exercise_time.png',
                                    ),
                                    Text(
                                      'It\'s exercise time',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: "SVN_SAF",
                                        fontSize: 24,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            : ListView.builder(
                              itemCount: listItems.length,
                              itemBuilder: (context, index) {
                                return ItemExerciseInDay(
                                  infoExerciseInDay: listItems[index],
                                  onDelete: () async {
                                    final success = await _delete(
                                      listItems[index].id,
                                    );
                                    if (success) {
                                      setState(() {
                                        listItems.removeAt(index);
                                      });
                                      isReset = true;
                                    }
                                  },
                                );
                              },
                            )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _delete(int id) async {
    final res = await SeverApi().deleteExerciseOfUser(id);
    if (res != null && res.message == "Delete successful") {
      return true;
    } else {
      return false;
    }
  }
}
