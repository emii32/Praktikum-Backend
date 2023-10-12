import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyBio(),
    );
  }
}

class MyBio extends StatefulWidget {
  const MyBio({super.key});

  @override
  State<MyBio> createState() => _MyBioState();
}

class _MyBioState extends State<MyBio> {
  TextEditingController dateInput = TextEditingController();
  String? _image;
  double _score = 0;
  final String _keyScore = "score";
  final String _keyImage = "image";
  final String _keyDate = "date";
  final ImagePicker _picker = ImagePicker();
  late SharedPreferences prefs;


  void loadData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _score = (prefs.getDouble(_keyScore) ?? 0);
      _image = prefs.getString(_keyImage);
      dateInput.text = prefs.getString(_keyDate) ?? "";
    });
  }

  Future<void> _setScore(double value) async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setDouble(_keyScore, value);
      _score = ((prefs.getDouble(_keyScore) ?? 0));
    });
  }

  Future<void> _setImage(String? value) async {
    prefs = await SharedPreferences.getInstance();
    if (value != null){
      setState(() {
        prefs.setString(_keyImage, value);
        _image = prefs.getString(_keyImage);
      });
    }
  }

  Future<void> _setDate(String? value) async {
    prefs = await SharedPreferences.getInstance();
    if (value != null){
      setState(() {
        prefs.setString(_keyDate, value);
        dateInput.text = prefs.getString(_keyDate) ?? "";
      });
    }
  }

  @override
  void initState(){
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bio'),
      ),
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(color: Colors.red[200]),
                child: _image != null
                ? Image.file(
                  File(_image!),
                  width: 200,
                  height: 200,
                  fit: BoxFit.fitHeight,
                )
                :
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 198, 198, 198)
                  ),
                  width: 200,
                  height: 200,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: () async {
                    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                    _setImage(image?.path);
                  },
                  child: Text("Take Image"),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: SpinBox(
                  max: 10,
                  min: 0,
                  value: _score,
                  step: 0.1,
                  decimals: 1,
                  decoration: InputDecoration(labelText: "Decimals"),
                  onChanged: _setScore,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: TextField(
                  onTap: () async {
                    DateTime? _pickedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime(2040));
                    if (_pickedDate != null){
                      String formattedDate = DateFormat('yyyy/MMM/dd').format(_pickedDate);
                      setState(() {
                        dateInput.text = formattedDate;
                      });
                    _setDate(formattedDate);
                    };
                  },
                  controller: dateInput,
                  readOnly: true,
                  decoration: InputDecoration(labelText: "Input Date"),
                )
              ),
            ],
          ),
        ),
      ),
      ),
      
     
    );
  }
  
}



