import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie/key.dart';
import 'package:http/http.dart' as http;
import 'package:movie/model.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController textEditingController = TextEditingController();
  bool valuentred = false;

  displaynofilms() {
    // ignore: unused_local_variable
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
        child: Center(
            child: ListView(
      shrinkWrap: true,
      children: <Widget>[
        Icon(Icons.movie, color: Colors.red, size: 200.0),
        Text(
          "Search for a Movie..!",
          style: TextStyle(fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        )
      ],
    )));
  }

  getSearchQuery() async {
    var url =
        'https://api.themoviedb.org/3/search/movie?api_key=$API_KEY&language=en-US&query=${textEditingController.text}&page=1&include_adult=false';
    var response = await http.get(url);
    var result = jsonDecode(response.body);

    List<Movie> playing = List<Movie>();
    for (var cinema in result['results']) {
      Movie movies = Movie(
          cinema['poster_path'],
          cinema['title'],
          cinema['overview'],
          cinema['vote_average'],
          cinema['id'],
          cinema['original_language'],
          cinema['original_title']);
      playing.add(movies);
    }
    return playing;
  }

  displayfilms() {
    return FutureBuilder(
        future: getSearchQuery(),
        builder: (BuildContext context, dataSnapshot) {
          if (!dataSnapshot.hasData) {
            return Center(child: Text("Loading .. Please wait..!"));
          }
          return GridView.builder(
              itemCount: dataSnapshot.data.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    padding: EdgeInsets.all(5.0),
                    height: 200.0,
                    child: Image(
                      image: new NetworkImage(
                          'https://image.tmdb.org/t/p/w500${dataSnapshot.data[index].poster}'),
                      fit: BoxFit.fill,
                    ));
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: textEditingController,
          decoration: InputDecoration(
            hintText: 'Search your movie here',
            filled: true,
            fillColor: Colors.white,
            suffixIcon: RaisedButton(
                onPressed: () {
                  setState(() {
                    valuentred = true;
                  });
                },
                color: Colors.white,
                child: Text("Search", style: TextStyle(color: Colors.black))),
          ),
        ),
      ),
      body: valuentred == false ? displaynofilms() : displayfilms(),
    );
  }
}
