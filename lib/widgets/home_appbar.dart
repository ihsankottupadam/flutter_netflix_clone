import 'package:flutter/material.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({Key? key, this.scrollOffset = 0.0}) : super(key: key);
  final double scrollOffset;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 24),
      color:
          Colors.black.withOpacity((scrollOffset / 350).clamp(0, 1).toDouble()),
      child: SafeArea(
        child: Row(
          children: [
            Image.asset('assets/images/netflix_logo_small.png'),
            const SizedBox(width: 10),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _AppbarButton(label: 'TV Shows', onTap: () {}),
                  _AppbarButton(label: 'Movies', onTap: () {}),
                  _AppbarButton(label: 'Categories', onTap: () {})
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _AppbarButton extends StatelessWidget {
  const _AppbarButton({Key? key, required this.label, required this.onTap})
      : super(key: key);
  final String label;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Text(
        label,
        style: const TextStyle(
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
      ),
    );
  }
}
