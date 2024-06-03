import 'package:flutter/material.dart';
import 'package:flutter_ui_components/flutter_ui_components.dart';

class AssetGraphic extends StatelessWidget {
  const AssetGraphic(
    this.image, {
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
  final ImageModel image;

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

  final String? package;

  static const _svg = '.svg';

  @override
  Widget build(BuildContext context) {
    if (image.path.endsWith(_svg)) {
      return _onSvgAsset();
    } else {
      return _onImageAsset();
    }
  }

  Widget _onSvgAsset() {
    return SvgAsset(
      image.path,
      size: size,
      color: color,
      width: width,
      height: height,
      fit: fit,
      package: image.package,
    );
  }

  Widget _onImageAsset() {
    return Image.asset(
      image.path,
      height: height ?? size,
      width: width ?? size,
      color: color,
      fit: fit,
      package: image.package,
    );
  }
}
