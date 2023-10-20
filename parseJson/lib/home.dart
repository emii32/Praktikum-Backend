import 'package:flutter/material.dart';
import 'HttpHelper.dart';
import 'detail.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  List? movies;
  HttpHelper? helper;
  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String defaultImage =
      'https://images.freeimages.com/images/large-previews/eb/movieclapboard-1184339.jpg';

  int option = 0;

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

  Future initialize() async {
    movies = await helper?.getMovies(types[option]);
    setState(() {
      movies = movies;
    });
  }

  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    helper?.getMovies(types[option]).then((value) {
      setState(() {
        movies = value;
      });
    });
    NetworkImage image;
    return Scaffold(
        appBar: AppBar(
          title: Text(judul[option]),
          actions: [
            PopupMenuButton(itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text("Latest"),
                ),
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text("Now Playing"),
                ),
                const PopupMenuItem<int>(
                  value: 2,
                  child: Text("Popular"),
                ),
                const PopupMenuItem<int>(
                  value: 3,
                  child: Text("Top Rated"),
                ),
                const PopupMenuItem<int>(
                  value: 4,
                  child: Text("Upcoming"),
                ),
              ];
            }, onSelected: (value) {
              setState(() {
                option = value;
              });
            }),
          ],
        ),
        body: ListView.builder(
            itemCount: (movies?.length == null) ? 0 : movies?.length,
            itemBuilder: (BuildContext context, int position) {
              if (movies![position].posterPath != null) {
                image = NetworkImage(iconBase + movies![position].posterPath);
              } else {
                image = NetworkImage(defaultImage);
              }
              return Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => DetailScreen(movies![position])));
                    },
                    leading: CircleAvatar(
                      backgroundImage: image,
                    ),
                    title: Text(movies![position].title),
                    subtitle: Text('Released: ' +
                        movies![position].releaseDate +
                        ' - Vote: ' +
                        movies![position].voteAverage.toString()),
                  ));
            }));
  }
}
