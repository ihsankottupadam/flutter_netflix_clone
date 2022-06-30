import 'dart:math';
import 'package:flutter/material.dart';
import 'package:netflix/widgets/numerd_tile.dart';

import '../screens/details_screen.dart';
import '../services/movie_service.dart';

class NumberdList extends StatelessWidget {
  const NumberdList({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 160,
            child: FutureBuilder(
                future: MovieService.fetchMovies(type: title),
                builder: (context, AsyncSnapshot<List> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                        child: Text(
                      'Loading Failed',
                      style: TextStyle(color: Colors.red),
                    ));
                  }
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List movies = snapshot.data!;
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.hasData ? min(movies.length, 10) : 0,
                    itemBuilder: (context, index) {
                      Map movie = movies[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailsScreen(movie: movie),
                              ));
                        },
                        child: NumberedTile(
                            index: index, posterPath: movie['poster_path']),
                      );
                    },
                  );
                }),
          )
        ],
      ),
    );
  }
}
