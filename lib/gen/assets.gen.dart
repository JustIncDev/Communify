/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:rive/rive.dart';

class $AssetsAnimationsGen {
  const $AssetsAnimationsGen();

  /// File path: assets/animations/success-check.riv
  RiveGenImage get successCheck =>
      const RiveGenImage('assets/animations/success-check.riv');

  /// List of all assets
  List<RiveGenImage> get values => [successCheck];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/Apple.png
  AssetGenImage get apple => const AssetGenImage('assets/images/Apple.png');

  /// File path: assets/images/CameraIcon.png
  AssetGenImage get cameraIcon =>
      const AssetGenImage('assets/images/CameraIcon.png');

  /// File path: assets/images/Checkmark.png
  AssetGenImage get checkmark =>
      const AssetGenImage('assets/images/Checkmark.png');

  /// File path: assets/images/Chevron Left.png
  AssetGenImage get chevronLeft =>
      const AssetGenImage('assets/images/Chevron Left.png');

  /// File path: assets/images/Communify.png
  AssetGenImage get communify =>
      const AssetGenImage('assets/images/Communify.png');

  /// File path: assets/images/DeleteIcon.png
  AssetGenImage get deleteIcon =>
      const AssetGenImage('assets/images/DeleteIcon.png');

  /// File path: assets/images/Discord.png
  AssetGenImage get discord => const AssetGenImage('assets/images/Discord.png');

  /// File path: assets/images/DiscordColor.png
  AssetGenImage get discordColor =>
      const AssetGenImage('assets/images/DiscordColor.png');

  /// File path: assets/images/Facebook.png
  AssetGenImage get facebook =>
      const AssetGenImage('assets/images/Facebook.png');

  /// File path: assets/images/Google.png
  AssetGenImage get google => const AssetGenImage('assets/images/Google.png');

  /// File path: assets/images/Instagram.png
  AssetGenImage get instagram =>
      const AssetGenImage('assets/images/Instagram.png');

  /// File path: assets/images/LinkedIn.png
  AssetGenImage get linkedIn =>
      const AssetGenImage('assets/images/LinkedIn.png');

  /// File path: assets/images/Metamask.png
  AssetGenImage get metamask =>
      const AssetGenImage('assets/images/Metamask.png');

  /// File path: assets/images/PhotoIcon.png
  AssetGenImage get photoIcon =>
      const AssetGenImage('assets/images/PhotoIcon.png');

  /// File path: assets/images/TikTok.png
  AssetGenImage get tikTok => const AssetGenImage('assets/images/TikTok.png');

  /// File path: assets/images/Twitter.png
  AssetGenImage get twitter => const AssetGenImage('assets/images/Twitter.png');

  /// File path: assets/images/TwitterColor.png
  AssetGenImage get twitterColor =>
      const AssetGenImage('assets/images/TwitterColor.png');

  /// File path: assets/images/Wallet-Connect.png
  AssetGenImage get walletConnect =>
      const AssetGenImage('assets/images/Wallet-Connect.png');

  /// File path: assets/images/Website.png
  AssetGenImage get website => const AssetGenImage('assets/images/Website.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        apple,
        cameraIcon,
        checkmark,
        chevronLeft,
        communify,
        deleteIcon,
        discord,
        discordColor,
        facebook,
        google,
        instagram,
        linkedIn,
        metamask,
        photoIcon,
        tikTok,
        twitter,
        twitterColor,
        walletConnect,
        website
      ];
}

class AppAssets {
  AppAssets._();

  static const $AssetsAnimationsGen animations = $AssetsAnimationsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class RiveGenImage {
  const RiveGenImage(this._assetName);

  final String _assetName;

  RiveAnimation rive({
    String? artboard,
    List<String> animations = const [],
    List<String> stateMachines = const [],
    BoxFit? fit,
    Alignment? alignment,
    Widget? placeHolder,
    bool antialiasing = true,
    List<RiveAnimationController> controllers = const [],
    OnInitCallback? onInit,
  }) {
    return RiveAnimation.asset(
      _assetName,
      artboard: artboard,
      animations: animations,
      stateMachines: stateMachines,
      fit: fit,
      alignment: alignment,
      placeHolder: placeHolder,
      antialiasing: antialiasing,
      controllers: controllers,
      onInit: onInit,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
