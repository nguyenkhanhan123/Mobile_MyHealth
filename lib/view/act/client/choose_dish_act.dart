import 'dart:async';

import 'package:al_datn_my_health/model/res/list_dish_res.dart';
import 'package:al_datn_my_health/view/act/admin/add_dish_act.dart';
import 'package:al_datn_my_health/view/custom_view/item_dish.dart';
import 'package:flutter/material.dart';

import '../../../api/sever_api.dart';
import '../../../model/req/search_req.dart';
import '../../custom_view/item_add_dish.dart';
import '../../custom_view/item_suggestion.dart';

class ChooseDishAct extends StatefulWidget {
  final String mealType;

  final DateTime selectedDate;

  const ChooseDishAct({super.key, required this.mealType, required this.selectedDate});
  @override
  _ChooseDishActState createState() => _ChooseDishActState();
}

class _ChooseDishActState extends State<ChooseDishAct> {
  int _page = 1;
  final int _limit = 15;
  bool isLoading = true;
  bool isLoadingMore = false;
  bool hasMore = true;

  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<String> suggestions = [];
  List<InfoDish> infoDish = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _findDish("");
    _focusNode.addListener(() {
      setState(() {
        if (!_focusNode.hasFocus) {
          suggestions = [];
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                      'Chọn món ăn',
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
                      final isReload = await Navigator.push<int>(
                        context,
                        MaterialPageRoute(builder: (context) => AddDishAct()),
                      );
                    },
                    icon: Icon(Icons.add, color: Colors.green, size: 32),
                  ),
                ),
              ],
            ),
            Container(height: 1, color: Colors.green),
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 85),
                    child:
                        isLoading
                            ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.green,
                              ),
                            )
                            : NotificationListener<ScrollNotification>(
                              onNotification: (scrollInfo) {
                                if (!isLoadingMore &&
                                    hasMore &&
                                    scrollInfo.metrics.pixels ==
                                        scrollInfo.metrics.maxScrollExtent) {
                                  _page++;
                                  _findDish(_controller.text, loadMore: true);
                                }
                                return false;
                              },
                              child: ListView.builder(
                                itemCount:
                                    infoDish.length + (isLoadingMore ? 1 : 0),
                                itemBuilder: (context, index) {
                                  if (index == infoDish.length) {
                                    return Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                  final dish = infoDish[index];
                                  return ItemAddDish(infoDish: dish,mealType: widget.mealType,selectedDate: widget.selectedDate,);
                                },
                              ),
                            ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      border: Border.all(color: Colors.green, width: 1.5),
                    ),
                    margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: TextField(
                                  focusNode: _focusNode,
                                  controller: _controller,
                                  cursorColor: Colors.black,
                                  onSubmitted: (value) {
                                    _findDish(value);
                                  },
                                  onChanged: (value) {
                                    if (_debounce?.isActive ?? false) {
                                      _debounce!.cancel();
                                    }
                                    _debounce = Timer(
                                      const Duration(milliseconds: 300),
                                      () {
                                        if (value.isEmpty) {
                                          setState(() => suggestions = []);
                                        } else {
                                          _findSimilarDish(value);
                                        }
                                      },
                                    );
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Tìm kiếm, lọc món ăn',
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _focusNode.unfocus();
                                _findDish(_controller.text);
                              },
                              icon: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.tune,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                        Flexible(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: suggestions.length,
                            itemBuilder: (context, index) {
                              return ItemSuggestion(text: suggestions[index]);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _findSimilarDish(String keyword) async {
    final res = await SeverApi().findSimilarDish(keyword);
    if (res != null && res.message == "Find successful") {
      setState(() {
        suggestions = res.similar;
      });
    } else {
      setState(() {
        suggestions = [];
      });
    }
  }

  Future<void> _findDish(String keyword, {bool loadMore = false}) async {
    if (loadMore && isLoadingMore) return;

    if (loadMore) {
      setState(() => isLoadingMore = true);
    } else {
      setState(() {
        isLoading = true;
        _page = 1;
        infoDish.clear();
      });
    }

    final req = SearchReq(keyWord: keyword, page: _page, limit: _limit);
    final res = await SeverApi().findDish(req);
    if (res != null && res.message == "Find successful") {
      setState(() {
        if (loadMore) {
          infoDish.addAll(res.similar);
        } else {
          infoDish = res.similar;
        }
        hasMore = res.similar.length == _limit;
      });
    } else {
      if (!loadMore) setState(() => infoDish = []);
      hasMore = false;
    }

    setState(() {
      isLoading = false;
      isLoadingMore = false;
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
