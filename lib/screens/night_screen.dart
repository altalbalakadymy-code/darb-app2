import 'package:flutter/material.dart';
import '../models/player_model.dart';

class NightScreen extends StatefulWidget {
  final PlayerRole myRole;
  final List<Player> allPlayers;
  final Function(String, String) onActionSelected;

  const NightScreen({
    super.key,
    required this.myRole,
    required this.allPlayers,
    required this.onActionSelected,
  });

  @override
  State<NightScreen> createState() => _NightScreenState();
}

class _NightScreenState extends State<NightScreen> {
  String? selectedTargetId;

  String getRoleTitle() {
    switch (widget.myRole) {
      case PlayerRole.mafiaBoss:
        return 'شيخ المافيا: اختر ضحيتك لتصفيتها';
      case PlayerRole.mafiaMute:
        return 'مافيا التسكيت: اختر شخصاً لمنعه من الكلام غداً';
      case PlayerRole.doctor:
        return 'الطبيب (الإسعاف): اختر شخصاً لإنقاذ حياته';
      case PlayerRole.sniper:
        return 'القناص: هل تود إطلاق رصاصتك القاتلة؟';
      default:
        return 'مرحلة الليل: انتظر حتى يستيقظ الجميع...';
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSpecialRole = widget.myRole != PlayerRole.citizen && widget.myRole != PlayerRole.goodKid;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A12),
      appBar: AppBar(
        title: const Text('الليل حالك - مرحلة الأدوار'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Icon(Icons.nights_stay, size: 70, color: Colors.indigoAccent),
            const SizedBox(height: 15),
            Text(
              getRoleTitle(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber),
            ),
            const SizedBox(height: 20),
            if (isSpecialRole) ...[
              const Text(
                'اختر اللاعب المستهدف من القائمة:',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.allPlayers.where((p) => p.status == PlayerStatus.alive).length,
                  itemBuilder: (context, index) {
                    var alivePlayers = widget.allPlayers.where((p) => p.status == PlayerStatus.alive).toList();
                    var player = alivePlayers[index];
                    bool isSelected = selectedTargetId == player.id;

                    return Card(
                      color: isSelected ? Colors.red.shade900 : Colors.grey.shade900,
                      child: ListTile(
                        title: Text(player.name),
                        trailing: isSelected ? const Icon(Icons.check, color: Colors.white) : null,
                        onTap: () {
                          setState(() {
                            selectedTargetId = player.id;
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
                onPressed: selectedTargetId == null ? null : () {
                  widget.onActionSelected(widget.myRole.name, selectedTargetId!);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم إرسال قرارك السري بنجاح!')),
                  );
                },
                child: const Text('تأكيد الاختيار الليلي', style: TextStyle(fontSize: 16)),
              ),
            ] else ...[
              const Spacer(),
              const Text(
                'أنت مواطن صالح.. تنم في هذه اللحظات بسلام وتنتظر شروق الشمس.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const Spacer(),
            ],
          ],
        ),
      ),
    );
  }
}
