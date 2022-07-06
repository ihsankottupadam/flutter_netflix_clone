import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:netflix/models/watchlist.dart';

import '../models/movie.dart';
import 'details_screen.dart';

class WatchListScreen extends StatelessWidget {
  const WatchListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: const Text('WatchList'),
      ),
      body: ValueListenableBuilder(
          valueListenable: WatchList.watchlistBox.listenable(),
          builder: (context, Box<Movie> box, _) {
            List<Movie> watchlist = box.values.toList();
            return ListView.builder(
              itemCount: watchlist.length,
              itemBuilder: (context, index) {
                Movie movie = watchlist[index];
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(movie: movie),
                          ));
                    },
                    child: WatchlistTile(movie: movie));
              },
            );
          }),
    );
  }
}

class WatchlistTile extends StatelessWidget {
  const WatchlistTile({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      color: Colors.grey.shade800,
      child: Material(
        color: Colors.transparent,
        child: Row(
          children: [
            Image.network(
              'https://image.tmdb.org/t/p/w500/${movie.backdropPath}',
              fit: BoxFit.cover,
              width: 130,
              height: 80,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 130,
                  height: 80,
                  color: Colors.black,
                );
              },
            ),
            const SizedBox(width: 20),
            Expanded(
                child: Text(
              movie.title,
              maxLines: 1,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  overflow: TextOverflow.ellipsis),
            )),
            Padding(
                padding: const EdgeInsets.all(10),
                child: IconButton(
                    onPressed: () {
                      WatchList.remove(movie);
                    },
                    icon: const Icon(Icons.close)))
          ],
        ),
      ),
    );
  }
}
