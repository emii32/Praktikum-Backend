import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:t3_http_req_and_parsing_json/movies.dart';

class HttpHelper {
  final String _urlKey = "?api_key=5a36356d15d51cb36091bf0cf5c55c3d";
  final String _urlBase = "https://api.themoviedb.org/";

  Future<List?> getMovies(String type) async {
    var url = Uri.parse(_urlBase + type + _urlKey);
    http.Response result = await http.get(url);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      //The "latest" genre has different data type with the other genre
      //So we have to handle it a little bit different
      if (type == "3/movie/latest"){
        List<Movie> latestMovie = [];
        latestMovie.add(Movie.fromJson(jsonResponse));
        return latestMovie;
      }else{
        final moviesMap = jsonResponse['results'];
        List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
        return movies;
      }
    } else {
      return null;
    }
  }
}
