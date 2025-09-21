import 'package:flutter/material.dart';

import '../../model/hashtag.dart';

class HashtagDialog extends StatefulWidget {
  const HashtagDialog({super.key});

  @override
  _HashtagDialogState createState() => _HashtagDialogState();
}

class _HashtagDialogState extends State<HashtagDialog> {
  List<Hashtag> items = [
    Hashtag(id: 1, title: '#Sữa'),
    Hashtag(id: 2, title: '#Thịt'),
    Hashtag(id: 3, title: '#Trứng'),
    Hashtag(id: 4, title: '#HảiSản'),
    Hashtag(id: 5, title: '#Hạt'),
    Hashtag(id: 6, title: '#ĐồLênMen'),
    Hashtag(id: 7, title: '#ThịtĐỏ'),
    Hashtag(id: 8, title: '#MónChính'),
    Hashtag(id: 9, title: '#RauXanh'),
    Hashtag(id: 10, title: '#TráiCây'),
    Hashtag(id: 11, title: '#BánhNgọt'),
    Hashtag(id: 12, title: '#Lẩu'),
  ];

  Set<int> selectedIds = {};

  Widget buildItem(Hashtag item) {
    bool isSelected = selectedIds.contains(item.id);

    return InkWell(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedIds.remove(item.id);
          } else {
            selectedIds.add(item.id);
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              value: isSelected,
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    selectedIds.add(item.id);
                  } else {
                    selectedIds.remove(item.id);
                  }
                });
              },
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                item.title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontFamily: "SVN_Comic",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Thêm Hashtag",
        style: TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontFamily: "SVN_Comic",
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView(
          shrinkWrap: true,
          children: items.map((item) => buildItem(item)).toList(),
        ),
      ),
      actions: [
        TextButton(
          child: const Text(
            "Đồng ý",
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 20,
              fontFamily: "SVN_Comic",
            ),
          ),
          onPressed: () {
            final selectedHashtags =
                items.where((item) => selectedIds.contains(item.id)).toList();
            Navigator.of(context).pop(selectedHashtags);
          },
        ),
      ],
    );
  }
}
