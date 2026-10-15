import 'package:flutter/material.dart';
import '../models/player_model.dart';
import 'night_screen.dart';
import 'day_screen.dart';
import 'voting_screen.dart';

class GameControllerScreen extends StatefulWidget {
  final PlayerRole myRole;
  final List<Player> players;

  const GameControllerScreen({super.key, required this.myRole, required this.players});

  @override
  State<GameControllerScreen> createState() => _GameControllerScreenState();
}

class _GameControllerScreenState extends State<GameControllerScreen> {
  int gamePhase = 1; // 1: Night, 2: Day, 3: Voting

  @override
  Widget build(BuildContext context) {
    if (gamePhase == 1) {
      return NightScreen(
        myRole: widget.myRole,
        allPlayers: widget.players,
        onActionSelected: (role, targetId) {
          // بعد انتهاء الليل، ننتقل لمرحلة النهار
          setState(() {
            gamePhase = 2;
          });
        },
      );
    } else if (gamePhase == 2) {
      return DayScreen(
        isMuted: false, // يتم جلبها من حالة اللاعب
        onSendMessage: (msg) {
          // الانتقال لمرحلة التصويت بعد النقاش
          setState(() {
            gamePhase = 3;
          });
        },
      );
    } else {
      return VotingScreen(
        players: widget.players,
        onVoteCasted: (targetId) {
          // العودة لمرحلة الليل للجولة التالية
          setState(() {
            gamePhase = 1;
          });
        },
      );
    }
  }
}
