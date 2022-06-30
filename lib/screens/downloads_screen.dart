import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix/services/movie_service.dart';
import 'search_screen.dart';

class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Downloads'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchScreen(),
                  ));
            },
            icon: const Icon(CupertinoIcons.search),
            tooltip: 'Search',
          ),
          IconButton(
            onPressed: () {},
            icon: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 221, 204, 51),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                )),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        children: [
          Row(
            children: const [
              Icon(
                CupertinoIcons.settings_solid,
                size: 15,
              ),
              SizedBox(width: 8),
              Text(
                'Smart Downloads',
                style: TextStyle(
                    color: Colors.white70, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 50),
          const Text(
            'Introducing Downloads for You',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Text(
              "We'll download a personalised selection of movies and shows for you, so there's always something to watch on your phone.",
              style: TextStyle(fontSize: 13, color: Colors.white70)),
          const DownloadsImageCards(),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(primary: const Color(0xff0071eb)),
            child: const Text('Set Up'),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                style:
                    ElevatedButton.styleFrom(primary: const Color(0xff252525)),
                child: const Text(
                  'Find More to Download',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class DownloadsImageCards extends StatelessWidget {
  const DownloadsImageCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 220,
        child: Stack(
          children: [
            Center(
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                    color: Colors.grey.shade800, shape: BoxShape.circle),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: FutureBuilder(
                future: MovieService.fetchMovies(type: 'Now Playing'),
                builder: (context, AsyncSnapshot<List> snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox();
                  } else if (snapshot.data!.isEmpty) {
                    return const SizedBox();
                  }
                  final List movies = snapshot.data!;
                  return SizedBox(
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        MoviePoster(
                            margin: const EdgeInsets.only(right: 160),
                            angle: -20,
                            posterpath: movies[1]['poster_path']),
                        MoviePoster(
                            margin: const EdgeInsets.only(left: 160),
                            angle: 20,
                            posterpath: movies[2]['poster_path']),
                        MoviePoster(
                            margin: EdgeInsets.zero,
                            angle: 0,
                            posterpath: movies[0]['poster_path'],
                            height: 160),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }
}

class MoviePoster extends StatelessWidget {
  const MoviePoster({
    Key? key,
    required this.posterpath,
    this.height = 140,
    required this.angle,
    required this.margin,
  }) : super(key: key);

  final String posterpath;
  final double height;
  final double angle;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle * pi / 180,
      child: Container(
        margin: margin,
        width: 120,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage('https://image.tmdb.org/t/p/w500/$posterpath'),
          ),
        ),
      ),
    );
  }
}
