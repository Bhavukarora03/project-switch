
import 'package:flutter/material.dart';

class IconBackground extends StatelessWidget {
  const IconBackground({Key key, this.icon, this.onPressed}) : super(key: key);

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return  Material(
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        onTap: onPressed,
        child:  Padding(

          padding: const  EdgeInsets.all(8),
          child:  Icon(
            icon,
            color: Colors.white,
            size: 18,
          ),
        ),
      ),


    );
  }
}
