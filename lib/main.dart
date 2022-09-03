import 'dart:math';

import 'package:flutter/material.dart';
import 'package:knob_widget/knob_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Knob Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: MyHomePage(title: 'Flutter Knob Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final double _minimum = 10;
  final double _maximum = 40;

  late KnobController _controller;
  late double _knobValue;

  void valueChangedListener(double value) {
    if (mounted) {
      setState(() {
        _knobValue = value;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _knobValue = _minimum;
    _controller = KnobController(
      initial: 0,
      minimum: 0,
      maximum: 270,
      startAngle: -40,
      endAngle: 230,
    );
    _controller.addOnValueChangedListener(valueChangedListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(_knobValue.toString()),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                var value =
                    Random().nextDouble() * (_maximum - _minimum) + _minimum;
                _controller.setCurrentValue(value);
              },
              child: const Text('Update Knob Value'),
            ),
            const SizedBox(height: 75),
            Container(
              child: Knob(
                controller: _controller,
                width: 200,
                height: 200,
                style: KnobStyle(
                  majorTickStyle: MajorTickStyle(length: 2, thickness: 5),
                  minorTickStyle: MinorTickStyle(length: 2, thickness: 5),
                  tickOffset: 15,
                  showLabels: false,
                  labelStyle: TextStyle(color: Colors.transparent),
                  labelOffset: 10,
                  minorTicksPerInterval: 50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeOnValueChangedListener(valueChangedListener);
    super.dispose();
  }
}
