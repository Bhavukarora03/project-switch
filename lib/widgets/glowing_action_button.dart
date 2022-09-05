import 'package:flutter/material.dart';

class GlowingActionButton extends StatelessWidget {
  const GlowingActionButton(
      { Key? key, required this.onPressed, required this.icon, required this.size, required this.color})
      : super(key: key);

  final VoidCallback onPressed;
  final IconData icon;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
           BoxShadow(
              color: color.withOpacity(0.5),
              spreadRadius: 10,
              blurRadius: 15,
              offset: const Offset(0, 3), // changes position of shadow
            ),


        ],
      ),
      child: ClipOval(
        child: Material(
          color: color,
          child: InkWell(
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                size: size,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
