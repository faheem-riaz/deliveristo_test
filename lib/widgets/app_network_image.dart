import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  final String? url;
  const AppNetworkImage({super.key, this.url});

  @override
  Widget build(BuildContext context) {
    return url == null || url!.isEmpty
        ? const SizedBox()
        : CachedNetworkImage(
            imageUrl: url ?? '',
            errorWidget: (context, url, error) => const Icon(
              Icons.error,
              color: Colors.red,
              size: 50,
            ),
            fit: BoxFit.cover,
          );
  }
}
