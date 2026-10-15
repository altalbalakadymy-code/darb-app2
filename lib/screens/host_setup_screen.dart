import 'package:flutter/material.dart';
import 'qr_host_screen.dart'; // سنقوم بإنشائها لعرض الـ QR والـ IP

class HostSetupScreen extends StatefulWidget {
  const HostSetupScreen({super.key});

  @override
  State<HostSetupScreen> createState() => _HostSetupScreenState();
}

class _HostSetupScreenState extends State<HostSetupScreen> {
  int _playerCount = 8; // العدد الافتراضي للاعبين
  bool _enableSilenceMafia = true;
  bool _enableDoctor = true;
  bool _enableSniper = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إعداد غرفة المافيا (المدير)'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const Text(
              'اختر عدد اللاعبين في الجلسة المحلية:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: _playerCount.toDouble(),
              min: 5,
              max: 20,
              divisions: 15,
              label: '$_playerCount لاعباً',
              activeColor: Colors.redAccent,
              onChanged: (double value) {
                setState(() {
                  _playerCount = value.toInt();
                });
              },
            ),
            Text(
              'العدد المحدد: $_playerCount لاعباً',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, color: Colors.amber),
            ),
            const Divider(height: 40, color: Colors.grey),
            const Text(
              'تفعيل أو تعطيل الأدوار الخاصة:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              title: const Text('مافيا التسكيت'),
              subtitle: const Text('يمنع شخصاً من الكلام في النهار'),
              value: _enableSilenceMafia,
              activeColor: Colors.redAccent,
              onChanged: (bool value) {
                setState(() {
                  _enableSilenceMafia = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('الإسعاف (الطبيب)'),
              subtitle: const Text('يحمي شخصاً من اغتيال المافيا ليلاً'),
              value: _enableDoctor,
              activeColor: Colors.redAccent,
              onChanged: (bool value) {
                setState(() {
                  _enableDoctor = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('قناص الصالحين'),
              subtitle: const Text('يمتلك رصاصة واحدة للتصفيّة الفورية'),
              value: _enableSniper,
              activeColor: Colors.redAccent,
              onChanged: (bool value) {
                setState(() {
                  _enableSniper = value;
                });
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade800,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                // الانتقال لشاشة عرض الـ QR وفتح الغرفة للاعبين
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QrHostScreen(
                      playerCount: _playerCount,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.wifi_tethering),
              label: const Text(
                'فتح الغرفة وبدء استقبال اللاعبين',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
