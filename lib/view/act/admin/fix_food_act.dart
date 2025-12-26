import 'package:al_datn_my_health/view/custom_view/nutri_input.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../api/sever_api.dart';
import '../../../model/res/info_ingredient_res.dart';
import '../../custom_view/item_title.dart';

class FixFoodAct extends StatefulWidget {
  final int id;
  const FixFoodAct({super.key, required this.id});

  @override
  _FixFoodActState createState() => _FixFoodActState();
}

class _FixFoodActState extends State<FixFoodAct> {
  final _formKey = GlobalKey<FormState>();
  List<String> items = ["gram", "ml", "thìa cà phê"];
  String? selectedUnit;
  bool isLoading = false;
  late Ingredient ingredient;

  final TextEditingController _nameFoodController = TextEditingController();
  final TextEditingController _thumnailController = TextEditingController();
  final TextEditingController _gramPerUnitFoodController = TextEditingController();
  final TextEditingController _kcalController = TextEditingController();
  final TextEditingController _proteinController = TextEditingController();
  final TextEditingController _waterController = TextEditingController();
  final TextEditingController _caffeinController = TextEditingController();
  final TextEditingController _alcoholController = TextEditingController();
  final TextEditingController _cholesterolController = TextEditingController();
  final TextEditingController _carbsController = TextEditingController();
  final TextEditingController _sugarController = TextEditingController();
  final TextEditingController _fiberController = TextEditingController();
  final TextEditingController _monounSaturatedFatController = TextEditingController();
  final TextEditingController _polyunSaturatedFatController = TextEditingController();
  final TextEditingController _transFatController = TextEditingController();
  final TextEditingController _saturatedFatController = TextEditingController();

  final TextEditingController _vitaminAController = TextEditingController();
  final TextEditingController _vitaminB6Controller = TextEditingController();
  final TextEditingController _vitaminB12Controller = TextEditingController();
  final TextEditingController _vitaminCController = TextEditingController();
  final TextEditingController _vitaminDController = TextEditingController();
  final TextEditingController _vitaminEController = TextEditingController();
  final TextEditingController _vitaminKController = TextEditingController();
  final TextEditingController _cholineController = TextEditingController();

  final TextEditingController _canxiController = TextEditingController();
  final TextEditingController _feController = TextEditingController();
  final TextEditingController _mgController = TextEditingController();
  final TextEditingController _photphoController = TextEditingController();
  final TextEditingController _kaliController = TextEditingController();
  final TextEditingController _natriController = TextEditingController();
  final TextEditingController _znController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedUnit = items[0];
    _loadAllData();
  }

  Future<void> _loadAllData() async {
    setState(() {
      isLoading = true;
    });

    await _getFood(widget.id);

    setState(() {
      isLoading = false;
    });
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
                Padding(padding: EdgeInsets.all(5), child: Image.asset('assets/images/ic_logo_app.png', width: 56, height: 56)),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      'Sửa nguyên liệu',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontFamily: "SVN_SAF", fontSize: 24, color: Colors.green),
                    ),
                  ),
                ),
              ],
            ),
            Container(height: 1, color: Colors.green),
            Expanded(
              child:
                  isLoading
                      ? Center(child: CircularProgressIndicator(color: Colors.green))
                      : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                SizedBox(height: 15),
                                TextFormField(
                                  controller: _nameFoodController,
                                  cursorColor: Colors.black,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    labelText: "Tên nguyên liệu",
                                    labelStyle: TextStyle(color: Colors.grey),
                                    floatingLabelStyle: TextStyle(color: Colors.green),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: Colors.green, width: 1.5),
                                    ),
                                    prefixIcon: Icon(Icons.restaurant_menu, color: Colors.green),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Vui lòng nhập tên nguyên liệu";
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
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: Colors.green, width: 1.5),
                                    ),
                                    prefixIcon: Icon(Icons.image, color: Colors.green),
                                  ),
                                  validator: (value) {
                                    return null;
                                  },
                                ),
                                SizedBox(height: 15),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                    border: Border.all(color: Colors.green, width: 1.5),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ItemTitle(icon: Icons.science, text: 'Đơn vị đo'),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text("1", style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: "SVN_Comic")),
                                          SizedBox(width: 12),
                                          DropdownButton<String>(
                                            value: selectedUnit,
                                            items:
                                                items.map((unit) {
                                                  return DropdownMenuItem<String>(
                                                    value: unit,
                                                    child: Text(unit, style: const TextStyle(fontFamily: "SVN_Comic", fontSize: 16)),
                                                  );
                                                }).toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                selectedUnit = value!;
                                              });
                                            },
                                          ),
                                          SizedBox(width: 12),
                                          Text("=", style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: "SVN_Comic")),
                                          SizedBox(width: 12),
                                          Container(
                                            width: 58,
                                            padding: const EdgeInsets.symmetric(horizontal: 5),
                                            child: TextFormField(
                                              controller: _gramPerUnitFoodController,
                                              cursorColor: Colors.black,
                                              maxLines: 1,
                                              maxLength: 5,
                                              textAlign: TextAlign.center,
                                              keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
                                              decoration: const InputDecoration(
                                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green, width: 2)),
                                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green, width: 3)),
                                                counterText: "",
                                              ),
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return "";
                                                }
                                                if (double.tryParse(value) == null) {
                                                  return "";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 12),
                                          Text("gram", style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: "SVN_Comic")),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                    border: Border.all(color: Colors.green, width: 1.5),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ItemTitle(icon: Icons.local_fire_department, text: 'Chuyên biệt'),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(width: 8),
                                            NutriInput(label: "Năng lượng", unit: "kcal", controller: _kcalController, isInteger: true),
                                            SizedBox(width: 15),
                                            NutriInput(label: "Protein", unit: "g", controller: _proteinController),
                                            SizedBox(width: 15),
                                            NutriInput(label: "Nước", unit: "ml", controller: _waterController),
                                            SizedBox(width: 15),
                                            NutriInput(label: "Caffein", unit: "mg", controller: _caffeinController),
                                            SizedBox(width: 15),
                                            NutriInput(label: "Alcohol", unit: "g", controller: _alcoholController),
                                            SizedBox(width: 15),
                                            NutriInput(label: "Cholesterol", unit: "mg", controller: _cholesterolController),
                                            SizedBox(width: 8),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                    border: Border.all(color: Colors.green, width: 1.5),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ItemTitle(icon: Icons.ramen_dining, text: 'Carbohydrate (Glucid)'),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(width: 8),
                                            NutriInput(label: "Tinh bột", unit: "g", controller: _carbsController),
                                            SizedBox(width: 15),
                                            NutriInput(label: "Đường", unit: "g", controller: _sugarController),
                                            SizedBox(width: 15),
                                            NutriInput(label: "Chất xơ", unit: "g", controller: _fiberController),
                                            SizedBox(width: 8),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                    border: Border.all(color: Colors.green, width: 1.5),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ItemTitle(icon: Icons.fastfood_outlined, text: 'Fat (Lipid)'),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(width: 8),
                                            NutriInput(label: "SaturatedFat", unit: "g", controller: _saturatedFatController),
                                            SizedBox(width: 15),
                                            NutriInput(label: "MonounSaturatedFat", unit: "g", controller: _monounSaturatedFatController),
                                            SizedBox(width: 15),
                                            NutriInput(label: "PolyunSaturedFat", unit: "g", controller: _polyunSaturatedFatController),
                                            SizedBox(width: 15),
                                            NutriInput(label: "TransFat", unit: "g", controller: _transFatController),
                                            SizedBox(width: 8),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                    border: Border.all(color: Colors.green, width: 1.5),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ItemTitle(icon: Icons.water_drop, text: 'Vitamin'),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(width: 8),
                                            NutriInput(label: "Vitamin A", unit: "IU", controller: _vitaminAController),
                                            SizedBox(width: 15),
                                            NutriInput(label: "Vitamin B6", unit: "mg", controller: _vitaminB6Controller),
                                            SizedBox(width: 15),
                                            NutriInput(label: "Vitamin B12", unit: "mg", controller: _vitaminB12Controller),
                                            SizedBox(width: 15),
                                            NutriInput(label: "Vitamin C", unit: "mg", controller: _vitaminCController),
                                            SizedBox(width: 15),
                                            NutriInput(label: "Vitamin D", unit: "µg", controller: _vitaminDController),
                                            SizedBox(width: 15),
                                            NutriInput(label: "Vitamin E", unit: "mg", controller: _vitaminEController),
                                            SizedBox(width: 15),
                                            NutriInput(label: "Vitamin K", unit: "µg", controller: _vitaminKController),
                                            SizedBox(width: 15),
                                            NutriInput(label: "Choline", unit: "mg", controller: _cholineController),
                                            SizedBox(width: 8),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                    border: Border.all(color: Colors.green, width: 1.5),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ItemTitle(icon: Icons.terrain, text: 'Khoáng chất'),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(width: 8),
                                            NutriInput(label: "Canxi", unit: "mg", controller: _canxiController),
                                            SizedBox(width: 15),
                                            NutriInput(label: "Sắt", unit: "mg", controller: _feController),
                                            SizedBox(width: 15),
                                            NutriInput(label: "Magie", unit: "mg", controller: _mgController),
                                            SizedBox(width: 15),
                                            NutriInput(label: "Photpho", unit: "mg", controller: _photphoController),
                                            SizedBox(width: 15),
                                            NutriInput(label: "Kali", unit: "mg", controller: _kaliController),
                                            SizedBox(width: 15),
                                            NutriInput(label: "Natri", unit: "mg", controller: _natriController),
                                            SizedBox(width: 15),
                                            NutriInput(label: "Kẽm", unit: "mg", controller: _znController),
                                            SizedBox(width: 8),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15),
                                TextButton.icon(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      final isOke = _addIngredient(
                                        _nameFoodController.text,
                                        _thumnailController.text,
                                        selectedUnit!,
                                        double.tryParse(_gramPerUnitFoodController.text) ?? 0,
                                        int.tryParse(_kcalController.text) ?? 0,
                                        double.tryParse(_carbsController.text) ?? 0,
                                        double.tryParse(_sugarController.text) ?? 0,
                                        double.tryParse(_fiberController.text) ?? 0,
                                        double.tryParse(_proteinController.text) ?? 0,
                                        double.tryParse(_saturatedFatController.text) ?? 0,
                                        double.tryParse(_monounSaturatedFatController.text) ?? 0,
                                        double.tryParse(_polyunSaturatedFatController.text) ?? 0,
                                        double.tryParse(_transFatController.text) ?? 0,
                                        double.tryParse(_cholesterolController.text) ?? 0,
                                        double.tryParse(_vitaminAController.text) ?? 0,
                                        double.tryParse(_vitaminDController.text) ?? 0,
                                        double.tryParse(_vitaminCController.text) ?? 0,
                                        double.tryParse(_vitaminB6Controller.text) ?? 0,
                                        double.tryParse(_vitaminB12Controller.text) ?? 0,
                                        double.tryParse(_vitaminEController.text) ?? 0,
                                        double.tryParse(_vitaminKController.text) ?? 0,
                                        double.tryParse(_cholineController.text) ?? 0,
                                        double.tryParse(_canxiController.text) ?? 0,
                                        double.tryParse(_feController.text) ?? 0,
                                        double.tryParse(_mgController.text) ?? 0,
                                        double.tryParse(_photphoController.text) ?? 0,
                                        double.tryParse(_kaliController.text) ?? 0,
                                        double.tryParse(_natriController.text) ?? 0,
                                        double.tryParse(_znController.text) ?? 0,
                                        double.tryParse(_waterController.text) ?? 0,
                                        double.tryParse(_caffeinController.text) ?? 0,
                                        double.tryParse(_alcoholController.text) ?? 0,
                                      );
                                      if (await isOke) {
                                        Navigator.of(context).pop(true);
                                      }
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.green,
                                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                  ),
                                  icon: Icon(Icons.save, size: 24, color: Colors.white),
                                  label: Text(
                                    'Lưu nguyên liệu',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white, fontSize: 22, fontFamily: "SVN_Comic"),
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

  Future<void> _getFood(int id) async {
    final res = await SeverApi().infoIngredient(id);
    if (res != null && res.message == "Find successful") {
      final ing = res.ingredient;
      ingredient = res.ingredient;
      setState(() {
        _nameFoodController.text = ing.name;
        _thumnailController.text = ing.thumbnail;
        selectedUnit = ing.baseUnit;
        _gramPerUnitFoodController.text = ing.gramPerUnit.toString();

        _kcalController.text = ing.kcal.toString();
        _proteinController.text = ing.protein.toString();
        _waterController.text = ing.water.toString();
        _caffeinController.text = ing.caffeine.toString();
        _alcoholController.text = ing.alcohol.toString();
        _cholesterolController.text = ing.cholesterol.toString();

        _carbsController.text = ing.carbs.toString();
        _sugarController.text = ing.sugar.toString();
        _fiberController.text = ing.fiber.toString();

        _saturatedFatController.text = ing.saturatedFat.toString();
        _monounSaturatedFatController.text = ing.monounSaturatedFat.toString();
        _polyunSaturatedFatController.text = ing.polyunSaturatedFat.toString();
        _transFatController.text = ing.transFat.toString();

        _vitaminAController.text = ing.vitaminA.toString();
        _vitaminB6Controller.text = ing.vitaminB6.toString();
        _vitaminB12Controller.text = ing.vitaminB12.toString();
        _vitaminCController.text = ing.vitaminC.toString();
        _vitaminDController.text = ing.vitaminD.toString();
        _vitaminEController.text = ing.vitaminE.toString();
        _vitaminKController.text = ing.vitaminK.toString();
        _cholineController.text = ing.choline.toString();

        _canxiController.text = ing.canxi.toString();
        _feController.text = ing.fe.toString();
        _mgController.text = ing.magie.toString();
        _photphoController.text = ing.photpho.toString();
        _kaliController.text = ing.kali.toString();
        _natriController.text = ing.natri.toString();
        _znController.text = ing.zn.toString();
      });
    } else {
      await Fluttertoast.showToast(
        msg: "Không thể lấy thông tin nguyên liệu!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<bool> _addIngredient(
    String name,
    String thumbnail,
    String baseUnit,
    double gramPerUnit,
    int kcal,
    double carbs,
    double sugar,
    double fiber,
    double protein,
    double saturatedFat,
    double monounSaturatedFat,
    double polyunSaturatedFat,
    double transFat,
    double cholesterol,
    double vitaminA,
    double vitaminD,
    double vitaminC,
    double vitaminB6,
    double vitaminB12,
    double vitaminE,
    double vitaminK,
    double choline,
    double canxi,
    double fe,
    double magie,
    double photpho,
    double kali,
    double natri,
    double zn,
    double water,
    double caffeine,
    double alcohol,
  ) async {
    final req = Ingredient(
      id: ingredient.id,
      name: name,
      thumbnail: thumbnail,
      baseUnit: baseUnit,
      gramPerUnit: gramPerUnit,
      isConfirm: 1,
      kcal: kcal,
      carbs: carbs,
      sugar: sugar,
      fiber: fiber,
      protein: protein,
      saturatedFat: saturatedFat,
      monounSaturatedFat: monounSaturatedFat,
      polyunSaturatedFat: polyunSaturatedFat,
      transFat: transFat,
      cholesterol: cholesterol,
      vitaminA: vitaminA,
      vitaminD: vitaminD,
      vitaminC: vitaminC,
      vitaminB6: vitaminB6,
      vitaminB12: vitaminB12,
      vitaminE: vitaminE,
      vitaminK: vitaminK,
      choline: choline,
      canxi: canxi,
      fe: fe,
      magie: magie,
      photpho: photpho,
      kali: kali,
      natri: natri,
      zn: zn,
      water: water,
      caffeine: caffeine,
      alcohol: alcohol,
    );
    if (req == ingredient) {
      await Fluttertoast.showToast(
        msg: "Chưa có thông tin nào thay đổi!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    } else {
      final res = await SeverApi().updateIngredient(req);
      if (res != null && res.message == "Update ingredient successful") {
        await Fluttertoast.showToast(
          msg: "Sửa nguyên liệu thành công!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return true;
      } else {
        await Fluttertoast.showToast(
          msg: "Chưa thể thêm nguyên liệu mới!",
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
}
