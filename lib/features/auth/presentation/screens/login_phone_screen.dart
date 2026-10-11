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
import 'package:isnad_worker/core/utils/widgets/fields/custom_field_phone.dart';
import 'package:isnad_worker/core/utils/widgets/fields/custom_field_text.dart';
import 'package:isnad_worker/features/auth/presentation/manager/auth_cubit.dart';
import 'package:isnad_worker/features/auth/presentation/screens/login_email_screen.dart';
import 'package:isnad_worker/features/auth/presentation/widgets/auth_header_widget.dart';
import 'package:isnad_worker/features/auth/presentation/widgets/auth_log_widget.dart';
import 'package:isnad_worker/features/home/presentation/screens/main_home_screen.dart';

class LoginPhoneScreen extends StatefulWidget {
  const LoginPhoneScreen({super.key});

  @override
  State<LoginPhoneScreen> createState() => _LoginPhoneScreenState();
}

class _LoginPhoneScreenState extends State<LoginPhoneScreen> {
  final _formKey = GlobalKey<FormState>();
  String _Code = '966';
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
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
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      AppNavigator.push(const MainHomeScreen());

      // context.read<AuthCubit>().login(
      //   deviceId: _phoneController.text,
      //   password: _passwordController.text,
      //   phoneNumber: _Code + _phoneController.text,
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) async {
          // if (state is SocialLoginSuccessState) {
          //   AppLogger.debug("Login Success! Token: ${state.data.token}");

          //   await SecureStorage.instance.write(
          //     CacheKeys.token,
          //     state.data.token ?? '',
          //   );
          //   SecureStorage.instance.write(
          //     CacheKeys.refreshtoken,
          //     state.data.refreshToken ?? '',
          //   );
          //   AppNavigator.remove(const MainHomeScreen());
          // }
          //  if (state is SocialLoginFailureState) {
          //       AppToast.error(state.message);
          //     } else

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
                          30.verticalSpace,
                          AuthLogo(logo: AppIcons.loginPhoneImage),
                          16.verticalSpace,

                          AuthHeaderWidget(
                            title: "auth.login.title".tr(),
                            // subtitle: "auth.login.subtitle".tr(),
                          ),

                          24.verticalSpace,
                          CustomFieldPhone(
                            controller: _phoneController,
                            initialCountryCode: 'SA',
                            onCountryChanged: (v) {
                              setState(() {
                                _Code = v.dialCode;
                              });
                            },

                            title: "auth.login.phone.title".tr(),
                            hintText: "auth.login.phone.title".tr(),
                            showRequiredIndicator: true,
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
                                AppNavigator.push(const LoginEmailScreen());
                              },
                              child: Text(
                                "auth.login.login_with_email".tr(),
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
