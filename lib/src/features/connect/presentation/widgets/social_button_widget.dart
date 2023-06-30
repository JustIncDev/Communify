import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../gen/assets.gen.dart';

enum SocialNetworkType {
  apple,
  google,
  twitter,
  discord,
}

class SocialButtonWidget extends StatelessWidget {
  const SocialButtonWidget({
    required this.type,
    required this.onPressed,
    super.key,
  });

  final SocialNetworkType type;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final assetName = switch (type) {
      SocialNetworkType.apple => AppAssets.images.apple.path,
      SocialNetworkType.google => AppAssets.images.google.path,
      SocialNetworkType.discord => AppAssets.images.discord.path,
      SocialNetworkType.twitter => AppAssets.images.twitter.path,
    };

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: Colors.black,
        padding: const EdgeInsets.all(10),
      ),
      child: Image.asset(
        assetName,
        width: 28,
        height: 28,
      ),
    );
  }
}
