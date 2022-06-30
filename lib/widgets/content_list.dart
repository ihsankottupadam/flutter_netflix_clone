import 'package:flutter/material.dart';
import 'package:netflix/screens/details_screen.dart';
import 'package:netflix/services/movie_service.dart';
import 'package:netflix/widgets/content_tile.dart';

class ContentList extends StatelessWidget {
  const ContentList({
    Key? key,
    this.movieId = -1,
    required this.title,
  }) : super(key: key);
  final String title;
  final int movieId;

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
                future: title != 'Similar Movies'
                    ? MovieService.fetchMovies(type: title)
                    : MovieService.getSimilarMovies(movieId),
                builder: (context, AsyncSnapshot<List> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                        child: Text('Loading Failed',
                            style: TextStyle(color: Colors.red)));
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
                    itemCount: movies.length,
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
                        child: ContentTile(
                          posterPath: movie['poster_path'],
                        ),
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
