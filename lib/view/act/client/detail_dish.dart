import 'package:al_datn_my_health/model/hashtag.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../api/sever_api.dart';
import '../../../model/res/info_dish_res.dart';

class DetailDishAct extends StatefulWidget {
  final int? id;
  final String? dishName;
  const DetailDishAct({
    super.key,
    this.id,
    this.dishName
  }) : assert(id != null || dishName != null, 'Phải truyền vào id hoặc tên món ăn');

  @override
  _DetailDishActState createState() => _DetailDishActState();
}

class _DetailDishActState extends State<DetailDishAct> {
  String name = "";
  String thumbnail = "";
  String description = "";
  String preparationSteps = "";
  String cookingSteps = "";
  List<BasicIngredient> ingredients = [];
  List<Hashtag> hashtags = [];

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
    if (widget.id != null) {
      await _getDish(widget.id!);
    } else if (widget.dishName != null) {
      await _getDish2(widget.dishName!);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Image.asset('assets/images/ic_logo_app.png', width: 56, height: 56),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      'Chi tiết món ăn',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontFamily: "SVN_SAF", fontSize: 24, color: Colors.green),
                    ),
                  ),
                )
              ],
            ),
            Container(height: 1, color: Colors.green),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator(color: Colors.green))
                  : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (thumbnail.isNotEmpty)
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            thumbnail,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image_not_supported, size: 100, color: Colors.grey),
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        fontFamily: "SVN_Comic",
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (hashtags.isNotEmpty)
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: hashtags.map((tag) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.green.withOpacity(0.3)),
                            ),
                            child: Text(
                              "#${tag.title}",
                              style: const TextStyle(fontSize: 13, fontFamily: 'Nunito', color: Colors.green),
                            ),
                          );
                        }).toList(),
                      ),
                    const SizedBox(height: 20),
                    const Divider(),
                    _buildSectionTitle("Mô tả món ăn", Icons.description),
                    Text(
                      description.isNotEmpty ? description : "Chưa có mô tả",
                      style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.black54),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 20),
                    _buildSectionTitle("Nguyên liệu", Icons.kitchen),
                    if (ingredients.isEmpty)
                      const Text("Chưa có thông tin nguyên liệu", style: TextStyle(color: Colors.grey)),
                    ListView.builder(
                      itemCount: ingredients.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final ingredient = ingredients[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  ingredient.name,
                                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                                ),
                              ),
                              Text(
                                "${ingredient.weight} ${ingredient.unit}",
                                style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildSectionTitle("Chuẩn bị", Icons.content_paste),
                    Text(
                      preparationSteps.isNotEmpty ? preparationSteps : "Không có bước chuẩn bị",
                      style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
                    ),
                    const SizedBox(height: 20),
                    _buildSectionTitle("Cách nấu", Icons.soup_kitchen),
                    Text(
                      cookingSteps.isNotEmpty ? cookingSteps : "Không có hướng dẫn nấu",
                      style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.green, size: 20),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
                fontFamily: "SVN_Comic"
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getDish(int id) async {
    final res = await SeverApi().infoDish(id);
    if (res != null && res.message == "Find successful") {
      setState(() {
        name = res.dish.name;
        thumbnail = res.dish.thumbnail;
        description = res.dish.description;
        preparationSteps = res.dish.preparationSteps;
        cookingSteps = res.dish.cookingSteps;
        ingredients = res.dish.ingredients;
        hashtags = res.dish.hashtags;
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

  Future<void> _getDish2(String keyword) async {
    final res = await SeverApi().infoDish2(keyword);
    print(res?.dish.name.toString());
    if (res != null && res.message == "Find successful") {
      setState(() {
        name = res.dish.name;
        thumbnail = res.dish.thumbnail;
        description = res.dish.description;
        preparationSteps = res.dish.preparationSteps;
        cookingSteps = res.dish.cookingSteps;
        ingredients = res.dish.ingredients;
        hashtags = res.dish.hashtags;
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
}