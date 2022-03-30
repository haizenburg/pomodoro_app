import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../widgets/progress_icons.dart';
import '../widgets/custom_button.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

const _btnTextStart = 'start pomodoro';
// const _btnTextStart = 'resume pomodoro';
// const _btnTextStart = 'resume break';
// const _btnTextStart = 'take short break';
// const _btnTextStart = 'take long break';
// const _btnTextStart = 'take long break';

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              'Pomodoro number: 2',
              style: TextStyle(fontSize: 32, color: Colors.white),
            ),
            Text(
              'Set: 3',
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularPercentIndicator(
                  radius: 220.0,
                  lineWidth: 15.0,
                  percent: 0.3,
                  circularStrokeCap: CircularStrokeCap.round,
                  center: Text(
                    '15:22',
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  progressColor: Colors.red,
                ),
                SizedBox(height: 10),
                ProgressIcons(total: 4, done: 1),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'status description',
                  style: TextStyle(color: Colors.white),
                ),
                CustomButton(onTap: () {}, text: 'Start'),
                CustomButton(onTap: () {}, text: 'Reset')
              ],
            )),
          ],
        ),
      )),
    );
  }
}
