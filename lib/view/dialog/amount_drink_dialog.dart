import 'package:al_datn_my_health/model/req/add_drink_req.dart';
import 'package:al_datn_my_health/model/unit_drink.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../api/sever_api.dart';
import '../../common_utils.dart';

class AmountDrinkDialog extends StatefulWidget {
  final DateTime selectedDate;

  const AmountDrinkDialog({super.key, required this.selectedDate});
  @override
  _AmountDrinkDialogState createState() => _AmountDrinkDialogState();
}

class _AmountDrinkDialogState extends State<AmountDrinkDialog> {
  UnitDrink? selectedUnit;
  List<UnitDrink> items = [
    UnitDrink(id: 1, baseUnit: "ml", mlPerUnit: 1),
    UnitDrink(id: 2, baseUnit: "Cốc bé", mlPerUnit: 180),
    UnitDrink(id: 3, baseUnit: "Cốc vừa", mlPerUnit: 300),
    UnitDrink(id: 4, baseUnit: "Cốc to", mlPerUnit: 500),
  ];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedUnit = items[0];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Lượng nước đã uống",
        style: TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontFamily: "SVN_Comic",
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              SizedBox(
                width: 65,
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.green,
                  textAlign: TextAlign.center,
                  maxLength: 4,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 3),
                    ),
                    counterText: "",
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "SVN_Comic",
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(width: 8),
              DropdownButton<UnitDrink>(
                value: selectedUnit,
                items:
                    items.map((unit) {
                      return DropdownMenuItem<UnitDrink>(
                        value: unit,
                        child: Text(
                          unit.baseUnit,
                          style: TextStyle(
                            fontFamily: "SVN_Comic",
                            fontSize: 16,
                          ),
                        ),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedUnit = value;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.info_outline, size: 16, color: Colors.grey),
              SizedBox(width: 4),
              Expanded(
                child: Text(
                  "Một lần uống nên từ 150ml – 300ml để cơ thể hấp thụ tốt nhất, tối đa là 500ml nhé!",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontFamily: "SVN_Comic",
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text(
            "Đồng ý",
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 20,
              fontFamily: "SVN_Comic",
            ),
          ),
          onPressed: () async {
            double? value = double.tryParse(_controller.text.trim());

            final idUserInfo = await CommonUtils().getPref("idUserInfo");
            final result = int.tryParse(idUserInfo.toString());

            final formattedDate =
                "${widget.selectedDate.year}-${widget.selectedDate.month.toString().padLeft(2, '0')}-${widget.selectedDate.day.toString().padLeft(2, '0')}";
            if(result!=null && value!=null){
              if(value*selectedUnit!.mlPerUnit<=500){
                final success = await _addDrink(
                  result,
                  selectedUnit!.id,
                  value,
                  formattedDate
                );
                if (success) {
                  Navigator.pop(context, true);
                }
              }
              else{
                await Fluttertoast.showToast(
                  msg: "Đừng uống quá nhiều nước 1 lần!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.black87,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              }
            }
          },
        ),
      ],
    );
  }

  Future<bool> _addDrink(
      int userId,
      int unitDrinkId,
      double amount,
      String date,
      ) async {
    final req = AddDrinkReq(
      userId: userId,
      amount: amount,
      unitDrinkId: unitDrinkId,
      date: date
    );
    final res = await SeverApi().addDrink(req);
    if (res != null && res.message == "Create drink successful") {
      await Fluttertoast.showToast(
        msg: "Thêm nước uống thành công!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return true;
    } else {
      await Fluttertoast.showToast(
        msg: "Chưa thể thêm nước uống hoặc kết nối không ổn định!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    }
  }
}
