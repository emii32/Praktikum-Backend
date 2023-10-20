import 'package:flutter/material.dart';
import 'package:m05/movies.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen(this.result, {Key? key}) : super(key: key);
  final Movie result;
  final String imgPath = 'https://image.tmdb.org/t/p/w500/';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    String path;
    if (result.posterPath != "") {
      path = imgPath + result.posterPath;
    } else {
      path =
          'https://images.freeimages.com/images/largepreviews/5eb/movie-clapboard-1184339.jpg';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(result.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.all(16),
                  height: height / 1.5,
                  child: Image.network(path)),
              Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Text(result.overview))
            ],
          ),
        ),
      ),
    );
  }
}
