import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgAsset extends StatelessWidget {
  /// Customized SvgPicture.asset with simple api.
  /// Instantiates a widget that renders an SVG picture from an [AssetBundle].
  /// `name` is the assetName.
  const SvgAsset(
    this.name, {
    this.size,
    this.color,
    this.width,
    this.height,
    this.clipBehavior,
    this.fit,
    this.package,
    super.key,
  });

  /// `name` is the asset name.
  final String name;

  /// If specified, `size` will set the `height` and `width` of the svg.
  final double? size;

  /// The color for the svg
  final Color? color;

  /// If specified, `width` the width to use for svg, otherwise, it will take the width of its parent.
  final double? width;

  /// If specified, `height` the height to use for svg, otherwise, it will take the height of its parent.
  final double? height;

  /// How to inscribe the picture into the space allocated during layout. The default is [BoxFit.contain].
  final BoxFit? fit;

  /// The content will be clipped (or not) according to this option.
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip? clipBehavior;

  // Asset package
  final String? package;

  @override
  Widget build(BuildContext context) {
    final colorFilter = color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null;

    return SvgPicture.asset(
      name,
      fit: fit ?? BoxFit.contain,
      width: size ?? width,
      height: size ?? height,
      clipBehavior: clipBehavior ?? Clip.hardEdge,
      colorFilter: colorFilter,
      package: package,
    );
  }
}
