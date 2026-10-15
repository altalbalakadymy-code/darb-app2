import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:network_info_plus/network_info_plus.dart';

class QrHostScreen extends StatefulWidget {
  final int playerCount;

  const QrHostScreen({super.key, required this.playerCount});

  @override
  State<QrHostScreen> createState() => _QrHostScreenState();
}

class _QrHostScreenState extends State<QrHostScreen> {
  String _hostIp = "192.168.43.1"; // القيمة الافتراضية للـ Hotspot في أندرويد
  bool _isLoadingIp = true;

  @override
  void initState() {
    super.initState();
    _fetchHotspotIp();
  }

  // دالة لجلب عنوان الـ IP الخاص بالشبكة المحلية للـ Hotspot تلقائياً
  Future<void> _fetchHotspotIp() async {
    final info = NetworkInfo();
    try {
      String? wifiIp = await info.getWifiIP();
      if (wifiIp != null && wifiIp.isNotEmpty) {
        setState(() {
          _hostIp = wifiIp;
          _isLoadingIp = false;
        });
      } else {
        setState(() {
          _isLoadingIp = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoadingIp = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // بناء رابط الاتصال الكامل مع البورت الافتراضي للسيرفر (مثلاً 8080)
    final String connectionData = "$_hostIp:8080";

    return Scaffold(
      appBar: AppBar(
        title: const Text('غرفة الانتظار (المدير - Hotspot)'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'قم بتشغيل الـ Hotspot في هاتفك، واجعل اللاعبين يتصلون به ثم يمسحون الكود:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            _isLoadingIp
                ? const CircularProgressIndicator(color: Colors.redAccent)
                : Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: QrImageView(
                      data: connectionData,
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                  ),
            const SizedBox(height: 20),
            const Text(
              'عنوان الـ IP الخاص بنقطة الاتصال (Hotspot):',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 5),
            Text(
              connectionData,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'تأكد أن جميع اللاعبين متصلين بشبكة الـ Wi-Fi التابعة لهاتفك قبل بدء اللعبة.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.redAccent),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade700,
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم بدء الجلسة وتوزيع الأدوار سراً على المتصلين!')),
                );
              },
              child: const Text('بدء اللعبة الآن', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
