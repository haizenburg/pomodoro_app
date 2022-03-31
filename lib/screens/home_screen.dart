import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pomodoro_app/model/pomodoro_status.dart';
import 'package:pomodoro_app/utils/constants.dart';

import '../widgets/progress_icons.dart';
import '../widgets/custom_button.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

const _btnTextStart = 'start pomodoro';
const _btnTextResume = 'resume pomodoro';
const _btnTextResumeBreak = 'resume break';
const _btnTextStartShortBreak = 'take short break';
const _btnTextStartLongBreak = 'take long break';
const _btnTextStartNewSet = 'start new set';
const _btnTextPause = 'pause';
const _btnTextReset = 'reset';

class _HomeState extends State<Home> {
  int remainingTime = pomodoroTotalTime;
  String mainBtnText = _btnTextStart;
  PomodoroStatus pomodoroStatus = PomodoroStatus.pausedPomodoro;
  Timer _timer = Timer(Duration(milliseconds: 1), () {});
  int pomodoroNum = 0;
  int setNum = 0;

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

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
              'Pomodoro number: $pomodoroNum',
              style: TextStyle(fontSize: 32, color: Colors.white),
            ),
            Text(
              'Set: $setNum',
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularPercentIndicator(
                  radius: 220.0,
                  lineWidth: 15.0,
                  percent: _getPomodoroPercentage(),
                  circularStrokeCap: CircularStrokeCap.round,
                  center: Text(
                    _secondsToFormattedString(remainingTime),
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  progressColor: statusColor[pomodoroStatus],
                ),
                SizedBox(height: 10),
                ProgressIcons(
                    total: pomodoriPerSet,
                    done: pomodoroNum - (setNum * pomodoriPerSet)),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${statusDescription[pomodoroStatus]}',
                  style: TextStyle(color: Colors.white),
                ),
                CustomButton(onTap: _buttonPressed, text: 'Start'),
                CustomButton(onTap: _resetButtonPressed, text: 'Reset')
              ],
            )),
          ],
        ),
      )),
    );
  }

  _secondsToFormattedString(int seconds) {
    int roundedMinutes = seconds ~/ 60;
    int remainingSeconds = seconds - (roundedMinutes * 60);
    String remainingSecondsFormatted;

    if (remainingSeconds < 10) {
      remainingSecondsFormatted = '0$remainingSeconds';
    } else {
      remainingSecondsFormatted = remainingSeconds.toString();
    }

    return '$roundedMinutes:$remainingSecondsFormatted';
  }

  _getPomodoroPercentage() {
    int totalTime;
    switch (pomodoroStatus) {
      case PomodoroStatus.runningPomodoro:
        totalTime = pomodoroTotalTime;
        break;
      case PomodoroStatus.runningShortBreak:
        totalTime = shortBreakTime;
        break;
      case PomodoroStatus.pausedShortBreak:
        totalTime = shortBreakTime;
        break;
      case PomodoroStatus.runnningLongBreak:
        totalTime = longBreakTime;
        break;
      case PomodoroStatus.pausedLongBreak:
        totalTime = longBreakTime;
        break;
      case PomodoroStatus.setFinished:
        totalTime = pomodoroTotalTime;
        break;
      case PomodoroStatus.pausedPomodoro:
        totalTime = pomodoroTotalTime;
        break;
    }

    double percentage = (totalTime - remainingTime) / totalTime;
    return percentage;
  }

  _buttonPressed() {
    switch (pomodoroStatus) {
      case PomodoroStatus.pausedPomodoro:
        _startPomodoroCountdown();
        break;
      case PomodoroStatus.runningPomodoro:
        _pausePomodoroCountdown();
        break;
      case PomodoroStatus.runningShortBreak:
        _pauseShortBreakCountdown();
        break;
      case PomodoroStatus.pausedShortBreak:
        _startShortBreak();
        break;
      case PomodoroStatus.runnningLongBreak:
        _pauseLongBreakCountdown();
        break;
      case PomodoroStatus.pausedLongBreak:
        _startLongBreak();
        break;
      case PomodoroStatus.setFinished:
        setNum++;
        _startPomodoroCountdown();
        break;
    }
  }

  _startPomodoroCountdown() {
    pomodoroStatus = PomodoroStatus.runningPomodoro;
    _cancelTimer();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
          mainBtnText = _btnTextPause;
        });
      } else {
        //to-do playSound();
        _playSound();
        pomodoroNum++;
        _cancelTimer();
        if (pomodoroNum % pomodoriPerSet == 0) {
          pomodoroStatus = PomodoroStatus.pausedLongBreak;
          setState(() {
            remainingTime = longBreakTime;
            mainBtnText = _btnTextStartLongBreak;
          });
        } else {
          pomodoroStatus = PomodoroStatus.pausedShortBreak;

          setState(() {
            remainingTime = longBreakTime;
            mainBtnText = _btnTextStartShortBreak;
          });
        }
      }
    });
  }

  _pausePomodoroCountdown() {
    pomodoroStatus = PomodoroStatus.pausedPomodoro;
    _cancelTimer();
    setState(() {
      mainBtnText = _btnTextResume;
    });
  }

  _resetButtonPressed() {
    pomodoroNum = 0;
    setNum = 0;
    _cancelTimer();
    _stopCountdown();
  }

  _stopCountdown() {
    pomodoroStatus = PomodoroStatus.pausedPomodoro;
    setState(() {
      mainBtnText = _btnTextStart;
      remainingTime = pomodoroTotalTime;
    });
  }

  _cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
  }

  _pauseShortBreakCountdown() {
    pomodoroStatus = PomodoroStatus.pausedShortBreak;
    _pauseBreakCountdown();
  }

  _pauseLongBreakCountdown() {
    pomodoroStatus = PomodoroStatus.pausedLongBreak;
    _pauseBreakCountdown();
  }

  _pauseBreakCountdown() {
    _cancelTimer();
    setState(() {
      mainBtnText = _btnTextResumeBreak;
    });
  }

  _startShortBreak() {
    pomodoroStatus = PomodoroStatus.runningShortBreak;
    setState(() {
      mainBtnText = _btnTextPause;
    });
    _cancelTimer();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        //to-do play sound
        _playSound();
        remainingTime = pomodoroTotalTime;
        _cancelTimer();
        pomodoroStatus = PomodoroStatus.pausedPomodoro;
        setState(() {
          mainBtnText = _btnTextStart;
        });
      }
    });
  }

  _startLongBreak() {
    pomodoroStatus = PomodoroStatus.runnningLongBreak;
    setState(() {
      mainBtnText = _btnTextPause;
    });
    _cancelTimer();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        //to-do play sound
        _playSound();
        remainingTime = pomodoroTotalTime;
        _cancelTimer();
        pomodoroStatus = PomodoroStatus.setFinished;
        setState(() {
          mainBtnText = _btnTextStartNewSet;
        });
      }
    });
  }

  _playSound() {
    print('sound here');
  }
}
