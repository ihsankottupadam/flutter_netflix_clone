import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix/screens/screens.dart';
import 'package:netflix/services/movie_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: CupertinoSearchTextField(
            onChanged: (value) {
              setState(() {
                query = value;
              });
            },
            style: const TextStyle(color: Colors.white)),
      ),
      body: SizedBox(
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                query.isEmpty ? 'Top Searches' : 'Top Results',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: query.isEmpty
                      ? MovieService.fetchMovies(type: 'Trending Now')
                      : MovieService.searchMovies(query),
                  builder: (context, AsyncSnapshot<List> snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                          child: Text(
                        'Loading Failed ,Check your internet connection!',
                        style: TextStyle(color: Colors.red),
                      ));
                    }
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    List movies = snapshot.data!;
                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 8),
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
                          child: SearchTile(movieDetails: movie),
                        );
                      },
                      separatorBuilder: (contxt, index) => const Divider(
                        height: 1,
                        thickness: 1,
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchTile extends StatelessWidget {
  const SearchTile({
    Key? key,
    required this.movieDetails,
  }) : super(key: key);
  final Map movieDetails;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      color: Colors.grey.shade800,
      child: Row(
        children: [
          Image.network(
            'https://image.tmdb.org/t/p/w500/${movieDetails['backdrop_path']}',
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
            movieDetails['title'] ?? '',
            maxLines: 1,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                overflow: TextOverflow.ellipsis),
          )),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              'assets/images/play_arrow_bordered.png',
              width: 30,
            ),
          )
        ],
      ),
    );
  }
}
