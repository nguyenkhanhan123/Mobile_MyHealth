import 'package:al_datn_my_health/view/collect_user_data/choose_weight_target.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../model/user_info.dart';

class ChooseWeight extends StatefulWidget {
  final UserInfo userInfo;
  final int? idUserInfo;
  const ChooseWeight({super.key, required this.userInfo, this.idUserInfo});

  @override
  _ChooseWeightState createState() {
    return _ChooseWeightState();
  }
}

class _ChooseWeightState extends State<ChooseWeight> {
  int _currentValue = 42;
  double _currentBMI = 0;
  int _currentFlex = 100;

  @override
  void initState() {
    super.initState();
    loadBMI(_currentValue);
  }

  void loadBMI(int currentValue) {
    final _bmi = _currentValue / ((widget.userInfo.height! / 100) * (widget.userInfo.height! / 100));
    int flex = 0;
    if (_bmi < 18.5) {
      flex = ((_bmi / 18.5) * 20).round();
    } else if (_bmi >= 18.5 && _bmi < 23.0) {
      flex = 20 + (((_bmi - 18.5) / (23.0 - 18.5)) * 20).round();
    } else if (_bmi >= 23.0 && _bmi < 25.0) {
      flex = 40 + (((_bmi - 23.0) / (25.0 - 23.0)) * 20).round();
    } else if (_bmi >= 25.0 && _bmi < 30.0) {
      flex = 60 + (((_bmi - 25.0) / (30.0 - 25.0)) * 20).round();
    } else if (_bmi >= 30.0 && _bmi < 40.0) {
      flex = 80 + (((_bmi - 30.0) / (40.0 - 30.0)) * 20).round();
    } else if (_bmi >= 40.0) {
      flex = 100;
    }
    setState(() {
      _currentValue = currentValue;
      _currentBMI = _bmi;
      _currentFlex = flex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LinearProgressIndicator(
                color: Color.fromARGB(255, 57, 206, 41),
                backgroundColor: Color.fromARGB(255, 215, 236, 255),
                value: 6 / 12,
                minHeight: 6,
                borderRadius: BorderRadius.all(Radius.circular(90)),
              ),
              SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "My", style: TextStyle(fontFamily: "SVN_Ready", fontSize: 32, color: Colors.black)),
                    TextSpan(text: "Health", style: TextStyle(fontFamily: "SVN_Ready", fontSize: 32, color: Colors.green)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/ic_weight.png', width: 165, height: 165),
            Container(
              margin: EdgeInsets.all(15),
              child: Text(
                'Cân nặng của bạn là bao nhiêu?',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 28, fontFamily: "SVN_Comic", fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  NumberPicker(
                    value: _currentValue,
                    minValue: 20,
                    maxValue: 200,
                    step: 1,
                    itemWidth: 50,
                    itemCount: 5,
                    axis: Axis.horizontal,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.blueAccent, width: 2)),
                    selectedTextStyle: const TextStyle(fontSize: 24, color: Colors.blue, fontWeight: FontWeight.bold),
                    textStyle: const TextStyle(fontSize: 20, color: Colors.grey),
                    onChanged: (value) {
                      loadBMI(value);
                    },
                  ),
                  Container(
                    margin: EdgeInsets.all(9),
                    child: Text(
                      'Chỉ số khối cơ thể (BMI) của bạn là',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: "SVN_Comic"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    child: Text(
                      _currentBMI.toStringAsFixed(1),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 22, fontFamily: "SVN_Comic"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    child: Text(
                      'BMI của bạn cho thấy bạn đang',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: "SVN_Comic"),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        '18.5',
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 12, fontFamily: "SVN_Comic"),
                      ),
                      Text(
                        '23.0',
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 12, fontFamily: "SVN_Comic"),
                      ),
                      Text(
                        '25.0',
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 12, fontFamily: "SVN_Comic"),
                      ),
                      Text(
                        '30.0',
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 12, fontFamily: "SVN_Comic"),
                      ),
                    ],
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          gradient: LinearGradient(
                            colors: [Colors.lightBlueAccent, Colors.green, Colors.orange, Colors.redAccent, Colors.brown],
                            stops: [0, 0.25, 0.5, 0.75, 1],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(flex: _currentFlex, child: SizedBox(width: 0)),
                          Center(child: Icon(Icons.circle, size: 12, color: Colors.black)),
                          Expanded(flex: 100 - _currentFlex, child: SizedBox(width: 0)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Thiếu cân',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 12, fontFamily: "SVN_Comic"),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Bình thường',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 12, fontFamily: "SVN_Comic"),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Thừa cân',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 12, fontFamily: "SVN_Comic"),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Béo phì',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 12, fontFamily: "SVN_Comic"),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Béo phì nặng',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red, fontSize: 12, fontFamily: "SVN_Comic"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 40),
              child: Align(
                alignment: Alignment.center,
                child: TextButton.icon(
                  onPressed: () {
                    widget.userInfo.weight = _currentValue;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChooseWeightTarget(userInfo: widget.userInfo, idUserInfo: widget.idUserInfo)),
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 9),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  ),
                  icon: Icon(Icons.subdirectory_arrow_right_outlined, size: 24, color: Colors.white),
                  label: Text('Tiếp tục', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 22, fontFamily: "SVN_Comic")),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
