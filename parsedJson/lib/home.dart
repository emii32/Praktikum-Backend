import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t3_http_req_and_parsing_json/provider.dart';
import 'detail.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String defaultImage =
      'https://media.istockphoto.com/id/614836096/id/foto/papan-clapper-film-kosong.jpg?s=1024x1024&w=is&k=20&c=s1AHp2FkjAZ7FcnWgLnQvkqRrxnUi-6RrON4AgeAC2Q=';

  TextEditingController controller = TextEditingController();

  List<String> judul = [
    "Latest",
    "Now Playing",
    "Popular",
    "Top Rated",
    "Upcoming"
  ];
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<MovieProvider>(context);
    NetworkImage image;
    return Scaffold(
        appBar: AppBar(
          title: Text(judul[prov.option]),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purple.shade300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            ),
          ),
          actions: [
            PopupMenuButton(itemBuilder: (context) {
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text(judul[0]),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Text(judul[1]),
                ),
                PopupMenuItem<int>(
                  value: 2,
                  child: Text(judul[2]),
                ),
                PopupMenuItem<int>(
                  value: 3,
                  child: Text(judul[3]),
                ),
                PopupMenuItem<int>(
                  value: 4,
                  child: Text(judul[4]),
                ),
              ];
            }, onSelected: (value) {
              prov.setOption = value;
              prov.initialize();
            }),
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: "Search Movies",
                    hintStyle: const TextStyle(),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    prefixIcon: const Icon(Icons.search)
                  ),
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    TextEditingController().clear();
                  },
                  onChanged: (value){
                    prov.filterMovies(value);
                  }
                ),
              ),
              Expanded(
                child: ListView.builder(
              itemCount: (prov.filteredMovies?.length == null) ? 0 : prov.filteredMovies?.length,
              itemBuilder: (BuildContext context, int position) {
                final movies = prov.filteredMovies?[position];
                if (movies.posterPath != null) {
                  image = NetworkImage(iconBase + movies.posterPath);
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
                            builder: (_) => DetailScreen(movies)));
                  },
                  leading: CircleAvatar(
                    backgroundImage: image,
                  ),
                  title: Text(movies.title),
                  subtitle: Text('Released: + ${movies.releaseDate} - Vote: ${movies.voteAverage}'),
                ));
              }) 
                
              ),
              
            ],
          ),
        ) 
        
            );
  }
}
