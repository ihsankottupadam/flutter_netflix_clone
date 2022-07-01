import 'package:flutter/material.dart';
import 'package:netflix/screens/yt_player.dart';
import 'package:netflix/services/youtbe_service.dart';
import 'package:netflix/models/movie.dart';

import 'package:netflix/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key, required this.movie}) : super(key: key);
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    final String backdropPath = movie.backdropPath;

    final String overview = movie.overview;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            GestureDetector(
                onTap: () async {
                  String title = movie.title;
                  if (title.isEmpty) {
                    String? id = await YouTubeService.search(movie.title);
                    if (id != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => YtPlayer(
                              videoId: id,
                            ),
                          ));
                    }
                  }
                },
                child: MovieThumb(imagePath: backdropPath)),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MovieDetails(
                    movie: movie,
                  ),
                  const SizedBox(height: 30),
                  OverviewWidet(
                    overview: overview,
                  ),
                  const SizedBox(height: 30),
                  ContentList(
                    title: 'Similar Movies',
                    movieId: movie.id,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OverviewWidet extends StatelessWidget {
  const OverviewWidet({
    Key? key,
    required this.overview,
  }) : super(key: key);
  final String overview;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Overview',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          overview,
          style: const TextStyle(fontSize: 15, color: Colors.white70),
        )
      ],
    );
  }
}

class MovieDetails extends StatelessWidget {
  const MovieDetails({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final String posterPath = movie.posterPath;
    num rating = movie.voteAverage;
    String? releaseDate = movie.releaseDate;
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContentTile(posterPath: posterPath),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Expanded(
                  child: Text(
                    movie.title,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ]),
              const SizedBox(height: 8),
              if (rating > 0)
                RatingIndigator(
                  rating: rating / 2,
                ),
              const SizedBox(height: 5),
              if (releaseDate != null)
                Text('Release Date : ${releaseDate.replaceAll('-', '/')}',
                    style: const TextStyle(color: Colors.white, fontSize: 15))
            ],
          ),
        ),
      ],
    );
  }
}
