import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لعبة المافيا (بدون إنترنت)'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.nightlife,
              size: 100,
              color: Colors.redAccent,
            ),
            const SizedBox(height: 20),
            const Text(
              'أهلاً بك في مدينة الظلام',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            
            // زر إنشاء لعبة جديدة (مدير اللعبة - Host)
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade900,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                // الانتقال إلى شاشة إعدادات الغرفة للـ Host
                // TODO: الانتقال لشاشة إنشاء اللعبة
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('جارٍ الانتقال لإنشاء الغرفة كمدير...')),
                );
              },
              icon: const Icon(Icons.add_moderator),
              label: const Text('إنشاء لعبة جديدة (مدير اللعبة)'),
            ),
            
            const SizedBox(height: 20),
            
            // زر الانضمام إلى اللعبة (Client)
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: const BorderSide(color: Colors.redAccent, width: 2),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                // الانتقال إلى شاشة مسح الـ QR أو كتابة الـ IP للانضمام
                // TODO: الانتقال لشاشة انضمام اللاعبين
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('جارٍ الانتقال للانضمام إلى الغرفة...')),
                );
              },
              icon: const Icon(Icons.login),
              label: const Text('انضمام إلى لعبة قائمة'),
            ),
          ],
        ),
      ),
    );
  }
}
