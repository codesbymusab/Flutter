import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studdy_buddy/services/study_services.dart';

class AppTimer extends StatefulWidget {
  final int seconds;
  final VoidCallback onTimerFinished;
  const AppTimer({
    super.key,
    required this.seconds,
    required this.onTimerFinished,
  });

  @override
  State<AppTimer> createState() => _AppTimerState();
}

class _AppTimerState extends State<AppTimer> {
  late final Timer timer;
  final Duration duration = Duration(seconds: 1);
  late int remainingSeconds;
  String time = '00:00';

  @override
  void initState() {
    super.initState();
    remainingSeconds = widget.seconds;
    timer = Timer.periodic(duration, (Timer timer) {
      if (remainingSeconds == 0) {
        timer.cancel();
        widget.onTimerFinished();
      } else {
        int mintues = remainingSeconds ~/ 60;
        int seconds = remainingSeconds % 60;
        time =
            '${mintues.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
        remainingSeconds--;
        context.read<StudyBuddyServices>().incDuration();
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 102,
      height: 50,
      clipBehavior: Clip.none,
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: ShapeDecoration(
        shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 2.5)),
      ),
      child: Row(
        spacing: 5,
        children: [
          Icon(Icons.timer, color: Colors.white, size: 20),
          Text(
            time,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium!.apply(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
