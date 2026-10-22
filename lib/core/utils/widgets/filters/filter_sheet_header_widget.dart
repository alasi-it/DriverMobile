import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';

class FilterSheetHeader extends StatelessWidget {
  const FilterSheetHeader({
    super.key,
    this.title = '',
    this.titleWidget,
    this.showCloseButton = true,
  });
  final String title;
  final Widget? titleWidget;
  final bool showCloseButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (showCloseButton) ...[
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: AppContainer(
                  height: 24.h,
                  width: 24.w,
                  padding: EdgeInsets.zero,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4.r),
                  child: Icon(
                    Icons.close,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20.sp,
                  ),
                ),
              ),

              SizedBox(width: 16.w),
            ],

            Expanded(
              child: Align(
                alignment: Alignment.center,
                child:
                    titleWidget ??
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              ),
            ),
            SizedBox(width: 40.w),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Divider(thickness: 1.h, color: AppColors.primarySurface),
        ),
      ],
    );
  }
}
