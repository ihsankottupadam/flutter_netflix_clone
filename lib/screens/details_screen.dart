import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netflix/models/watchlist.dart';

import 'package:netflix/services/youtbe_service.dart';
import 'package:netflix/models/movie.dart';
import 'package:netflix/util.dart';

import 'package:netflix/widgets/widgets.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key, required this.movie}) : super(key: key);
  final Movie movie;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late YoutubePlayerController _controller;
  int stackIndex = 0;
  String videoId = '';
  String sp = 'TYMMOjBUPMM';
  String? posterPath;
  //bool isPlayerReady = false;
  // bool isPlayerMuted = false;
  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        loop: false,
        mute: false,
        enableCaption: false,
      ),
    )..setVolume(100);

    super.initState();
  }

  @override
  void deactivate() {
    print('deactivated ......');
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String backdropPath = widget.movie.backdropPath;
    final String overview = widget.movie.overview;
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          onReady: () {
            // isPlayerReady = true;
            if (videoId.isNotEmpty) {
              _controller.load(videoId);
            }
          },
          thumbnail: Image.network(
            'https://image.tmdb.org/t/p/w500/$backdropPath',
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          progressColors: const ProgressBarColors(
              playedColor: Colors.red,
              handleColor: Colors.red,
              backgroundColor: Color(0x44ffffff)),
          progressIndicatorColor: Colors.red,
          topActions: [
            const Spacer(),
            // IconButton(
            //     onPressed: () {
            //       if (!isPlayerMuted) {
            //         _controller.mute();
            //       } else {
            //         _controller.unMute();
            //       }
            //       setState(() {
            //         isPlayerMuted = !isPlayerMuted;
            //       });
            //     },
            //     icon: Icon(isPlayerMuted ? Icons.volume_off : Icons.volume_up)),
            IconButton(
                onPressed: () {
                  setState(() {
                    _controller.pause();
                    stackIndex = 0;
                  });
                },
                icon: const Icon(Icons.close))
          ],
        ),
        builder: (context, player) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  GestureDetector(
                      onTap: () async {
                        final String title = widget.movie.title;
                        if (title.isEmpty) {
                          Util.showSnackbar(context, 'No video found');
                          return;
                        }
                        if (videoId.isEmpty) {
                          final String? id = await YouTubeService.search(title);
                          if (id != null) {
                            videoId = id;
                          } else {
                            Util.showSnackbar(context, 'Video loading failed');
                            return;
                          }
                        }
                        _controller.load(videoId);
                        setState(() {
                          stackIndex = 1;
                        });
                      },
                      onLongPress: () async {
                        String title = widget.movie.title;
                        if (title.isNotEmpty) {
                          final String? id =
                              await YouTubeService.search(widget.movie.title);
                          if (id != null) {
                            videoId = id;
                            _controller.load(videoId);
                            setState(() {
                              stackIndex = 1;
                            });
                          } else {
                            Util.showSnackbar(context, 'Video Loading Failed');
                          }
                        } else {
                          Util.showSnackbar(context, 'No video found');
                        }
                      },
                      child: IndexedStack(
                        index: stackIndex,
                        children: [MovieThumb(imagePath: backdropPath), player],
                      )),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          VideoActionsBar(movie: widget.movie),
                          const SizedBox(
                            height: 10,
                          ),
                          MovieDetails(
                            movie: widget.movie,
                          ),
                          const SizedBox(height: 30),
                          OverviewWidet(
                            overview: overview,
                          ),
                          const SizedBox(height: 30),
                          ContentList(
                            title: 'Similar Movies',
                            movieId: widget.movie.id,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class VideoActionsBar extends StatefulWidget {
  const VideoActionsBar({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final Movie movie;

  @override
  State<VideoActionsBar> createState() => _VideoActionsBarState();
}

class _VideoActionsBarState extends State<VideoActionsBar> {
  bool isinWathlist = false;
  @override
  void initState() {
    isinWathlist = WatchList.contains(widget.movie);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        VerticalIconButton(
          icon: Icons.copy,
          label: 'Copy Title',
          onTap: () {
            Clipboard.setData(ClipboardData(text: widget.movie.title));
            Util.showSnackbar(context, 'Copied to Clipboard');
          },
          fontSize: 10,
          iconSize: 18,
          padding: const EdgeInsets.all(15),
        ),
        VerticalIconButton(
            icon: isinWathlist ? Icons.bookmark : Icons.bookmark_border,
            label: 'Watchlist',
            fontSize: 10,
            iconSize: 18,
            padding: const EdgeInsets.all(15),
            onTap: () {
              if (isinWathlist) {
                WatchList.remove(widget.movie);
              } else {
                WatchList.add(widget.movie);
              }
              setState(() {
                isinWathlist = !isinWathlist;
              });
            })
      ],
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
