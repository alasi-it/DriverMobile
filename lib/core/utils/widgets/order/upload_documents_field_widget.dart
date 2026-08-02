import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:isnad_worker/core/constant/app_assets.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/validators/app_validators.dart';

enum UploadType { image, file }

class UploadDocumentsField extends StatefulWidget {
  final String? title;
  final UploadType uploadType;
  final String? subTitle;

  /// Maximum allowed file size in megabytes. Defaults to 5 MB.
  final double maxFileSizeMB;
  final FormFieldSetter<File>? onSaved;
  final FormFieldValidator<File>? validator;
  final File? initialValue;

  const UploadDocumentsField({
    super.key,
    this.subTitle,
    this.onSaved,
    this.validator = AppValidators.fileRequired,
    this.title,
    this.uploadType = UploadType.file,
    this.maxFileSizeMB = 5,
    this.initialValue,
  });

  @override
  State<UploadDocumentsField> createState() => _UploadDocumentsFieldState();
}

class _UploadDocumentsFieldState extends State<UploadDocumentsField> {
  String? _sizeError;

  Future<void> _pickFile(FormFieldState<File> state) async {
    FilePickerResult? result;

    if (widget.uploadType == UploadType.image) {
      result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        withData: false,
      );
    } else {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
        allowMultiple: false,
        withData: false,
      );
    }

    if (result != null && result.files.isNotEmpty) {
      final file = File(result.files.first.path!);
      final fileSizeBytes = await file.length();
      final maxBytes = widget.maxFileSizeMB * 1024 * 1024;

      if (fileSizeBytes > maxBytes) {
        setState(() {
          _sizeError = 'validators.files.size_exceeded'.tr(
            namedArgs: {'max': widget.maxFileSizeMB.toStringAsFixed(0)},
          );
        });
        state.didChange(null);
        return;
      }

      setState(() => _sizeError = null);
      state.didChange(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<File>(
      initialValue: widget.initialValue,
      onSaved: widget.onSaved,
      validator: (file) {
        if (_sizeError != null) return _sizeError;
        return widget.validator?.call(file);
      },
      builder: (state) {
        final hasError = state.hasError || _sizeError != null;
        final errorText = _sizeError ?? state.errorText;
        final borderColor = hasError ? AppColors.errorText : AppColors.grey100;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title ?? 'core.documents_and_photos'.tr(),
              style: AppTextStyles.font16Medium.copyWith(
                color: AppColors.typographyHeadingLight,
              ),
            ),
            SizedBox(height: 12.h),
            GestureDetector(
              onTap: () => _pickFile(state),
              child: state.value == null
                  ? DottedBorder(
                      options: RoundedRectDottedBorderOptions(
                        dashPattern: const [8, 4],
                        strokeWidth: 1.r,
                        color: borderColor,
                        radius: Radius.circular(16.r),
                        padding: EdgeInsets.symmetric(vertical: 38.r),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              AppIcons.uploadFileIcon,
                              width: 50.w,
                              height: 50.h,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              widget.subTitle ?? 'core.upload_tap_or_drag'.tr(),
                              style: AppTextStyles.font12Bold,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              widget.uploadType == UploadType.image
                                  ? 'core.upload_image'.tr()
                                  : 'core.upload_file'.tr(),
                              style: AppTextStyles.font12Regular,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: borderColor),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            widget.uploadType == UploadType.image
                                ? Icons.image
                                : Icons.insert_drive_file,
                            size: 20.sp,
                            color: AppColors.grey100,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              state.value!.path.split('/').last,
                              style: AppTextStyles.font12Regular,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _pickFile(state),
                            child: Icon(
                              Icons.edit,
                              size: 18.sp,
                              color: AppColors.grey100,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          GestureDetector(
                            onTap: () {
                              setState(() => _sizeError = null);
                              state.didChange(null);
                            },
                            child: Icon(
                              Icons.close,
                              size: 18.sp,
                              color: AppColors.errorText,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            if (hasError)
              Padding(
                padding: EdgeInsets.only(top: 8.h, right: 12.w),
                child: Text(
                  errorText!,
                  style: AppTextStyles.font14Regular.copyWith(
                    color: AppColors.errorText,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
