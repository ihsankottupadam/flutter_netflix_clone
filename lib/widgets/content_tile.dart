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
          placeholder: 'assets/images/transparent.png',
          image: imageURL,
          width: 100,
          height: 120,
        ),
      ),
    );
  }
}
/* Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            image: DecorationImage(
                image: NetworkImage(imageURL), fit: BoxFit.cover)),
      ),*/
/* @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        'assets/images/banner_dr_strange.webp',
        width: 100,
        height: 10,
      ),
    );
  }*/