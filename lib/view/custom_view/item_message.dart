import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ItemMessage extends StatelessWidget {
  final String text;
  final bool isAI;

  const ItemMessage({super.key, required this.text, required this.isAI});

  @override
  Widget build(BuildContext context) {
    final TextStyle baseStyle = const TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontFamily: "SVN_Comic",
    );

    return isAI
        ? Container(
      margin: const EdgeInsets.only(right: 25),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blue, width: 2),
            ),
            child: const Icon(Icons.bolt, color: Colors.black, size: 24),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              // --- THAY ĐỔI Ở ĐÂY ---
              child: MarkdownBody(
                data: text,
                selectable: true, // Cho phép copy text
                // Cấu hình style để giống với thiết kế cũ (font SVN_Comic)
                styleSheet: MarkdownStyleSheet(
                  p: baseStyle, // Text thường
                  strong: baseStyle.copyWith(fontWeight: FontWeight.bold), // Text in đậm (**...**)
                  em: baseStyle.copyWith(fontStyle: FontStyle.italic), // Text in nghiêng (*...*)
                  blockSpacing: 8.0, // Khoảng cách giữa các đoạn
                  listBullet: baseStyle, // Style cho dấu chấm đầu dòng
                ),
              ),
              // ---------------------
            ),
          ),
        ],
      ),
    )
        : Container(
      margin: const EdgeInsets.only(left: 25),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              // Tin nhắn của User thường không cần Markdown, giữ nguyên Text để canh lề phải dễ hơn
              child: Text(
                text,
                softWrap: true,
                textAlign: TextAlign.end,
                style: baseStyle,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blue, width: 2),
            ),
            child:
            const Icon(Icons.person, color: Colors.black, size: 24),
          ),
        ],
      ),
    );
  }
}