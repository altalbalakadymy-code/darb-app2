import 'package:flutter/material.dart';

class DayScreen extends StatefulWidget {
  final bool isMuted;
  final Function(String) onSendMessage;

  const DayScreen({super.key, required this.isMuted, required this.onSendMessage});

  @override
  State<DayScreen> createState() => _DayScreenState();
}

class _DayScreenState extends State<DayScreen> {
  final TextEditingController _msgController = TextEditingController();
  final List<String> messages = [
    "المدير: بدأ شجار النهار! ناقشوا من هو المشتبه به.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مرحلة النهار - النقاش الجماعي'),
        backgroundColor: Colors.brown.shade800,
        centerTitle: true,
      ),
      body: Column(
        children: [
          if (widget.isMuted)
            Container(
              color: Colors.red.shade900,
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              child: const Text(
                '⚠️ تم منعك من الكلام في هذه الجولة بواسطة مافيا التسكيت!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index], style: const TextStyle(color: Colors.white)),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _msgController,
                    enabled: !widget.isMuted, // تعطيل الكتابة إذا كان اللاعب مسكوتاً
                    decoration: InputDecoration(
                      hintText: widget.isMuted ? 'أنت ممنوع من الكلام...' : 'اكتب رسالتك للنقاش...',
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey.shade900,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.amber),
                  onPressed: widget.isMuted ? null : () {
                    if (_msgController.text.isNotEmpty) {
                      widget.onSendMessage(_msgController.text);
                      setState(() {
                        messages.add("أنت: ${_msgController.text}");
                        _msgController.clear();
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
