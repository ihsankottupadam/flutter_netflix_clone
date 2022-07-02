import 'package:flutter/material.dart';

class MovieThumb extends StatelessWidget {
  const MovieThumb({
    Key? key,
    this.showGradient = true,
    required this.imagePath,
  }) : super(key: key);

  final String imagePath;
  final bool showGradient;

  @override
  Widget build(BuildContext context) {
    final String imageURL = 'https://image.tmdb.org/t/p/w500/$imagePath';
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          FadeInImage(
            fadeInDuration: const Duration(milliseconds: 200),
            placeholder: const AssetImage('assets/images/transparent.png'),
            image: NetworkImage(imageURL),
            imageErrorBuilder: (context, _, stacktace) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.grey.shade900,
              );
            },
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          if (showGradient)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 20,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.black, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter)),
              ),
            ),
          SizedBox(
            height: double.infinity,
            child: Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/play_arrow_bordered.png',
                width: 60,
              ),
            ),
          )
        ],
      ),
    );
  }
}
