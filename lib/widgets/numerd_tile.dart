import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';

class NumberedTile extends StatelessWidget {
  const NumberedTile({
    Key? key,
    required this.index,
    required this.posterPath,
  }) : super(key: key);
  final int index;
  final String posterPath;
  @override
  Widget build(BuildContext context) {
    var imageURL = 'https://image.tmdb.org/t/p/w500/$posterPath';
    return SizedBox(
      width: 130,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/transparent.png',
                image: imageURL,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
              bottom: -10,
              left: index != 0 ? -5 : 0,
              child: BorderedText(
                strokeColor: Colors.white,
                strokeWidth: 5,
                child: Text(
                  '${index + 1}',
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                      color: Color(0xFF0A0A0A),
                      fontSize: 80,
                      fontWeight: FontWeight.w700),
                ),
              )),
          if (index != 0)
            Positioned(
                child: Container(
              width: 20,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.black87, Colors.transparent],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight),
              ),
            ))
        ],
      ),
    );
  }
}
