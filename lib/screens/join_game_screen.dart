import 'package:flutter/material.dart';

class JoinGameScreen extends StatefulWidget {
  const JoinGameScreen({super.key});

  @override
  State<JoinGameScreen> createState() => _JoinGameScreenState();
}

class _JoinGameScreenState extends State<JoinGameScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الانضمام إلى لعبة المافيا'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.group_add, size: 80, color: Colors.redAccent),
            const SizedBox(height: 30),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'اسم اللاعب المستعار',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _ipController,
              decoration: const InputDecoration(
                labelText: 'عنوان IP الخاص بالمدير (Host IP)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.router),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade800,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                if (_nameController.text.isEmpty || _ipController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('الرجاء إدخال الاسم وعنوان الـ IP')),
                  );
                  return;
                }
                // TODO: ربط الاتصال بالسيرفر المحلي للانضمام
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('جاري الانضمام إلى الغرفة ${_ipController.text}...')),
                );
              },
              icon: const Icon(Icons.login),
              label: const Text('دخول الغرفة', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
