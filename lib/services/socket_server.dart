import 'package:socket_io/socket_io.dart';
import 'package:flutter/foundation.dart';
import '../models/player_model.dart';

class LocalSocketServer {
  late Server _server;
  final List<Player> connectedPlayers = [];
  bool isGameStarted = false;

  void startServer() {
    // تشغيل السيرفر المحلي على البورت 8080
    _server = Server();

    _server.on('connection', (client) {
      debugPrint('انضم جهاز جديد: ${client.id}');

      // استقبال بيانات تسجيل اللاعب عند دخوله
      client.on('join_game', (data) {
        String playerName = data['name'] ?? 'لاعب';
        
        Player newPlayer = Player(
          id: client.id,
          name: playerName,
          role: PlayerRole.citizen, // سيتم التوزيع لاحقاً عند بدء اللعبة
        );

        connectedPlayers.add(newPlayer);
        debugPrint('تم تسجيل اللاعب: $playerName (إجمالي اللاعبين: ${connectedPlayers.length})');

        // إرسال تحديث بقائمة اللاعبين لجميع المتصلين في الغرفة
        _server.emit('update_players', connectedPlayers.map((p) => p.toJson()).toList());
      });

      // استقبال أحداث التصويت أو القرارات الليلية
      client.on('night_action', (data) {
        // معالجة اختيار المافيا أو الطبيب
        debugPrint('استلام إجراء ليلي: $data');
      });

      client.on('disconnect', (_) {
        debugPrint('انقطع اتصال اللاعب: ${client.id}');
        connectedPlayers.removeWhere((p) => p.id == client.id);
        _server.emit('update_players', connectedPlayers.map((p) => p.toJson()).toList());
      });
    });

    _server.listen(8080);
    debugPrint('تم تشغيل سيرفر الـ Host المحلي بنجاح على البورت 8080');
  }

  // دالة لتوزيع الأدوار عشوائياً عند بدء اللعبة
  void distributeRoles() {
    if (connectedPlayers.isEmpty) return;
    
    // خلط اللاعبين لتوزيع الأدوار عشوائياً
    connectedPlayers.shuffle();
    
    // تخصيص الأدوار بناءً على العدد (مثال مبسط)
    for (int i = 0; i < connectedPlayers.length; i++) {
      if (i == 0) {
        connectedPlayers[i].role = PlayerRole.mafiaBoss;
      } else if (i == 1 && connectedPlayers.length > 5) {
        connectedPlayers[i].role = PlayerRole.doctor;
      } else if (i == 2 && connectedPlayers.length > 7) {
        connectedPlayers[i].role = PlayerRole.sniper;
      } else {
        connectedPlayers[i].role = PlayerRole.citizen;
      }
    }
    
    isGameStarted = true;
    // إعلام كل لاعب بدوره الخاص سراً
    for (var player in connectedPlayers) {
      _server.to(player.id).emit('your_role', {'role': player.role.index});
    }
    debugPrint('تم توزيع الأدوار وإرسالها سراً للاعبين.');
  }

  void stopServer() {
    _server.close();
    debugPrint('تم إيقاف السيرفر المحلي.');
  }
}
