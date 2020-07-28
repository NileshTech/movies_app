import 'package:flutter/material.dart';

class MoviePage extends StatefulWidget {
  final String poster;
  final String overview;
  final String title;
  final double rating;

  MoviePage(this.poster, this.overview, this.title, this.rating);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              height: 260.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.0),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        'https://image.tmdb.org/t/p/w500${widget.poster}'),
                  ))),
          SizedBox(
            height: 20.0,
          ),
          Padding(
              padding: EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text('${widget.title}',
                  style: TextStyle(
                      color: Color(0xff07128a),
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold))),
          SizedBox(
            height: 20.0,
          ),
          Padding(
              padding: EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                'rating : ${widget.rating.toString()}',
                style: TextStyle(
                    color: Color(0xffff6f00),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              )),
          SizedBox(
            height: 20.0,
          ),
          Padding(
              padding: EdgeInsets.only(left: 8.0, right: 8.0),
              child: Expanded(
                child: Text('${widget.overview}',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              )),
        ],
      ),
    );
  }
}
