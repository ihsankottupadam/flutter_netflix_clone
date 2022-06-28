import 'package:flutter/cupertino.dart';
import 'package:netflix/widgets/numerd_tile.dart';

import 'content_tile.dart';

class NumberdList extends StatelessWidget {
  const NumberdList({Key? key, required this.title, required this.contentList})
      : super(key: key);
  final String title;
  final List contentList;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 160,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return NumberedTile(
                  index: index,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
