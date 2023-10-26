import 'package:flutter/material.dart';
import 'package:t3_http_req_and_parsing_json/HttpHelper.dart';

class MovieProvider extends ChangeNotifier {
  List<String> types = [
    "3/movie/latest",
    "3/movie/now_playing",
    "3/movie/popular",
    "3/movie/top_rated",
    "3/movie/upcoming",
  ];
  String _querys = "";
  int _option = 0;
  HttpHelper? helper;
  
  
  List? _movies;
  List? _filteredMovies; 

  //getter
  String get querys => _querys;
  int get option => _option;
  List? get movies => _movies;
  List? get filteredMovies => _filteredMovies; 

  //setter
  set setQuerys (value){
    if (value != null){
      _querys = value;
      notifyListeners();
    }
  }
  set setOption (value) {
    if (value != null){
      _option = value;
      notifyListeners();
    }
  }
  set setMovies (value) {
    if (value != null){
      _movies = value;
      notifyListeners();
    }
  }
   set setFilteredMovies (value) {
    if (value != null){
      _filteredMovies = value;
      notifyListeners();
    }
  }

  //search filter function
  void filterMovies (String query) {
    _querys = query;
    _filteredMovies = _movies?.where((item) => item.title.toLowerCase().contains(query)).toList();
    notifyListeners();
  }

  //initialize data
  Future initialize() async {
    helper = HttpHelper();
    _movies = await helper?.getMovies(types[option]);
    _filteredMovies = _movies;
    filterMovies(_querys);
    notifyListeners();
  }

  //running initialize()
  MovieProvider(){
    initialize();
  }

}