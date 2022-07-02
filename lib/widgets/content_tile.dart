import 'package:flutter/material.dart';

class ContentTile extends StatelessWidget {
  const ContentTile({
    Key? key,
    required this.posterPath,
  }) : super(key: key);
  final String posterPath;
  @override
  Widget build(BuildContext context) {
    var imageURL = 'https://image.tmdb.org/t/p/w500/$posterPath';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: FadeInImage.assetNetwork(
          fadeInDuration: const Duration(milliseconds: 200),
          placeholder: 'assets/images/transparent.png',
          image: imageURL,
          width: 100,
          height: 120,
        ),
      ),
    );
  }
}
