import 'package:al_datn_my_health/model/activity_level.dart';
import 'package:al_datn_my_health/view/collect_user_data/choose_complete_target.dart';
import 'package:flutter/material.dart';

import '../../model/user_info.dart';

class ChooseActivityLevel extends StatefulWidget {
  final UserInfo userInfo;
  const ChooseActivityLevel({super.key, required this.userInfo});
  @override
  _ChooseActivityLevelState createState() {
    return _ChooseActivityLevelState();
  }
}

class _ChooseActivityLevelState extends State<ChooseActivityLevel> {
  int _currentIndex = 0;
  List<ActivityLevel> list = [
    ActivityLevel(
      id: 1,
      title: 'Ít vận động',
      url: 'assets/images/ic_work_office.png',
      detail:
          'Mức độ này áp dụng cho những người có lối sống chủ yếu ngồi nhiều và rất ít vận động thể chất trong ngày. Họ thường là nhân viên văn phòng, học sinh hoặc sinh viên học tập, làm việc lâu giờ trước máy tính và không tham gia bất kỳ hoạt động thể chất đáng kể nào.',
    ),
    ActivityLevel(
      id: 2,
      title: 'Hoạt động nhẹ',
      url: 'assets/images/ic_yoga.png',
      detail:
          'Đây là mức dành cho những người có tham gia vận động nhẹ nhàng khoảng 1–3 lần mỗi tuần. Hoạt động có thể bao gồm đi bộ, tập yoga, thể dục tại nhà hoặc làm việc nhà nhẹ. Lối sống này thể hiện sự chủ động vận động nhưng chưa đều đặn hoặc cường độ thấp.',
    ),
    ActivityLevel(
      id: 3,
      title: 'Hoạt động vừa',
      url: 'assets/images/ic_run.png',
      detail:
          'Những người ở mức độ này có thói quen tập thể dục đều đặn từ 3–5 buổi mỗi tuần. Các hoạt động thể chất có thể bao gồm gym, chạy bộ, bơi lội hoặc chơi thể thao. Ngoài ra, mức này cũng phù hợp với người làm công việc đòi hỏi di chuyển nhiều trong ngày.',
    ),
    ActivityLevel(
      id: 4,
      title: 'Hoạt động nặng',
      url: 'assets/images/ic_gymer.png',
      detail:
          'Mức này dành cho những người vận động với cường độ cao gần như mỗi ngày. Họ có thể tập luyện thể hình nâng tạ nặng, tập cardio cường độ cao hoặc làm công việc chân tay nặng nhọc như xây dựng, vận chuyển hàng hóa hoặc giao hàng đường dài.',
    ),
    ActivityLevel(
      id: 5,
      title: 'Hoạt động rất nặng',
      url: 'assets/images/ic_farmer.png',
      detail:
          'Đây là mức hoạt động cao nhất, phù hợp với vận động viên chuyên nghiệp hoặc người làm việc tay chân nặng nhọc kéo dài trong ngày. Những người ở mức này thường luyện tập 2 buổi/ngày hoặc tham gia lao động cường độ cao như khai thác mỏ, lính, huấn luyện thể lực đặc biệt.',
    ),
  ];

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
                value: 8/12,
                minHeight: 6,
                borderRadius: BorderRadius.all(Radius.circular(90)),
              ),
              SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "My",
                      style: TextStyle(
                        fontFamily: "SVN_Ready",
                        fontSize: 32,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: "Health",
                      style: TextStyle(
                        fontFamily: "SVN_Ready",
                        fontSize: 32,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Image.asset('assets/images/ic_exercise.jpg'),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 15, 15, 8),
            child: Text(
              'Bạn hoạt động hàng ngày như thế nào?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontFamily: "SVN_Comic",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(12),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.blue,
                            elevation: 3,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_currentIndex > 0) {
                                _currentIndex--;
                              } else {
                                _currentIndex = list.length - 1;
                              }
                            });
                          },

                          child: const Icon(Icons.arrow_back, size: 24),
                        ),
                        Text(
                          list[_currentIndex].title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: "SVN_Comic",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(12),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.blue,
                            elevation: 3,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_currentIndex < list.length - 1) {
                                _currentIndex++;
                              } else {
                                _currentIndex = 0;
                              }
                            });
                          },
                          child: const Icon(Icons.arrow_forward, size: 24),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    flex: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        list[_currentIndex].url,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Text(
                        list[_currentIndex].detail,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontFamily: "SVN_Comic",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 40),
            child: Align(
              alignment: Alignment.center,
              child: TextButton.icon(
                onPressed: () {
                  widget.userInfo.activityLevelId=list[_currentIndex].id;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChooseCompleteTarget(userInfo: widget.userInfo)),
                  );
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                icon: Icon(
                  Icons.subdirectory_arrow_right_outlined,
                  size: 24,
                  color: Colors.white,
                ),
                label: Text(
                  'Tiếp tục',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: "SVN_Comic",
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
