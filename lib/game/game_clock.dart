import 'dart:async';

import 'package:bloc/bloc.dart';

// all times are in milliseconds
class GameClock extends Cubit<ClockState> {
  static const TICKER_INTERVAL = 100;
  final int startTime;
  int adjustment = 0;
  GameClock(this.startTime) : super(ClockState(time: startTime, active: false));

  StreamSubscription<int>? tickerSub;

  // combined start and resume
  void start() {
    if (tickerSub == null)
      tickerSub = tick(startTime).listen(onTick);
    else
      tickerSub!.resume();
    emit(ClockState(time: state.time, active: true));
  }

  void pause() {
    tickerSub?.pause();
    emit(ClockState(time: state.time, active: false));
  }

  void stop() {
    tickerSub?.cancel();
    emit(ClockState(time: state.time, active: false));
  }

  void onTick(int time) {
    int _time = time + adjustment;
    if (_time <= 0) {
      _time = 0;
      emit(ClockState(time: _time, active: false));
    } else
      emit(ClockState(time: _time, active: state.active));
  }

  void adjust(int amount) {
    adjustment += amount;
    emit(ClockState(time: state.time + amount, active: state.active));
  }

  Stream<int> tick(int ticks) {
    return Stream.periodic(Duration(milliseconds: TICKER_INTERVAL), (x) => ticks - (x - 1) * TICKER_INTERVAL)
        .take(ticks);
  }
}

class ClockState {
  final int time;
  final bool active;

  ClockState({required this.time, required this.active});

  factory ClockState.fromJson(Map<String, dynamic> doc) {
    return ClockState(time: doc['time'], active: doc['active']);
  }

  Map<String, dynamic> toMap() {
    return {
      'time': time,
      'active': active,
    };
  }

  ClockState copyWith({
    int? time,
    bool? active,
  }) {
    return ClockState(
      time: time ?? this.time,
      active: active ?? this.active,
    );
  }
}
