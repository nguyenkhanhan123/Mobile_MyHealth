import 'package:flutter/material.dart';

class NutriInput extends StatelessWidget {
  final String label;
  final String unit;
  final TextEditingController controller;
  final bool isInteger;

  const NutriInput({
    super.key,
    required this.label,
    required this.unit,
    required this.controller,
    this.isInteger = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "$label:",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: "SVN_Comic",
          ),
        ),
        const SizedBox(width: 4),
        Container(
          width: 58,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: TextFormField(
            controller: controller,
            cursorColor: Colors.black,
            maxLines: 1,
            maxLength: 5,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.numberWithOptions(
              signed: false,
              decimal: true,
            ),
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green, width: 2),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green, width: 3),
              ),
              counterText: "",
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "";
              }
              if (isInteger) {
                if (int.tryParse(value) == null) {
                  return "";
                }
              } else {
                if (double.tryParse(value) == null) {
                  return "";
                }
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: 4),
        Text(
          unit,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: "SVN_Comic",
          ),
        ),
      ],
    );
  }
}
