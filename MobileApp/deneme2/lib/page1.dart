import 'package:flutter/material.dart';

class page1 extends StatelessWidget {
  final List results; // Define the results parameter

  const page1({Key? key, required this.results}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Image Results:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: results.length,
              itemBuilder: (context, index) {
                final result = results[index];
                return ListTile(
                  title: Text(
                    '${result['label']} - ${result['confidence'].toStringAsFixed(2)}',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
