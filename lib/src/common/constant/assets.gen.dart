/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// Directory path: assets/images/m_thread
  $AssetsImagesMThreadGen get mThread => const $AssetsImagesMThreadGen();

  /// Directory path: assets/images/type_thread
  $AssetsImagesTypeThreadGen get typeThread =>
      const $AssetsImagesTypeThreadGen();
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/bolt.svg
  String get bolt => 'assets/svg/bolt.svg';

  /// File path: assets/svg/gaika.svg
  String get gaika => 'assets/svg/gaika.svg';

  /// File path: assets/svg/m_thread.svg
  String get mThread => 'assets/svg/m_thread.svg';

  /// List of all assets
  List<String> get values => [bolt, gaika, mThread];
}

class $AssetsImagesMThreadGen {
  const $AssetsImagesMThreadGen();

  /// File path: assets/images/m_thread/bolt.png
  AssetGenImage get bolt =>
      const AssetGenImage('assets/images/m_thread/bolt.png');

  /// File path: assets/images/m_thread/nuts.png
  AssetGenImage get nuts =>
      const AssetGenImage('assets/images/m_thread/nuts.png');

  /// List of all assets
  List<AssetGenImage> get values => [bolt, nuts];
}

class $AssetsImagesTypeThreadGen {
  const $AssetsImagesTypeThreadGen();

  /// File path: assets/images/type_thread/g_thread.png
  AssetGenImage get gThread =>
      const AssetGenImage('assets/images/type_thread/g_thread.png');

  /// File path: assets/images/type_thread/m_thread.png
  AssetGenImage get mThread =>
      const AssetGenImage('assets/images/type_thread/m_thread.png');

  /// List of all assets
  List<AssetGenImage> get values => [gThread, mThread];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

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
    bool gaplessPlayback = true,
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
