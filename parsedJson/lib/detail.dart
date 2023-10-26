import 'package:flutter/material.dart';
import 'package:t3_http_req_and_parsing_json/movies.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen(this.movie, {Key? key}) : super(key: key);
  final Movie movie;
  final String imgPath = 'https://image.tmdb.org/t/p/w500/';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    String path;
    if (movie.posterPath != "" || movie.posterPath != null) {
      path = imgPath + movie.posterPath!;
    } else {
      path =
          'https://media.istockphoto.com/id/614836096/id/foto/papan-clapper-film-kosong.jpg?s=1024x1024&w=is&k=20&c=s1AHp2FkjAZ7FcnWgLnQvkqRrxnUi-6RrON4AgeAC2Q=';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
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
                  child: Text(movie.overview))
            ],
          ),
        ),
      ),
    );
  }
}
