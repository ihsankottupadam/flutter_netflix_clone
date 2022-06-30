import 'package:flutter/material.dart';
import 'package:netflix/services/movie_service.dart';
import 'package:netflix/widgets/vertical_icon_button.dart';

class HeaderView extends StatelessWidget {
  const HeaderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder(
            future: MovieService.fetchMovies(type: 'Trending Now'),
            builder: (context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Loading Failed'));
              }
              if (!snapshot.hasData) {
                return const SizedBox(
                  height: 500,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              final List movies = snapshot.data!;
              if (movies.isNotEmpty) {
                final Map movie = movies[0];
                final String posterPath = movie['poster_path'];
                var imageURL = 'https://image.tmdb.org/t/p/w500/$posterPath';
                return Container(
                  height: 500,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(imageURL), fit: BoxFit.cover)),
                );
              }
              return const SizedBox(height: 500);
            }),
        Container(
          height: 500,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.transparent,
                    Colors.black45,
                    Colors.black
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0, 0.25, 0.95, 1])),
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                VerticalIconButton(
                  icon: Icons.add,
                  label: 'My List',
                  onTap: () {},
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Play',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                  ),
                ),
                VerticalIconButton(
                  icon: Icons.info_outline,
                  label: 'info',
                  onTap: () {},
                )
              ],
            ))
      ],
    );
  }
}
