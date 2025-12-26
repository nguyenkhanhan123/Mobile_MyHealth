import 'package:al_datn_my_health/model/res/list_dish_res.dart';
import 'package:al_datn_my_health/view/act/admin/fix_dish_act.dart';
import 'package:flutter/material.dart';

class ItemDish extends StatelessWidget {
  final InfoDish infoDish;
  final VoidCallback onReload;

  const ItemDish({super.key, required this.infoDish, required this.onReload});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 1, color: Colors.green),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    infoDish.thumbnail,
                    width: 132,
                    height: 75,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) => Image.asset(
                          'assets/images/ic_ingredients.png',
                          width: 132,
                          height: 75,
                          fit: BoxFit.cover,
                        ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: infoDish.name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "SVN_Comic",
                            ),
                          ),
                          if(infoDish.isConfirm==1)
                          WidgetSpan(
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 12,
                            ),
                            alignment: PlaceholderAlignment.middle,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${infoDish.totalGram} g, ${infoDish.totalKcal} kcal",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontFamily: "SVN_Comic",
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () async {
                  final isReload = await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(builder: (context) => FixDishAct(id: infoDish.id)),
                  );
                  if(isReload==true) {
                    onReload();
                  }
                },
                icon: Icon(
                  Icons.edit_note_sharp,
                  size: 28,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.delete, size: 28, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}