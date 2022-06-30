import 'package:flutter/material.dart';

import 'package:netflix/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key, required this.movie}) : super(key: key);
  final Map movie;
  @override
  Widget build(BuildContext context) {
    final String backdropPath = movie['backdrop_path'] ?? '';

    final String? overview = movie['overview'];
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            MovieThumb(imagePath: backdropPath),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MovieDetails(
                    movieDetails: movie,
                  ),
                  const SizedBox(height: 30),
                  if (overview != null)
                    OverviewWidet(
                      overview: overview,
                    ),
                  const SizedBox(height: 30),
                  ContentList(
                    title: 'Similar Movies',
                    movieId: movie['id'],
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
    required this.movieDetails,
  }) : super(key: key);
  final Map movieDetails;

  @override
  Widget build(BuildContext context) {
    final String posterPath = movieDetails['poster_path'];
    num rating = movieDetails['vote_average'];
    String? releaseDate = movieDetails['release_date'];
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
                    movieDetails['title'] ?? '',
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
                Text('Release Date : $releaseDate',
                    style: const TextStyle(color: Colors.white, fontSize: 15))
            ],
          ),
        ),
      ],
    );
  }
}
