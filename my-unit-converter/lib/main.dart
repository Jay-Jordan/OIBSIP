import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      title: 'Unit Converter',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Unit Converter',
          ),
        ),
        body: const HomeScreen(),
      ));
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextStyle labelStyle = const TextStyle(
    fontSize: 18,
  );

  final TextStyle resultStyle = const TextStyle(
    color: Colors.teal,
    fontSize: 28,
    fontWeight: FontWeight.w900,
  );

  final List<String> _measures = [
    'Meters',
    'Kilometers',
    'Grams',
    'Kilogram',
    'Feet',
    'Miles',
    'Pounds',
    'Ounces',
  ];
//remove late if it does not work
  late double _value;
  String _fromMeasures = 'Meters';
  String _toMeasures = 'Kilometers';
  String _results = "";

  final Map<String, int> _measuresMap = {
    'Meters': 0,
    'Kilometers': 1,
    'Grams': 2,
    'Kilograms': 3,
    'Feet': 4,
    'Miles': 5,
    'Pounds': 6,
    'Ounces': 7,
  };

  final dynamic _formulas = {
    '0': [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    '1': [100, 1, 0,0, 3280.84, 0.621371,0,0],
    '2': [0, 0, 1, 0.0001, 0, 0, 0.00220462, 0.035274],
    '3': [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    '4': [0.3048, 0.0003048, 0, 0, 1, 0.00189394, 0, 0],
    '5': [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    '6': [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    '7': [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1],
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Input Value',
              ),
              onChanged: (value) {
                setState(() {
                  _value = double.parse(value);
                });
              },
            ),
            const SizedBox(height:28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'From',
                      style: labelStyle,
                    ),
                    DropdownButton(
                      items: _measures
                            .map((String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _fromMeasures = value!;
                        });
                    },
                      value: _fromMeasures,
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('To', style: labelStyle,),
                    DropdownButton(
                      items: _measures
                            .map((String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _toMeasures = value!;
                        });
                      },
                      value: _toMeasures,
                    )
                  ],
                ),
              ],
            ),
            MaterialButton(
                minWidth: double.infinity,
                onPressed: _convert,
              color: Theme.of(context).primaryColor,
              child: const Text(
                'Convert',
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 28,),
            Text(
              _results,
              style: resultStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
  void _convert(){

    if (_value != 0 && _fromMeasures.isNotEmpty && _toMeasures.isNotEmpty) {
      int? from = _measuresMap[_fromMeasures];
      int? to = _measuresMap[_toMeasures];

      var multiplier = _formulas[from.toString()][to];
      setState(() {
        _results =
            "$_value $_fromMeasures = ${_value * multiplier} $_toMeasures";
      });
    } else {
      setState(() {
        _results = "Please enter a non zero value";
      });
    }
  }
}
