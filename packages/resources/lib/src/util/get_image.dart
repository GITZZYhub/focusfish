import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../resources.dart';

class GetImage {
  GetImage._();

  static Image getAssetsImage(final String imageName, {final BoxFit? fit}) =>
      Image.asset(
        imageName,
        package: 'resources',
        width: double.infinity,
        height: double.infinity,
        fit: fit ?? BoxFit.contain,
      );

  static Image getAssetsImageWithWidth(
    final String imageName,
    final double? width,
  ) =>
      Image.asset(
        imageName,
        package: 'resources',
        width: width,
      );

  static Image getAssetsImageWithHeight({
    required final String imageName,
    required final double height,
  }) =>
      Image.asset(
        imageName,
        package: 'resources',
        height: height,
      );

  static DecorationImage getDecorationImage(
    final String imageName,
    final BoxFit fit,
  ) =>
      DecorationImage(
        image: AssetImage(imageName, package: 'resources'),
        fit: fit,
      );

  static Widget getNetworkImage(final String imageUrl, final BoxFit fit) =>
      FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        fadeInDuration: const Duration(milliseconds: 300),
        image: imageUrl,
        width: double.infinity,
        height: double.infinity,
        fit: fit,
      );

  static Widget getSvgImage(
    final String imageName, {
    required final double size,
  }) =>
      SvgPicture.asset(
        imageName,
        width: size,
        package: 'resources',
      );

  static Widget getRoundedImageFromNetwork(
    final String path, {
    required final double width,
    final Color? borderColor,
  }) =>
      Container(
        width: width,
        height: width,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor ?? ColorRes.itemDividerColor,
            width: dim2w,
          ),
          image: DecorationImage(
            image: NetworkImage(path),
            fit: BoxFit.fill,
          ),
        ),
      );

  static Widget getRoundedImageFromFile(
    final String path, {
    required final double width,
    final Color? borderColor,
  }) =>
      Container(
        width: width,
        height: width,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor ?? ColorRes.itemDividerColor,
            width: dim2w,
          ),
          image: DecorationImage(
            image: FileImage(File(path)),
            fit: BoxFit.fill,
          ),
        ),
      );
}
