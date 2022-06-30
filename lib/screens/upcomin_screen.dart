import 'package:flutter/material.dart';
import 'package:netflix/screens/details_screen.dart';

import 'package:netflix/services/movie_service.dart';

import 'package:netflix/widgets/widgets.dart';

class UpcomingMoviesScreen extends StatelessWidget {
  const UpcomingMoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: MovieService.fetchMovies(type: 'Upcoming Movies'),
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
            itemCount: movies.length,
            itemBuilder: (context, index) {
              Map movie = movies[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(movie: movie),
                      ));
                },
                child: UpcomingTile(
                  movieDetails: movie,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class UpcomingTile extends StatelessWidget {
  const UpcomingTile({Key? key, required this.movieDetails}) : super(key: key);
  final Map movieDetails;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MovieThumb(
            imagePath: movieDetails['backdrop_path'], showGradient: false),
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(children: [
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
            VerticalIconButton(
                icon: Icons.notifications_outlined,
                label: 'Remind Me',
                onTap: () {}),
            const SizedBox(width: 12),
            VerticalIconButton(
                icon: Icons.info_outline, label: 'Info', onTap: () {})
          ]),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            movieDetails['overview'] ?? '',
            maxLines: 4,
            style: const TextStyle(
                fontSize: 15,
                color: Colors.white70,
                overflow: TextOverflow.ellipsis),
          ),
        ),
        const SizedBox(height: 30)
      ],
    );
  }
}
