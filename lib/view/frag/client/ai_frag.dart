import 'package:al_datn_my_health/view/custom_view/item_message.dart';
import 'package:flutter/material.dart';

class AiFrag extends StatefulWidget {
  @override
  _AiFragState createState() => _AiFragState();
}

class _AiFragState extends State<AiFrag> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool isEdit = true;

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'role': 'user', 'text': text});
      isEdit = false;
    });
    _controller.clear();
    _scrollToBottom();

    setState(() {
      _messages.add({'role': 'ai', 'text': 'Đang xử lý...', 'type': 'loading'});
    });
    _scrollToBottom();

    final aiReply = await _getAIResponse(text);

    setState(() {
      _messages.removeLast();
      _messages.add({'role': 'ai', 'text': aiReply});
      isEdit = true;
    });
    _scrollToBottom();
  }

  Future<String> _getAIResponse(String message) async {
    try {
      return await Future.delayed(
        Duration(seconds: 3),
        () => "Đã nhận được câu hỏi của bạn.",
      );
    } catch (e) {
      return 'Không thể kết nối đến server.';
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
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

  @override
  Widget build(BuildContext context) {
    String hint;
    if (isEdit) {
      hint = 'Viết câu hỏi của bạn vào đây!';
    } else {
      hint = 'Đang đợi phản hồi của chuyên gia!';
    }
    return Column(
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
                'Chuyên gia',
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
          child:
              _messages.isEmpty
                  ? Image.asset("assets/images/ic_robot.jpg")
                  : ListView.builder(
                    controller: _scrollController,
                    itemCount: _messages.length,
                    itemBuilder: (_, index) {
                      final msg = _messages[index];
                      final isUser = msg['role'] == 'user';
                      return _buildMessageText(msg['text'] ?? '', !isUser);
                    },
                  ),
        ),
        Container(height: 1, color: Colors.green),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  enabled: isEdit,
                  controller: _controller,
                  cursorColor: Colors.black,
                  onSubmitted: (_) => _sendMessage(),
                  decoration: InputDecoration(
                    hintText: hint,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.green, width: 1.5),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send, color: Colors.green),
                onPressed: _sendMessage,
              ),
            ],
          ),
        ),
        Container(height: 1, color: Colors.green),
      ],
    );
  }
}
