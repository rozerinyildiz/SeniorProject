import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ResultPage extends StatelessWidget {
  final List<dynamic> results;
  final String name;
  final String age;
  final String question1;
  final String question2;

  const ResultPage({
    Key? key,
    required this.results,
    required this.name,
    required this.age,
    required this.question1,
    required this.question2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<dynamic, String>> seriesList = _createSeriesList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Name: $name',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Age: $age',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Question 1: $question1',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Question 2: $question2',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Results:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Container(
              height: 300,
              child: charts.BarChart(
                seriesList,
                animate: true,
                vertical: false,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<charts.Series<dynamic, String>> _createSeriesList() {
    final data = results.map((result) {
      return _ResultData(result['label'], result['confidence']);
    }).toList();

    return [
      charts.Series<_ResultData, String>(
        id: 'Results',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (_ResultData data, _) => data.label,
        measureFn: (_ResultData data, _) => data.confidence,
        data: data,
      ),
    ];
  }
}

class _ResultData {
  final String label;
  final double confidence;

  _ResultData(this.label, this.confidence);
}
