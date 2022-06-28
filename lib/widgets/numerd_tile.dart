import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';

class NumberedTile extends StatelessWidget {
  const NumberedTile({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: Stack(
        children: [
          Positioned(
              right: 0,
              child: Container(
                width: 100,
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    image: DecorationImage(
                      image: AssetImage('assets/images/banner_dr_strange.webp'),
                      fit: BoxFit.cover,
                    )),
              )),
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
