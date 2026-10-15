import 'package:flutter/material.dart';
import '../models/player_model.dart';

class HostNightDashboard extends StatefulWidget {
  final List<Player> players;
  final Function(String mafiaVictim, String savedVictim, String mutedPlayer) onNightFinished;

  const HostNightDashboard({
    super.key,
    required this.players,
    required this.onNightFinished,
  });

  @override
  State<HostNightDashboard> createState() => _HostNightDashboardState();
}

class _HostNightDashboardState extends State<HostNightDashboard> {
  String? mafiaVictimId;
  String? savedVictimId;
  String? mutedPlayerId;
  int nightStep = 1; // 1: Mafia, 2: Doctor, 3: Mute Mafia

  @override
  Widget build(BuildContext context) {
    var alivePlayers = widget.players.where((p) => p.status == PlayerStatus.alive).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF090912),
      appBar: AppBar(
        title: Text(nightStep == 1 ? 'الليل: اختيار المافيا' : nightStep == 2 ? 'الليل: اختيار الطبيب' : 'الليل: التسكيت'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Icon(Icons.nightlight_round, size: 50, color: Colors.indigoAccent),
            const SizedBox(height: 10),
            Text(
              nightStep == 1
                  ? 'اطلب من المافيا فتح أعينهم سراً واختيار الضحية:'
                  : nightStep == 2
                      ? 'اطلب من الطبيب فتح عينه واختيار من سيحميه:'
                      : 'اطلب من مافيا التسكيت اختيار من سيتم إسكاته غداً:',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.amber, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: alivePlayers.length,
                itemBuilder: (context, index) {
                  var player = alivePlayers[index];
                  bool isSelected = (nightStep == 1 && mafiaVictimId == player.id) ||
                      (nightStep == 2 && savedVictimId == player.id) ||
                      (nightStep == 3 && mutedPlayerId == player.id);

                  return Card(
                    color: isSelected ? Colors.red.shade900 : Colors.grey.shade900,
                    child: ListTile(
                      title: Text(player.name, style: const TextStyle(color: Colors.white)),
                      trailing: isSelected ? const Icon(Icons.check, color: Colors.white) : null,
                      onTap: () {
                        setState(() {
                          if (nightStep == 1) {
                            mafiaVictimId = player.id;
                          } else if (nightStep == 2) {
                            savedVictimId = player.id;
                          } else {
                            mutedPlayerId = player.id;
                          }
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                setState(() {
                  if (nightStep < 3) {
                    nightStep++; // الانتقال للخطوة التالية في الليل
                  } else {
                    // انتهى الليل، إرسال النتائج
                    widget.onNightFinished(
                      mafiaVictimId ?? '',
                      savedVictimId ?? '',
                      mutedPlayerId ?? '',
                    );
                  }
                });
              },
              child: Text(
                nightStep < 3 ? 'التالي (الخطوة التالية)' : 'شروق الشمس (إعلان النتائج)',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
