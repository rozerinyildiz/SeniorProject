import 'package:flutter/material.dart';
import 'package:deneme2/control.dart';

class InfoPage extends StatefulWidget {
  final List<dynamic> results;

  const InfoPage({Key? key, required this.results}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  String name = '';
  String age = '';
  String observationPeriod = '';
  String familyHistory = '';
  String previousInfection = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Information'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter Your Name:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Enter Your Age:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  age = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'How long have you been experiencing the symptoms?',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              onChanged: (value) {
                setState(() {
                  observationPeriod = value!;
                });
              },
              items: [
                DropdownMenuItem(value: '1-3 days', child: Text('1-3 days')),
                DropdownMenuItem(value: '1 week', child: Text('1 week')),
                DropdownMenuItem(value: '2-3 weeks', child: Text('2-3 weeks')),
                DropdownMenuItem(value: '1 month', child: Text('1 month')),
                DropdownMenuItem(value: 'more', child: Text('more')),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Has anyone in your family experienced this illness?',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              onChanged: (value) {
                setState(() {
                  familyHistory = value!;
                });
              },
              items: [
                DropdownMenuItem(value: 'yes', child: Text('Yes')),
                DropdownMenuItem(value: 'no', child: Text('No')),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Have you had this illness before?',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              onChanged: (value) {
                setState(() {
                  previousInfection = value!;
                });
              },
              items: [
                DropdownMenuItem(value: 'yes', child: Text('Yes')),
                DropdownMenuItem(value: 'no', child: Text('No')),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                navigateToControlPage();
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToControlPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ControlPage(
          results: widget.results,
          name: name,
          age: age,
          observationPeriod: observationPeriod,
          familyHistory: familyHistory,
          previousInfection: previousInfection,
        ),
      ),
    );
  }
}
