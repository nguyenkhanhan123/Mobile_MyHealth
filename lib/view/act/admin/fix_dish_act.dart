import 'package:al_datn_my_health/model/hashtag.dart';
import 'package:al_datn_my_health/model/req/add_dish_req.dart';
import 'package:al_datn_my_health/model/res/list_food_res.dart';
import 'package:al_datn_my_health/view/act/admin/choose_food_act.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../api/sever_api.dart';
import '../../../model/res/info_dish_res.dart';
import '../../custom_view/item_weight_food.dart';
import '../../dialog/hashtag_dialog.dart';

class FixDishAct extends StatefulWidget {
  final int id;
  const FixDishAct({super.key, required this.id});
  @override
  _FixDishActState createState() => _FixDishActState();
}

class _FixDishActState extends State<FixDishAct> {
  final _formKey = GlobalKey<FormState>();
  List<Ingredient> ingredients = [];
  List<Hashtag> selectedHashtags = [];

  final TextEditingController _nameDishController = TextEditingController();
  final TextEditingController _thumnailController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _preparationStepsController =
  TextEditingController();
  final TextEditingController _cookingStepsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getDish(widget.id);
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
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'Sửa món',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "SVN_SAF",
                      fontSize: 24,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
            Container(height: 1, color: Colors.green),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 15),
                        TextFormField(
                          controller: _nameDishController,
                          cursorColor: Colors.black,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: "Tên món ăn",
                            labelStyle: TextStyle(color: Colors.grey),
                            floatingLabelStyle: TextStyle(color: Colors.green),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.green,
                                width: 1.5,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.restaurant_menu,
                              color: Colors.green,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Vui lòng nhập tên món ăn";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: _thumnailController,
                          cursorColor: Colors.black,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: "Đường dẫn ảnh minh họa",
                            labelStyle: TextStyle(color: Colors.grey),
                            floatingLabelStyle: TextStyle(color: Colors.green),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.green,
                                width: 1.5,
                              ),
                            ),
                            prefixIcon: Icon(Icons.image, color: Colors.green),
                          ),
                          validator: (value) {
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: _descriptionController,
                          cursorColor: Colors.black,
                          maxLines: 3,
                          decoration: InputDecoration(
                            labelText: "Mô tả món ăn",
                            labelStyle: TextStyle(color: Colors.grey),
                            floatingLabelStyle: TextStyle(color: Colors.green),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.green,
                                width: 1.5,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.description,
                              color: Colors.green,
                            ),
                          ),
                          validator: (value) {
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: _preparationStepsController,
                          cursorColor: Colors.black,
                          maxLines: 5,
                          decoration: InputDecoration(
                            labelText: "Các bước chuẩn bị món ăn",
                            labelStyle: TextStyle(color: Colors.grey),
                            floatingLabelStyle: TextStyle(color: Colors.green),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.green,
                                width: 1.5,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.format_list_bulleted,
                              color: Colors.green,
                            ),
                          ),
                          validator: (value) {
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: _cookingStepsController,
                          cursorColor: Colors.black,
                          maxLines: 5,
                          decoration: InputDecoration(
                            labelText: "Các bước nấu món ăn",
                            labelStyle: TextStyle(color: Colors.grey),
                            floatingLabelStyle: TextStyle(color: Colors.green),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.green,
                                width: 1.5,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.soup_kitchen,
                              color: Colors.green,
                            ),
                          ),
                          validator: (value) {
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 8,
                              ),
                              child: Text(
                                "Danh sách nguyên liệu",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 21,
                                  fontFamily: "SVN_Comic",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 8,
                              ),
                              child: TextButton.icon(
                                onPressed: () async {
                                  final result = await Navigator.push<
                                      Ingredient
                                  >(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChooseFoodAct(),
                                    ),
                                  );

                                  if (result != null) {
                                    setState(() {
                                      final index = ingredients.indexWhere(
                                            (f) => f.ingredientId == result.ingredientId,
                                      );
                                      if (index == -1) {
                                        ingredients.add(result);
                                      }
                                      else{
                                        final old = ingredients[index];
                                        ingredients[index] = Ingredient(
                                          ingredientId: old.ingredientId,
                                          name: old.name,
                                          weight: old.weight + result.weight,
                                          unit: old.unit,
                                          thumbnail: old.thumbnail,
                                        );
                                      }
                                    });
                                  }
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.blue,
                                  backgroundColor: Color.fromARGB(
                                    255,
                                    215,
                                    236,
                                    255,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                icon: Icon(Icons.add, size: 16),
                                label: Text(
                                  "Chọn nguyên liệu",
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "SVN_Comic",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        ListView.builder(
                          itemCount: ingredients.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final ingredient = ingredients[index];
                            return ItemWeightFood(
                              ingredient: ingredient,
                              onRemove: () {
                                setState(() {
                                  ingredients.removeWhere(
                                        (f) => f.ingredientId == ingredient.ingredientId,
                                  );
                                });
                              },
                            );
                          },
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 8,
                              ),
                              child: Text(
                                "Đổi hashtag mô tả",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 21,
                                  fontFamily: "SVN_Comic",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 8,
                              ),
                              child: TextButton.icon(
                                onPressed: () async {
                                  final result = await showDialog<List<Hashtag>>(
                                    context: context,
                                    builder: (context) => const HashtagDialog(),
                                  );
                                  if (result != null) {
                                    setState(() {
                                      selectedHashtags = result;
                                    });
                                  }
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.blue,
                                  backgroundColor: Color.fromARGB(
                                    255,
                                    215,
                                    236,
                                    255,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                icon: Icon(Icons.add, size: 16),
                                label: Text(
                                  "Đổi hashtag",
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "SVN_Comic",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        if (selectedHashtags.isNotEmpty)
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: selectedHashtags.map((tag) {
                              return Container(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.grey.shade300),
                                ),
                                child: Text(
                                  tag.title,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'Nunito',
                                    color: Colors.black87,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        SizedBox(height: 15),
                        TextButton.icon(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final isReload=_fixDish(
                                widget.id,
                                _nameDishController.text,
                                _thumnailController.text,
                                _descriptionController.text,
                                _preparationStepsController.text,
                                _cookingStepsController.text,
                                ingredients,
                                selectedHashtags,
                              );
                              if(await isReload) {
                                Navigator.of(context).pop(true);
                              }
                            }
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(
                              horizontal: 35,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          icon: Icon(Icons.save, size: 24, color: Colors.white),
                          label: Text(
                            'Sửa món ăn',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontFamily: "SVN_Comic",
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getDish(int id) async {
    final res = await SeverApi().infoDish(id);
    if (res != null && res.message == "Find successful") {
      setState(() {
        ingredients=res.dish.ingredients;
        selectedHashtags=res.dish.hashtags;
        _nameDishController.text=res.dish.name;
        _descriptionController.text=res.dish.description;
        _thumnailController.text=res.dish.thumbnail;
        _cookingStepsController.text=res.dish.cookingSteps;
        _preparationStepsController.text=res.dish.preparationSteps;
      });
    } else {
      await Fluttertoast.showToast(
        msg: "Không thể lấy thông tin món ăn!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<bool> _fixDish(
      int id,
      String name,
      String thumbnail,
      String description,
      String preparationSteps,
      String cookingSteps,
      List<Ingredient> ingredients,
      List<Hashtag> hashtagId,
      ) async {
    List<int> hashtagIds = selectedHashtags.map((h) => h.id).toList();
    List<IngredientItem> ingredientItems = ingredients
        .map((ing) => IngredientItem(
      ingredientId: ing.ingredientId,
      weight: ing.weight,
    ))
        .toList();
    final req = AddDishReq(
      name: name,
      thumbnail: thumbnail,
      description: description,
      isConfirm: 1,
      preparationSteps: preparationSteps,
      cookingSteps: cookingSteps,
      ingredients: ingredientItems,
      hashtagId: hashtagIds,
    );
    final res = await SeverApi().updateDish(id,req);
    if (res != null && res.message == "Update dish successful") {
      await Fluttertoast.showToast(
        msg: "Sửa món ăn thành công!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return true;
    } else {
      await Fluttertoast.showToast(
        msg: "Chưa thể sửa món ăn bây giờ!",
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
