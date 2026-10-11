import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/utils/widgets/images/cached_image_widget.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';
import 'package:isnad_worker/core/utils/widgets/layout/custom_app_bar.dart';

class ImagePreviewDialog extends StatelessWidget {
  const ImagePreviewDialog({
    super.key,
    this.directoryId,
    this.fileId,
    this.imageUrl,
  });

  final String? directoryId;
  final String? fileId;
  final String? imageUrl;

  static Future<void> show(
    BuildContext context, {
    String? directoryId,
    String? fileId,
    String? imageUrl,
  }) {
    return showDialog(
      context: context,
      barrierColor: AppColors.backgroundPrimary,
      builder: (_) => ImagePreviewDialog(
        directoryId: directoryId,
        fileId: fileId,
        imageUrl: imageUrl,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: AppColors.backgroundPrimary,
      child: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: ''),
            Expanded(
              child: Center(
                child: CachedImageWidget(
                  directoryId: directoryId,
                  fileId: fileId,
                  imageUrl: imageUrl,
                  fit: BoxFit.contain,
                  height: 0.45.sh,
                  width: 0.85.sw,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 32.h, top: 8.h),
              child: AppContainer(
                padding: EdgeInsets.all(3.w),
                color: Colors.transparent,
                border: Border.all(color: AppColors.primary, width: 2.w),
                borderRadius: BorderRadius.circular(10.r),
                child: CachedImageWidget(
                  directoryId: directoryId,
                  fileId: fileId,
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  height: 56.h,
                  width: 56.w,
                  radius: 8.r,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
