import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/widgets/buttons/app_bar_back_button_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? titleWidget;
  final bool centerTitle;

  const CustomAppBar({
    super.key,
    this.title = '',
    this.leading,
    this.onBackPressed,
    this.titleWidget,
    this.actions,
    this.centerTitle = true,
  });

  @override
  Size get preferredSize => Size.fromHeight(64.h);

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.canPop(context);

    return AppBar(
      title: Padding(
        padding: EdgeInsetsDirectional.only(start: 16.w),
        child: titleWidget ?? Text(title, style: AppTextStyles.font20Bold),
      ),
      backgroundColor: Colors.transparent,
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      actions: actions != null
          ? [
              Padding(
                padding: EdgeInsetsDirectional.only(end: 16.w),
                child: Row(mainAxisSize: MainAxisSize.min, children: actions!),
              ),
            ]
          : null,
      leading:
          leading ??
          (canPop
              ? AppBarBackButtonWidget(
                  onTap: onBackPressed ?? () => Navigator.pop(context),
                )
              : null),
    );
  }
}
