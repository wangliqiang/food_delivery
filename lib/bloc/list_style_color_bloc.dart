import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ColorBloc extends BlocBase {
  ColorBloc();

  var colorController = BehaviorSubject<Color>.seeded(Colors.white);

  Stream<Color> get colorStream => colorController.stream;

  Sink<Color> get colorSink => colorController.sink;

  setColor(Color color) {
    colorSink.add(color);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    colorController.close();
    super.dispose();
  }
}
