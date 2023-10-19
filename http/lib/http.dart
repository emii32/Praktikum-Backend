import 'package:flutter/material.dart';
import 'package:m04/HttpHelper.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  late String result;
  late HttpHelper helper;
  List<String> types = [
    "3/movie/latest",
    "3/movie/now_playing",
    "3/movie/popular",
    "3/movie/top_rated",
    "3/movie/upcoming",
  ];
  List<String> judul = [
    "Latest",
    "Now Playing",
    "Popular",
    "Top Rated",
    "Upcoming"
  ];
  int option = 0;

@override
void initState() {
  super.initState();
  helper = HttpHelper();
  result = "";
}

  @override
  Widget build(BuildContext context) {
    helper.getMovie(types[option]).then((value) {
      setState(() {
        result = value;
      });
    });
    return Scaffold(
      appBar: 
        AppBar(
          title: Text(judul[option]),
          actions: [
            PopupMenuButton(
          itemBuilder: (context){
            return [
                  PopupMenuItem<int>(
                      value: 0,
                      child: Text("Latest"),
                  ),

                  PopupMenuItem<int>(
                      value: 1,
                      child: Text("Now Playing"),
                  ),

                  PopupMenuItem<int>(
                      value: 2,
                      child: Text("Popular"),
                  ),
                  PopupMenuItem<int>(
                      value: 3,
                      child: Text("Top Rated"),
                  ),
                  PopupMenuItem<int>(
                      value: 4,
                      child: Text("Upcoming"),
                  ),
              ];
          },
          onSelected:(value){
            setState(() {
              option = value;
            });
          }
        ),
          ],
        ),
      body: SingleChildScrollView(
        child: Text("$result"),
      ),
    );
  }
}