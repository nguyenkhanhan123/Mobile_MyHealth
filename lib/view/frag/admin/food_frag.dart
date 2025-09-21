import 'dart:async';

import 'package:al_datn_my_health/model/req/search_req.dart';
import 'package:al_datn_my_health/model/res/list_food_res.dart';
import 'package:al_datn_my_health/view/custom_view/item_suggestion.dart';
import 'package:flutter/material.dart';

import '../../../api/sever_api.dart';
import '../../custom_view/item_food.dart';

class FoodFrag extends StatefulWidget {
  @override
  _FoodFragState createState() => _FoodFragState();
}

class _FoodFragState extends State<FoodFrag> {
  int _page = 1;
  final int _limit = 15;
  bool isLoading = true;
  bool isLoadingMore = false;
  bool hasMore = true;

  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<String> suggestions = [];
  List<InfoFood> infoFood = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _findFood("");
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
    return Column(
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
                  'Nguyên liệu',
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
                onPressed: () {},
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
                  child: CircularProgressIndicator(color: Colors.green),
                )
                    : NotificationListener<ScrollNotification>(
                  onNotification: (scrollInfo) {
                    if (!isLoadingMore &&
                        hasMore &&
                        scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent) {
                      _page++;
                      _findFood(_controller.text, loadMore: true);
                    }
                    return false;
                  },
                  child: ListView.builder(
                    itemCount:
                    infoFood.length + (isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == infoFood.length) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      final food = infoFood[index];
                      return ItemFood(infoFood: food,
                      );
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
                                _findFood(value);
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
                                      _findSimilarFood(value);
                                    }
                                  },
                                );
                              },
                              decoration: InputDecoration(
                                hintText: 'Tìm kiếm, lọc nguyên liệu',
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
                            _findFood(_controller.text);
                          },
                          icon: Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.tune, color: Colors.black, size: 24),
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
    );
  }

  Future<void> _findSimilarFood(String keyword) async {
    final res = await SeverApi().findSimilarFood(keyword);
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

  Future<void> _findFood(String keyword, {bool loadMore = false}) async {
    if (loadMore && isLoadingMore) return;

    if (loadMore) {
      setState(() => isLoadingMore = true);
    } else {
      setState(() {
        isLoading = true;
        _page = 1;
        infoFood.clear();
      });
    }

    final req = SearchReq(keyWord: keyword, page: _page, limit: _limit);
    final res = await SeverApi().findFood(req);
    if (res != null && res.message == "Find successful") {
      setState(() {
        if (loadMore) {
          infoFood.addAll(res.similar);
        } else {
          infoFood = res.similar;
        }
        hasMore = res.similar.length == _limit;
      });
    } else {
      if (!loadMore) setState(() => infoFood = []);
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
