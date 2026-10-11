import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/app_dimensions.dart';
import 'package:isnad_worker/core/utils/validators/app_validators.dart';
import 'package:isnad_worker/core/utils/widgets/buttons/custom_button.dart';
import 'package:isnad_worker/core/utils/widgets/fields/custom_field_text.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_bottom_navigation_bar.dart';
import 'package:isnad_worker/core/utils/widgets/layout/custom_app_bar.dart';

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({super.key});

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _newpasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();

  bool obscureOldPassword = true;
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;

  void toggleOldPassword() {
    setState(() {
      obscureOldPassword = !obscureOldPassword;
    });
  }

  void toggleNewPassword() {
    setState(() {
      obscureNewPassword = !obscureNewPassword;
    });
  }

  void toggleConfirmPassword() {
    setState(() {
      obscureConfirmPassword = !obscureConfirmPassword;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _newpasswordController.dispose();
    _confirmPasswordController.dispose();
    _oldPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'profile.change_password'.tr()),
      bottomNavigationBar: AppBottomActionBar(
        child: CustomButton(title: 'profile.save_changes'.tr(), onTap: () {}),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.symmetric(),
        child: Form(
          key: formKey,
          child: Column(
            spacing: 16.h,
            children: [
              CustomFieldText(
                controller: _oldPasswordController,
                keyboardType: TextInputType.visiblePassword,
                isPassword: true,
                obscurePassword: obscureOldPassword,
                onTogglePassword: toggleOldPassword,
                obscureText: true,
                validator: (value) => AppValidators.password(value),
                helperText: 'profile.current_password'.tr(),

                labelText: 'profile.current_password'.tr(),
                title: 'profile.current_password'.tr(),
              ),

              CustomFieldText(
                keyboardType: TextInputType.visiblePassword,

                controller: _newpasswordController,
                obscureText: true,
                isPassword: true,
                obscurePassword: obscureNewPassword,
                onTogglePassword: toggleNewPassword,
                validator: (value) => AppValidators.password(value),

                helperText: "profile.new_password".tr(),
                hintText: "profile.new_password".tr(),
                title: "profile.new_password".tr(),
              ),
              CustomFieldText(
                keyboardType: TextInputType.visiblePassword,

                controller: _confirmPasswordController,
                isPassword: true,
                obscurePassword: obscureConfirmPassword,
                onTogglePassword: toggleConfirmPassword,

                validator: (value) => AppValidators.passwordIdentical(
                  value,
                  _newpasswordController.text,
                ),

                helperText: 'profile.confirm_new_password'.tr(),
                labelText: 'profile.confirm_new_password'.tr(),
                title: 'profile.confirm_new_password'.tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
