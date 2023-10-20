import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:m05/movies.dart';

class HttpHelper {
  final String _urlKey = "?api_key=5a36356d15d51cb36091bf0cf5c55c3d";
  final String _urlBase = "https://api.themoviedb.org/";

  Future<List?> getMovies(String type) async {
    var url = Uri.parse(_urlBase + type + _urlKey);
    http.Response result = await http.get(url);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    } else {
      return null;
    }
  }
}
