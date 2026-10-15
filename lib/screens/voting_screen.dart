import 'package:flutter/material.dart';
import '../models/player_model.dart';

class VotingScreen extends StatefulWidget {
  final List<Player> players;
  final Function(String) onVoteCasted;

  const VotingScreen({super.key, required this.players, required this.onVoteCasted});

  @override
  State<VotingScreen> createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  String? votedPlayerId;

  @override
  Widget build(BuildContext context) {
    var alivePlayers = widget.players.where((p) => p.status == PlayerStatus.alive).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF120A12),
      appBar: AppBar(
        title: const Text('مرحلة التصويت والإقصاء'),
        backgroundColor: Colors.deepOrange.shade900,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Icon(Icons.how_to_vote, size: 60, color: Colors.amber),
            const SizedBox(height: 10),
            const Text(
              'اختر اللاعب الذي تشك أنه من المافيا لإقصائه:',
              style: TextStyle(fontSize: 16, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: alivePlayers.length,
                itemBuilder: (context, index) {
                  var player = alivePlayers[index];
                  bool isSelected = votedPlayerId == player.id;

                  return Card(
                    color: isSelected ? Colors.deepOrange.shade800 : Colors.grey.shade900,
                    child: ListTile(
                      title: Text(player.name, style: const TextStyle(color: Colors.white)),
                      trailing: isSelected ? const Icon(Icons.check_circle, color: Colors.amber) : null,
                      onTap: () {
                        setState(() {
                          votedPlayerId = player.id;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade900,
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: votedPlayerId == null ? null : () {
                widget.onVoteCasted(votedPlayerId!);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم تسجيل صوتك بنجاح!')),
                );
              },
              child: const Text('تأكيد التصويت', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
