import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/routing/app_navigator.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/app_dimensions.dart';
import 'package:isnad_worker/core/utils/controllers/theme/theme_cubit.dart';
import 'package:isnad_worker/core/utils/widgets/buttons/custom_button.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';
import 'package:isnad_worker/core/utils/widgets/layout/custom_app_bar.dart';
import 'package:isnad_worker/core/utils/widgets/layout/custom_divider_widget.dart';
import 'package:isnad_worker/features/home/presentation/screens/main_home_screen.dart';
import 'package:isnad_worker/features/profile/presentation/widgets/selectable_option_tile.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = ThemeCubit.get(context);
    final options = ['profile.light_mode'.tr(), 'profile.dark_mode'.tr()];

    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) cubit.resetSelection();
      },
      child: Scaffold(
        appBar: CustomAppBar(title: 'profile.theme'.tr()),
        body: SingleChildScrollView(
          padding: AppPadding.symmetric(),
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return Column(
                children: [
                  AppContainer(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        for (var i = 0; i < options.length; i++) ...[
                          if (i != 0)
                            CustomDivider(
                              color: AppColors.primarySurface,
                              hight: 1.8.h,
                            ),
                          SelectableOptionTile(
                            title: options[i],
                            selected: state.pendingIsDark == (i == 1),
                            onTap: () => cubit.selectTheme(i == 1),
                          ),
                        ],
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  CustomButton(
                    title: 'profile.update_theme'.tr(),
                    loading: state.loading,
                    onTap: () async {
                      final changed = state.pendingIsDark != state.isDark;
                      await cubit.updateSelectedTheme();
                      if (!changed) return AppNavigator.pop();
                      // Rebuild the whole tree so static AppColors getters refresh.
                      AppNavigator.remove(
                        const MainHomeScreen(initialIndex: 2),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
