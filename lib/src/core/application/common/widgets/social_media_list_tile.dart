import 'package:flutter/material.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';
import '../../../util/assets/text/text_extention.dart';
import 'primary_text_field.dart';

enum SocialMediaType {
  twitter,
  instagram,
  facebook,
  linkedin,
  tiktok,
  discord,
  website,
}

class SocialMediaListTile extends StatelessWidget {
  const SocialMediaListTile({
    required this.type,
    required this.textEditingController,
    super.key,
  });

  final SocialMediaType type;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>() ?? AppTextTheme.base();

    final (networkImage, networkName, textFieldHint) = switch (type) {
      SocialMediaType.twitter => (
          AppAssets.images.twitterColor.image(
            width: 25,
            height: 25,
          ),
          Text(
            S.current.twitter,
            style: textTheme.medium15.copyWith(
              fontFamily: 'Montserrat',
              color: const Color(0xFF03A9F4),
            ),
          ),
          S.current.username_hint,
        ),
      SocialMediaType.instagram => (
          AppAssets.images.instagram.image(
            width: 25,
            height: 25,
          ),
          Text(
            S.current.instagram,
            style: textTheme.medium15.copyWith(
              fontFamily: 'Montserrat',
              color: const Color(0xFFF04C5D),
            ),
          ),
          S.current.username_hint,
        ),
      SocialMediaType.facebook => (
          AppAssets.images.facebook.image(
            width: 25,
            height: 25,
          ),
          Text(
            S.current.facebook,
            style: textTheme.medium15.copyWith(
              fontFamily: 'Montserrat',
              color: const Color(0xFF039BE5),
            ),
          ),
          S.current.facebook_hint,
        ),
      SocialMediaType.linkedin => (
          AppAssets.images.linkedIn.image(
            width: 25,
            height: 25,
          ),
          Text(
            S.current.linkedIn,
            style: textTheme.medium15.copyWith(
              fontFamily: 'Montserrat',
              color: const Color(0xFF0288D1),
            ),
          ),
          S.current.linkedIn_hint,
        ),
      SocialMediaType.tiktok => (
          AppAssets.images.tikTok.image(
            width: 25,
            height: 25,
          ),
          Text(
            S.current.tikTok,
            style: textTheme.medium15.copyWith(
              fontFamily: 'Montserrat',
              color: Colors.white,
            ),
          ),
          S.current.username_hint,
        ),
      SocialMediaType.discord => (
          AppAssets.images.discordColor.image(
            width: 25,
            height: 25,
          ),
          Text(
            S.current.discord,
            style: textTheme.medium15.copyWith(
              fontFamily: 'Montserrat',
              color: Colors.white,
            ),
          ),
          S.current.discord_hint,
        ),
      SocialMediaType.website => (
          AppAssets.images.website.image(
            width: 25,
            height: 25,
          ),
          Text(
            S.current.website,
            style: textTheme.medium15.copyWith(
              fontFamily: 'Montserrat',
              color: Colors.white,
            ),
          ),
          S.current.website_hint,
        ),
    };

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            networkImage,
            const SizedBox(width: 8),
            networkName,
          ],
        ),
        const SizedBox(width: 20),
        SizedBox(
          width: 210,
          child: PrimaryTextField(
            hintText: textFieldHint,
            borderRadius: 10,
            controller: TextEditingController(),
          ),
        ),
      ],
    );
  }
}
