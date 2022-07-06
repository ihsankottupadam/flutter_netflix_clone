import 'package:flutter/material.dart';

class VerticalIconButton extends StatelessWidget {
  const VerticalIconButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconSize = 24,
    this.fontSize = 15,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);
  final IconData icon;
  final String label;
  final Function onTap;
  final double iconSize;
  final double fontSize;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: padding,
        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: iconSize,
            ),
            SizedBox(height: iconSize / 3),
            Text(label,
                style: TextStyle(
                    fontSize: fontSize,
                    color: Colors.white,
                    fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }
}
