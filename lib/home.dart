import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie/details.dart';
import 'package:movie/key.dart';
import 'package:http/http.dart' as http;
import 'package:movie/model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  getmovies() async {
    var url =
        'https://api.themoviedb.org/3/movie/now_playing?api_key=$API_KEY&language=en-US&page=1';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20.0, top: 30.0),
              child: Text(
                "Now Playing Movies",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                ),
              ),
            ),
            Container(
              child: FutureBuilder(
                future: getmovies(),
                builder: (BuildContext context, AsyncSnapshot dataSnapshot) {
                  if (dataSnapshot.data != null) {
                    return InkWell(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        color: Color(0xfffF7F7F7),
                        child: ListView.builder(
                          itemCount: dataSnapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Stack(children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MoviePage(
                                                dataSnapshot.data[index].poster,
                                                dataSnapshot
                                                    .data[index].overview,
                                                dataSnapshot.data[index].title,
                                                dataSnapshot
                                                    .data[index].rating)));
                                  },
                                  child: Container(
                                      width: 250.0,
                                      height: 250.0,
                                      decoration: new BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                        image: DecorationImage(
                                          image: new NetworkImage(
                                              'https://image.tmdb.org/t/p/w500${dataSnapshot.data[index].poster}'),
                                          fit: BoxFit.fill,
                                        ),
                                      )),
                                ),
                                Positioned(
                                  left: 140.0,
                                  top: 70.0,
                                  child: Material(
                                      color: Colors.white,
                                      elevation: 14.0,
                                      borderRadius: BorderRadius.circular(24.0),
                                      shadowColor: Color(0x802196F3),
                                      child: Container(
                                        width: 230.0,
                                        child: Column(
                                          children: <Widget>[
                                            SizedBox(height: 10.0),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, right: 8.0),
                                              child: Container(
                                                child: Center(
                                                    child: Text(
                                                        '${dataSnapshot.data[index].title}',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff07128a),
                                                            fontSize: 22.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                              ),
                                            ),
                                            SizedBox(height: 10.0),
                                            Container(
                                              child: Center(
                                                  child: Text(
                                                      dataSnapshot
                                                          .data[index].original,
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff2da9ef),
                                                          fontSize: 16.0,
                                                          fontWeight: FontWeight
                                                              .bold))),
                                            ),
                                            SizedBox(height: 10.0),
                                            Container(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Text(
                                                    dataSnapshot
                                                            .data[index].rating
                                                            .toString() +
                                                        " rating",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xffff6f00),
                                                        fontSize: 16.0)),
                                              ],
                                            )),
                                          ],
                                        ),
                                      )),
                                ),
                              ]),
                            );
                          },
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      child: Center(
                        child: Text("Loading"),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
