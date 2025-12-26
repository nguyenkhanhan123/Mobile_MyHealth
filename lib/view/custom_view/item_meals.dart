import 'package:flutter/material.dart';

import '../../model/res/get_meal_plan_res.dart';

class ItemMeals extends StatelessWidget {
  final MealSession mealSession;
  final Function(MealItem) onSwap;
  final Function(MealItem) onDetail;

  const ItemMeals({
    Key? key,
    required this.mealSession,
    required this.onSwap,
    required this.onDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              mealSession.mealName.toUpperCase(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
          ),

          Divider(height: 1, thickness: 1, color: Colors.grey.shade300),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: mealSession.items.length,
            separatorBuilder: (ctx, index) => Divider(height: 1, indent: 16, endIndent: 16, color: Colors.grey.shade100),
            itemBuilder: (context, index) {
              final item = mealSession.items[index];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tên món
                    Text(
                      "${item.name} (${item.portionScale} khẩu phần)",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Nguyên liệu: ${item.ingredientsText }",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildVerticalDivider(),
                          _buildNutriItem("Kcal", item.finalKcal.toStringAsFixed(0), Colors.orange),
                          _buildVerticalDivider(),
                          _buildNutriItem("Carbs", "${item.finalCarbs.toStringAsFixed(1)}g", Colors.blue),
                          _buildVerticalDivider(),
                          _buildNutriItem("Fat", "${item.finalTotalFat.toStringAsFixed(1)}g", Colors.amber.shade700),
                          _buildVerticalDivider(),
                          _buildNutriItem("Protein", "${item.finalProtein.toStringAsFixed(1)}g", Colors.red),
                          _buildVerticalDivider(),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton.icon(
                          onPressed: () => onSwap(item),
                          icon: Icon(Icons.swap_horiz, size: 18, color: Colors.orange),
                          label: Text("Đổi món", style: TextStyle(color: Colors.orange, fontSize: 12)),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.orange.shade200),
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            minimumSize: Size(0, 32),
                          ),
                        ),
                        SizedBox(width: 8),
                        InkWell(
                          onTap: () => onDetail(item),
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green.shade50,
                              border: Border.all(color: Colors.green.shade200),
                            ),
                            child: Icon(Icons.info_outline, size: 20, color: Colors.green),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNutriItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 20,
      width: 1,
      color: Colors.grey.shade300,
    );
  }
}