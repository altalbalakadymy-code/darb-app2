import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/foundation.dart';

class LocalSocketClient {
  late IO.Socket socket;

  void connectToServer(String hostIp, String playerName, Function(int) onRoleReceived) {
    // الاتصال بعنوان الـ IP الخاص بالمدير عبر البورت 8080
    socket = IO.io('http://$hostIp:8080', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.onConnect((_) {
      debugPrint('تم الاتصال بنجاح بغرفة المدير!');
      // إرسال اسم اللاعب للانضمام للغرفة
      socket.emit('join_game', {'name': playerName});
    });

    // استقبال الدور سراً عند بدء اللعبة
    socket.on('your_role', (data) {
      int roleIndex = data['role'];
      debugPrint('تلقيت دوري في اللعبة سراً، الرقم: $roleIndex');
      onRoleReceived(roleIndex);
    });

    socket.onDisconnect((_) => debugPrint('انقطع الاتصال عن الغرفة.'));
  }

  void sendAction(String eventName, Map<String, dynamic> data) {
    socket.emit(eventName, data);
  }

  void disconnect() {
    socket.disconnect();
  }
}
