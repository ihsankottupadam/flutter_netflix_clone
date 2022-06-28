import 'package:flutter/material.dart';

class ContentTile extends StatelessWidget {
  const ContentTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            image: DecorationImage(
                image: AssetImage('assets/images/banner_dr_strange.webp'),
                fit: BoxFit.cover)),
      ),
    );
  }
}
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