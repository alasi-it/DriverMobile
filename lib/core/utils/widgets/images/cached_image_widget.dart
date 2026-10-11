import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:isnad_worker/core/constant/app_assets.dart';
import 'package:isnad_worker/core/network/remote/end_points.dart';
import 'package:isnad_worker/core/services/file_loader_service.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';
import 'package:shimmer/shimmer.dart';

class CachedImageWidget extends StatelessWidget {
  const CachedImageWidget({
    super.key,
    this.imageUrl,
    this.fileId,
    this.directoryId,
    this.localFile,
    this.fit = BoxFit.cover,
    this.height,
    this.width,
    this.radius,
  }) : assert(
         imageUrl != null ||
             fileId != null ||
             localFile != null ||
             directoryId != null,
         'One of imageUrl, fileId, directoryId, or localFile must be provided',
       );

  final String? imageUrl;
  final String? fileId;
  final String? directoryId;
  final File? localFile;
  final BoxFit fit;
  final double? height, width, radius;

  bool get _isNetwork =>
      imageUrl != null &&
      (imageUrl!.startsWith('http://') ||
          imageUrl!.startsWith('https://') ||
          imageUrl!.startsWith('/'));

  bool get _isSvg =>
      imageUrl != null && imageUrl!.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    Widget image;

    if (directoryId != null && directoryId!.isNotEmpty) {
      return _DirectoryProfileImage(
        directoryId: directoryId!,
        height: height,
        width: width,
        radius: radius,
        fit: fit,
      );
    }

    if (fileId != null && fileId!.isNotEmpty) {
      return _FileIdImage(
        fileId: fileId!,
        height: height,
        width: width,
        radius: radius,
        fit: fit,
      );
    }

    if ((imageUrl == null || imageUrl!.isEmpty) && localFile == null) {
      return _errorPlaceholder(height, width, radius, fit);
    }

    if (localFile != null) {
      image = Image.file(
        localFile!,
        fit: fit,
        height: height,
        width: width,
        errorBuilder: (_, _, _) => Image.asset(AppImages.errorImage, fit: fit),
      );
    } else if (_isSvg) {
      image = _isNetwork
          ? SvgPicture.network(
              imageUrl!,
              fit: fit,
              height: height,
              width: width,
              placeholderBuilder: (_) => _shimmer(height, width, radius),
            )
          : SvgPicture.asset(imageUrl!, fit: fit, height: height, width: width);
    } else if (_isNetwork) {
      image = CachedNetworkImage(
        imageUrl: imageUrl!.startsWith('/uploads')
            ? (BASEIMAGEURL + imageUrl!)
            : imageUrl!,
        fit: fit,
        height: height,
        width: width,
        placeholder: (context, url) => _shimmer(height, width, radius),
        errorWidget: (context, url, error) =>
            Image.asset(AppImages.errorImage, fit: fit),
      );
    } else {
      image = Image.asset(imageUrl!, fit: fit, height: height, width: width);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: image,
    );
  }
}

Widget _shimmer(double? height, double? width, [double? radius]) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: AppContainer(
      height: height ?? 120,
      width: width ?? double.infinity,
      color: Colors.grey.shade300,
      borderRadius: BorderRadius.circular(radius ?? 0),
    ),
  );
}

Widget _errorPlaceholder(
  double? height,
  double? width,
  double? radius,
  BoxFit fit,
) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(radius ?? 0),
    child: Image.asset(
      AppImages.errorImage,
      fit: fit,
      height: height,
      width: width,
    ),
  );
}

class _FileIdImage extends StatefulWidget {
  const _FileIdImage({
    required this.fileId,
    this.height,
    this.width,
    this.radius,
    this.fit = BoxFit.cover,
  });

  final String fileId;
  final double? height, width, radius;
  final BoxFit fit;

  @override
  State<_FileIdImage> createState() => _FileIdImageState();
}

class _FileIdImageState extends State<_FileIdImage> {
  late Future<Uint8List?> _future;

  @override
  void initState() {
    super.initState();
    _future = loadFileBytes(widget.fileId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(widget.radius ?? 0),
            child: _shimmer(widget.height, widget.width, widget.radius),
          );
        }
        if (snapshot.hasData) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(widget.radius ?? 0),
            child: Image.memory(
              snapshot.data!,
              height: widget.height,
              width: widget.width,
              fit: widget.fit,
            ),
          );
        }
        return _errorPlaceholder(
          widget.height,
          widget.width,
          widget.radius,
          widget.fit,
        );
      },
    );
  }
}

class _DirectoryProfileImage extends StatefulWidget {
  const _DirectoryProfileImage({
    required this.directoryId,
    this.height,
    this.width,
    this.radius,
    this.fit = BoxFit.cover,
  });

  final String directoryId;
  final double? height, width, radius;
  final BoxFit fit;

  @override
  State<_DirectoryProfileImage> createState() => _DirectoryProfileImageState();
}

class _DirectoryProfileImageState extends State<_DirectoryProfileImage> {
  late Future<Uint8List?> _future;

  @override
  void initState() {
    super.initState();
    _future = _loadImage();
  }

  Future<Uint8List?> _loadImage() async {
    final fileId = await loadDirectoryProfileFileId(widget.directoryId);
    if (fileId == null) return null;
    return loadFileBytes(fileId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(widget.radius ?? 0),
            child: _shimmer(widget.height, widget.width, widget.radius),
          );
        }
        if (snapshot.hasData) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(widget.radius ?? 0),
            child: Image.memory(
              snapshot.data!,
              height: widget.height,
              width: widget.width,
              fit: widget.fit,
            ),
          );
        }
        return ClipRRect(
          borderRadius: BorderRadius.circular(widget.radius ?? 0),
          child: Image.asset(
            'assets/images/Profile Image.png',
            height: widget.height,
            width: widget.width,
            fit: widget.fit,
            errorBuilder: (_, _, _) => Image.asset(
              AppImages.defaultImage,
              fit: widget.fit,
              height: widget.height,
              width: widget.width,
            ),
          ),
        );
      },
    );
  }
}
