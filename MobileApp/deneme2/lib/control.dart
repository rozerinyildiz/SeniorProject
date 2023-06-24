import 'package:flutter/material.dart';
import 'package:deneme2/result.dart';

class ControlPage extends StatefulWidget {
  final List<dynamic> results;
  final String name;
  final String age;
  final String observationPeriod;
  final String familyHistory;
  final String previousInfection;

  const ControlPage({
    Key? key,
    required this.results,
    required this.name,
    required this.age,
    required this.observationPeriod,
    required this.familyHistory,
    required this.previousInfection,
  }) : super(key: key);

  @override
  _ControlPageState createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  String? question1;
  String? question2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control Questions'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Question 1: Do you have itching?',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: question1,
              onChanged: (value) {
                setState(() {
                  question1 = value!;
                });
              },
              items: [
                DropdownMenuItem(value: 'Yes', child: Text('Yes')),
                DropdownMenuItem(value: 'No', child: Text('No')),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Question 2: Is there any spreading?',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: question2,
              onChanged: (value) {
                setState(() {
                  question2 = value!;
                });
              },
              items: [
                DropdownMenuItem(value: 'Yes', child: Text('Yes')),
                DropdownMenuItem(value: 'No', child: Text('No')),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                navigateToResultPage();
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToResultPage() {
    if (question1 != null && question2 != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(
            results: widget.results,
            name: widget.name,
            age: widget.age,
            question1: question1!,
            question2: question2!,
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Missing Answers'),
          content: Text('Please answer all the questions.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
