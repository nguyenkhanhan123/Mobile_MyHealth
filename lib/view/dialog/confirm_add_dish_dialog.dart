import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../api/sever_api.dart';
import '../../../model/res/info_dish_res.dart';

class ConfirmAddDishDialog extends StatefulWidget {
  final String dishName;
  final String mealName; // Tên bữa ăn (Sáng, Trưa, Tối...)
  final double ratio;    // Tỷ lệ ăn (1.0, 0.5, 2.0...)

  const ConfirmAddDishDialog({
    super.key,
    required this.dishName,
    required this.mealName,
    required this.ratio,
  });

  @override
  State<ConfirmAddDishDialog> createState() => _ConfirmAddDishDialogState();
}

class _ConfirmAddDishDialogState extends State<ConfirmAddDishDialog> {
  bool isLoading = true;
  double totalWeight = 0;
  int? foundDishId;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchAndCalculate();
  }

  Future<void> _fetchAndCalculate() async {
    try {
      // Gọi API lấy thông tin món ăn từ tên
      final res = await SeverApi().infoDish2(widget.dishName);

      if (res != null && res.message == "Find successful" && mounted) {
        foundDishId = res.dish.id;
        double tempTotal = 0;
        for (var ingredient in res.dish.ingredients) {
          double weightInGram = (ingredient.weight * ingredient.gramPerUnit!).toDouble();
          tempTotal += weightInGram;
        }

        setState(() {
          totalWeight = tempTotal * widget.ratio;
          isLoading = false;
        });
      } else {
        _handleError("Không tìm thấy dữ liệu món ăn này");
      }
    } catch (e) {
      _handleError("Lỗi kết nối: $e");
    }
  }

  void _handleError(String message) {
    if (mounted) {
      setState(() {
        isLoading = false;
        errorMessage = message;
      });
      Fluttertoast.showToast(msg: message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          const Icon(Icons.playlist_add_check_circle, color: Colors.green, size: 28),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              "Xác nhận thêm món",
              style: TextStyle(
                fontFamily: "SVN_SAF", // Font theo style app của bạn
                fontSize: 22,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
      content: Container(
        constraints: const BoxConstraints(minHeight: 100),
        child: isLoading
            ? const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: Colors.green),
              SizedBox(height: 16),
              Text(
                "Đang lấy dữ liệu...",
                style: TextStyle(fontSize: 14, color: Colors.grey, fontFamily: 'Nunito'),
              ),
            ],
          ),
        )
            : errorMessage != null
            ? Center(
          child: Text(
            errorMessage!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.redAccent),
          ),
        )
            : Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(Icons.restaurant, "Bữa ăn:", widget.mealName),
            const SizedBox(height: 12),
            _buildDetailRow(Icons.fastfood, "Món:", widget.dishName),
            const SizedBox(height: 12),
            _buildDetailRow(Icons.pie_chart, "Khẩu phần:", "x${widget.ratio}"),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Divider(thickness: 1, color: Colors.grey),
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Expanded(
                  child: Text(
                    "Tổng khối lượng:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Text(
                  "${totalWeight.toStringAsFixed(1)} g",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontFamily: 'SVN_Comic',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(false),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.grey),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          child: const Text("Hủy bỏ", style: TextStyle(color: Colors.grey)),
        ),
        ElevatedButton(
          onPressed: (isLoading || errorMessage != null)
              ? null
              : () {
            Navigator.of(context).pop({
              'dishId': foundDishId,
              'weight': totalWeight,
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            elevation: 2,
          ),
          child: const Text(
            "Đồng ý",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.green.withOpacity(0.7)),
        const SizedBox(width: 10),
        Text(title, style: const TextStyle(color: Colors.black54, fontSize: 15)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}