import 'dart:math';
import 'package:al_datn_my_health/api/ai_api.dart';
import 'package:al_datn_my_health/model/req/chat_req.dart';
import 'package:al_datn_my_health/view/custom_view/item_message.dart';
import 'package:flutter/material.dart';

import '../../../common_utils.dart';

class AiFrag extends StatefulWidget {
  @override
  _AiFragState createState() => _AiFragState();
}

class _AiFragState extends State<AiFrag> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool isEdit = true;
  String threadId = "";

  @override
  void initState() {
    super.initState();
    threadId = random6Letters();
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    // 1. Thêm tin nhắn User
    setState(() {
      _messages.add({'role': 'user', 'text': text});
      isEdit = false; // Khóa nhập liệu
    });
    _controller.clear();
    _scrollToBottom();

    // 2. Thêm tin nhắn AI Rỗng (để hứng chữ)
    setState(() {
      _messages.add({'role': 'ai', 'text': ''});
    });
    _scrollToBottom();

    // 3. Gọi Stream
    _handleStream(text);
  }

  Future<void> _handleStream(String message) async {
    print("--- Bắt đầu Stream ---");

    final idUserInfo = await CommonUtils().getPref("idUserInfo");
    final userId = int.tryParse(idUserInfo.toString());

    if (userId == null) return;

    final req = ChatReq(
        userId: userId.toString(),
        message: message,
        threadId: threadId
    );

    // Gọi API
    AiApi().chatAI(req).listen(
          (chunk) {
        // [LOGIC QUAN TRỌNG]: Khi có chunk mới, cập nhật ngay vào UI
        if (mounted) {
          setState(() {
            // Lấy tin nhắn cuối cùng (là tin AI rỗng vừa tạo) và nối thêm chữ
            String currentText = _messages.last['text'] ?? "";
            _messages.last['text'] = currentText + chunk;
          });

          // Cuộn xuống liên tục
          _scrollToBottom();
        }
      },
      onDone: () {
        print("--- Kết thúc Stream ---");
        if (mounted) {
          setState(() {
            isEdit = true; // Mở khóa lại
          });
        }
      },
      onError: (e) {
        print("Lỗi: $e");
        if (mounted) {
          setState(() {
            String currentText = _messages.last['text'] ?? "";
            _messages.last['text'] = currentText + "\n[Lỗi kết nối]";
            isEdit = true;
          });
        }
      },
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        // animateTo đôi khi bị giật nếu gọi quá nhanh, jumpTo mượt hơn cho stream
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  Widget _buildMessageText(String text, bool isAI) {
    return ItemMessage(text: text, isAI: isAI);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  String random6Letters() {
    const letters = 'abcdefghijklmnopqrstuvwxyz';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        6,
            (_) => letters.codeUnitAt(random.nextInt(letters.length)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String hint = isEdit ? 'Viết câu hỏi...' : 'AI đang trả lời...';

    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: Image.asset('assets/images/ic_logo_app.png', width: 56, height: 56),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                'Chuyên gia',
                style: TextStyle(fontFamily: "SVN_SAF", fontSize: 24, color: Colors.green),
              ),
            ),
          ],
        ),
        Container(height: 1, color: Colors.green),
        Expanded(
          child: _messages.isEmpty
              ? Image.asset("assets/images/ic_robot.jpg")
              : ListView.builder(
            controller: _scrollController,
            itemCount: _messages.length,
            itemBuilder: (_, index) {
              final msg = _messages[index];
              return _buildMessageText(msg['text'] ?? '', msg['role'] != 'user');
            },
          ),
        ),
        Container(height: 1, color: Colors.green),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  enabled: isEdit,
                  controller: _controller,
                  onSubmitted: (_) => isEdit ? _sendMessage() : null,
                  decoration: InputDecoration(
                    hintText: hint,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send, color: isEdit ? Colors.green : Colors.grey),
                onPressed: isEdit ? _sendMessage : null,
              ),
            ],
          ),
        ),
        Container(height: 1, color: Colors.green),
      ],
    );
  }
}