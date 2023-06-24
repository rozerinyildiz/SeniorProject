import 'package:flutter/material.dart';
import 'package:deneme2/TfliteModel.dart';
import 'package:deneme2/info.dart';
import 'package:deneme2/control.dart';
import 'package:deneme2/result.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(),
      routes: {
        '/info': (context) => InfoPage(results: [],),
        '/control': (context) => ControlPage(results: [], name: '', age: '', observationPeriod: '', familyHistory: '', previousInfection: '',  ),
        '/result': (context) => ResultPage(results: [], name: '', age: '', question1: '', question2: '' ,),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;
  final List<String> _stepNames = ['Photo', 'Patient Info', 'Health Checkup', 'Results'];
  final List<IconData> _stepIcons = [Icons.camera_alt, Icons.person, Icons.favorite, Icons.assignment];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.red,
              child: Row(
                children: _stepNames.map((stepName) {
                  int index = _stepNames.indexOf(stepName);
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentPageIndex = index;
                          if (_currentPageIndex == 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => TfliteModel()),
                            );
                          } else if (_currentPageIndex == 1) {
                            Navigator.pushNamed(context, '/info');
                          } else if (_currentPageIndex == 2) {
                            Navigator.pushNamed(context, '/control');
                          } else if (_currentPageIndex == 3) {
                            Navigator.pushNamed(context, '/result');
                          }
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _stepIcons[index],
                            color: _currentPageIndex == index ? Colors.white : Colors.grey,
                            size: 40,
                          ),
                          SizedBox(height: 8),
                          Text(
                            stepName,
                            style: TextStyle(
                              color: _currentPageIndex == index ? Colors.white : Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.white,
              child: Center(
                child: Icon(
                  _stepIcons[_currentPageIndex],
                  color: Colors.red,
                  size: 100,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
