import 'package:flutter/material.dart';

import '../model/pomodoro_status.dart';

const pomodoroTotalTime = 25 * 60;

const shortBreakTime = 5 * 60;

const longBreakTime = 15 * 60;

const pomodoriPerSet = 4;

const Map<PomodoroStatus, String> statusDescription = {
  PomodoroStatus.runningPomodoro: 'Pomodoro is running, Focus',
  PomodoroStatus.pausedPomodoro: 'Ready to Get back to it?',
  PomodoroStatus.runningShortBreak: 'A quick short break in session, chill out',
  PomodoroStatus.pausedShortBreak: 'take a quick break',
  PomodoroStatus.runnningLongBreak: 'on a loopng break',
  PomodoroStatus.pausedLongBreak: 'Take a long break',
  PomodoroStatus.setFinished: 'Awesome, keep it up!!',
};

const Map<PomodoroStatus, MaterialColor> statusColor = {
  PomodoroStatus.runningPomodoro: Colors.green,
  PomodoroStatus.pausedPomodoro: Colors.orange,
  PomodoroStatus.runningShortBreak: Colors.red,
  PomodoroStatus.pausedShortBreak: Colors.orange,
  PomodoroStatus.runnningLongBreak: Colors.red,
  PomodoroStatus.pausedLongBreak: Colors.orange,
  PomodoroStatus.setFinished: Colors.green,
};




// 0725785394