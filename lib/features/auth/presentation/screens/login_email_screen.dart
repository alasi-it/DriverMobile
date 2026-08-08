import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/constant/app_assets.dart';
import 'package:isnad_worker/core/network/local/cache/cache_keys.dart';
import 'package:isnad_worker/core/network/local/cache/secure_storage.dart';
import 'package:isnad_worker/core/routing/app_navigator.dart';
import 'package:isnad_worker/core/style/app_dimensions.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/helper/app_toast.dart';
import 'package:isnad_worker/core/utils/validators/app_validators.dart';
import 'package:isnad_worker/core/utils/widgets/buttons/custom_button.dart';
import 'package:isnad_worker/core/utils/widgets/fields/custom_field_text.dart';
import 'package:isnad_worker/features/auth/presentation/manager/auth_cubit.dart';
import 'package:isnad_worker/features/auth/presentation/screens/login_phone_screen.dart';
import 'package:isnad_worker/features/auth/presentation/widgets/auth_header_widget.dart';
import 'package:isnad_worker/features/auth/presentation/widgets/auth_log_widget.dart';
import 'package:isnad_worker/features/home/presentation/screens/home_screen.dart';

class LoginEmailScreen extends StatefulWidget {
  const LoginEmailScreen({super.key});

  @override
  State<LoginEmailScreen> createState() => _LoginEmailScreenState();
}

class _LoginEmailScreenState extends State<LoginEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SecureStorage.instance.delete(CacheKeys.token);
  }

  bool obscurePassword = true;

  void updateObscurePassword() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      AppNavigator.push(const HomeScreen());
      // context.read<AuthCubit>().login(
      //   deviceId: '',
      //   password: _passwordController.text,
      //   phoneNumber: _emailController.text,
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) async {
          if (state is LoginFailureState) {
            AppToast.error(state.message);
          } else if (state is LoginNotAllowedState) {
            AppToast.error('auth.login.not_allowed'.tr());
          } else if (state is LoginSuccessState) {
            await SecureStorage.instance.write(
              CacheKeys.token,
              state.data.token ?? '',
            );
            await SecureStorage.instance.write(
              CacheKeys.refreshtoken,
              state.data.refreshToken ?? '',
            );
            // AppNavigator.remove(const MainHomeScreen());
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: AppPadding.symmetric(),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          16.verticalSpace,
                          AuthLogo(logo: AppIcons.loginEmailImage),
                          32.verticalSpace,

                          AuthHeaderWidget(title: "auth.login.title".tr()),

                          24.verticalSpace,
                          CustomFieldText(
                            controller: _emailController,
                            title: "auth.login.email.title".tr(),
                            hintText: "auth.login.email.title".tr(),
                            keyboardType: TextInputType.emailAddress,
                            showRequiredIndicator: true,
                            validator: (value) => AppValidators.email(value),
                          ),

                          24.verticalSpace,
                          CustomFieldText(
                            controller: _passwordController,
                            obscurePassword: obscurePassword,
                            onTogglePassword: updateObscurePassword,
                            isPassword: true,
                            title: "auth.login.password.title".tr(),
                            hintText: "auth.login.password.title".tr(),
                            showRequiredIndicator: true,
                            keyboardType: TextInputType.visiblePassword,

                            validator: (value) => AppValidators.password(value),
                          ),
                          16.verticalSpace,
                        ],
                      ),
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      spacing: 16.h,
                      children: [
                        CustomButton(
                          loading: state is LoginLoadingState,
                          title: "auth.login.button".tr(),
                          onTap: _submit,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                AppNavigator.push(const LoginPhoneScreen());
                              },
                              child: Text(
                                "auth.login.login_with_phone".tr(),
                                style: AppTextStyles.font12Regular,
                              ),
                            ),
                          ],
                        ),
                        8.verticalSpace,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
