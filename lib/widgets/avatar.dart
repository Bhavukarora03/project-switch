import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({Key? key, required this.radius, this.url, this.onPressed})
      : super(key: key);

  const Avatar.small({Key? key, this.radius = 16, this.url, this.onPressed})
      : super(key: key);

  const Avatar.medium({Key? key, this.radius = 22, this.url, this.onPressed})
      : super(key: key);

  const Avatar.large({Key? key, this.radius = 40, this.url, this.onPressed})
      : super(key: key);

  final double radius;
  final String? url;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: _avatar(context),
    );
  }

  Widget _avatar(BuildContext context) {
    if (url != null) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: CachedNetworkImageProvider(url!),
      );
    } else {
      return CircleAvatar(
        radius: radius,
        backgroundColor: Theme.of(context).cardColor,
        child: Text(
          '?',
          style: TextStyle(
            color: Colors.white,
            fontSize: radius,
          ),
        ),
      );
    }
  }
}
