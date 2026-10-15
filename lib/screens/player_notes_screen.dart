import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerNotesScreen extends StatefulWidget {
  const PlayerNotesScreen({super.key});

  @override
  State<PlayerNotesScreen> createState() => _PlayerNotesScreenState();
}

class _PlayerNotesScreenState extends State<PlayerNotesScreen> {
  final TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedNotes();
  }

  // حفظ الملاحظات محلياً على هاتف اللاعب لكي لا يراها غيره
  Future<void> _saveNotes(String text) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('my_secret_notes', text);
  }

  Future<void> _loadSavedNotes() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notesController.text = prefs.getString('my_secret_notes') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مفكرتي السرية 📝'),
        backgroundColor: Colors.grey.shade900,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'اكتب هنا ملاحظاتك الشخصية وشكوكك حول بقية اللاعبين (لا يمكن لأحد رؤيتها غيرك):',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: TextField(
                controller: _notesController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlign.top,
                onChanged: (value) {
                  _saveNotes(value);
                },
                decoration: const InputDecoration(
                  hintText: 'مثلاً: اللاعب أحمد دافع عن محمد، قد يكون مافيا...',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Color(0xFF1E1E1E),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '💾 يتم حفظ الملاحظات تلقائياً أثناء الكتابة.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.amber, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
