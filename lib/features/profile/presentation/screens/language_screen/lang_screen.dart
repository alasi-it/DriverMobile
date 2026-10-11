import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/routing/app_navigator.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/app_dimensions.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/helper/app_locals.dart';
import 'package:isnad_worker/core/utils/widgets/buttons/custom_button.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';
import 'package:isnad_worker/core/utils/widgets/layout/custom_app_bar.dart';
import 'package:isnad_worker/core/utils/widgets/layout/custom_divider_widget.dart';
import 'package:isnad_worker/features/home/presentation/screens/main_home_screen.dart';

class LangScreen extends StatefulWidget {
  const LangScreen({super.key});

  @override
  State<LangScreen> createState() => _LangScreenState();
}

class _LangScreenState extends State<LangScreen> {
  late int _selectedIndex = _activeLangIndex();
  bool _updating = false;

  int _activeLangIndex() {
    final index = AppLocales.supportedLocalesCodes.indexOf(
      context.locale.languageCode,
    );
    return index >= 0 ? index : 0;
  }

  Future<void> _onUpdate() async {
    setState(() => _updating = true);
    await AppLocales.setDeviceLocale(_selectedIndex);
    if (!mounted) return;
    // context.read<LookupsCubit>().clearAll();
    AppNavigator.remove(MainHomeScreen(initialIndex: 3));
  }

  @override
  Widget build(BuildContext context) {
    final names = AppLocales.supportedLocalesNames;

    return Scaffold(
      appBar: CustomAppBar(title: 'profile.language'.tr()),
      body: SingleChildScrollView(
        padding: AppPadding.symmetric(),
        child: Column(
          children: [
            AppContainer(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  for (var i = 0; i < names.length; i++) ...[
                    if (i != 0)
                      CustomDivider(
                        color: AppColors.primarySurface,
                        hight: 1.8.h,
                      ),
                    _LanguageTile(
                      title: names[i],
                      selected: _selectedIndex == i,
                      onTap: () => setState(() => _selectedIndex = i),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: 24.h),
            CustomButton(
              title: 'profile.update_language'.tr(),
              loading: _updating,
              onTap: _onUpdate,
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: selected
                    ? AppTextStyles.font16SemiBold.copyWith(
                        color: AppColors.primary,
                      )
                    : AppTextStyles.font16Medium,
              ),
            ),
            Icon(
              selected ? Icons.check_circle_rounded : Icons.circle_outlined,
              color: selected ? AppColors.primary : AppColors.border,
              size: 22.sp,
            ),
          ],
        ),
      ),
    );
  }
}
