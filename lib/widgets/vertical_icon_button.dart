import 'package:flutter/material.dart';

class VerticalIconButton extends StatelessWidget {
  const VerticalIconButton(
      {Key? key, required this.icon, required this.label, required this.onTap})
      : super(key: key);
  final IconData icon;
  final String label;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Column(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(height: 2),
          Text(label,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600))
        ],
      ),
    );
  }
}
