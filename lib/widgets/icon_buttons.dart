
import 'package:flutter/material.dart';

class IconBackground extends StatelessWidget {
  const IconBackground({Key key, this.icon, this.onPressed, this.size = 18}) : super(key: key);
  const IconBackground.small({Key key, this.icon, this.onPressed, this.size = 12}) : super(key: key);

  final IconData icon;
  final VoidCallback onPressed;
  final double size;

  @override
  Widget build(BuildContext context) {
    return  Material(
      borderRadius: const BorderRadius.all(Radius.circular(50)),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        onTap: onPressed,
        child:  Padding(

          padding: const  EdgeInsets.all(8),
          child:  Icon(
            icon,
            color: Colors.white,
            size: size,
          ),
        ),
      ),


    );
  }
}
