import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:deneme2/info.dart';

class TfliteModel extends StatefulWidget {
  const TfliteModel({Key? key}) : super(key: key);

  @override
  _TfliteModelState createState() => _TfliteModelState();
}

class _TfliteModelState extends State<TfliteModel> {
  late File _image;
  late List<dynamic> _results;
  bool imageSelect = false;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async {
    Tflite.close();
    String res = (await Tflite.loadModel(
      model: "assets/ensemble_model2.tflite",
      labels: "assets/labels.txt",
    ))!;
    print("Models loading status: $res");
  }

  Future<void> imageClassification(File image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _results = recognitions!;
      _image = image;
      imageSelect = true;
    });
    navigateToInfoPage();
  }

  void navigateToInfoPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InfoPage(results: _results),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Classification"),
      ),
      body: ListView(
        children: [
          (imageSelect)
              ? Container(
            margin: EdgeInsets.all(10),
            child: Image.file(_image),
          )
              : Container(
            margin: const EdgeInsets.all(10),
            child: const Opacity(
              opacity: 0.8,
              child: Center(
                child: Text("No image selected"),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: (imageSelect)
                  ? _results.map((result) {
                return Card(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "${result['label']} - ${result['confidence'].toStringAsFixed(2)}",
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                      ),
                    ),
                  ),
                );
              }).toList()
                  : [],
            ),
          ),
          ElevatedButton(
            onPressed: pickImage,
            child: const Text('Next'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickImage,
        tooltip: "Pick Image",
        child: const Icon(Icons.image),
      ),
    );
  }

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      File image = File(pickedFile.path);
      await imageClassification(image);
    }
  }
}
