import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isnad_worker/core/constant/app_assets.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/widgets/images/cached_image_widget.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({
    super.key,
    required this.name,
    required this.phone,
    this.imageUrl,
    this.fileImage,
    this.onImageChanged,
  });

  final String name;
  final String phone;
  final String? imageUrl;
  final File? fileImage;
  final Function(File image)? onImageChanged;

  Future<void> _pickImage(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (_) => _ImageSourceSheet(
        onCamera: () async {
          Navigator.pop(context);
          await _getImage(ImageSource.camera);
        },
        onGallery: () async {
          Navigator.pop(context);
          await _getImage(ImageSource.gallery);
        },
      ),
    );
  }

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();

    final XFile? file = await picker.pickImage(
      source: source,
      imageQuality: 85,
      maxWidth: 800,
    );

    if (file == null) return;

    final image = File(file.path);

    onImageChanged?.call(image);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              width: 120.w,
              height: 120.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primaryBorderSoft,
                  width: 3.w,
                ),
              ),
              child: ClipOval(
                child: fileImage != null
                    ? Image.file(
                        fileImage!,
                        fit: BoxFit.cover,
                        width: 120.w,
                        height: 120.h,
                      )
                    : CachedImageWidget(imageUrl: imageUrl ?? ''),
              ),
            ),

            PositionedDirectional(
              start: 4.w,
              child: GestureDetector(
                onTap: () => _pickImage(context),
                child: SvgPicture.asset(
                  AppIcons.editPhotoIcon,
                  width: 40.w,
                  height: 40.h,
                ),
              ),
            ),
          ],
        ),

        12.verticalSpace,

        Text(name, style: AppTextStyles.font18Medium),

        8.verticalSpace,

        Text(
          phone,
          style: AppTextStyles.font12Regular.copyWith(
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}

class _ImageSourceSheet extends StatelessWidget {
  const _ImageSourceSheet({required this.onCamera, required this.onGallery});

  final VoidCallback onCamera;
  final VoidCallback onGallery;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(100.r),
            ),
          ),

          16.verticalSpace,

          Text(
            'profile.Change_Profile_Photo'.tr(),
            style: AppTextStyles.font16SemiBold,
          ),

          20.verticalSpace,

          _SourceTile(
            icon: Icons.camera_alt_outlined,
            label: 'profile.Camera'.tr(),
            onTap: onCamera,
          ),

          12.verticalSpace,

          _SourceTile(
            icon: Icons.photo_library_outlined,
            label: 'profile.Gallery'.tr(),
            onTap: onGallery,
          ),

          20.verticalSpace,
        ],
      ),
    );
  }
}

class _SourceTile extends StatelessWidget {
  const _SourceTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 22.sp),
            12.horizontalSpace,
            Text(label, style: AppTextStyles.font14Medium),
          ],
        ),
      ),
    );
  }
}
