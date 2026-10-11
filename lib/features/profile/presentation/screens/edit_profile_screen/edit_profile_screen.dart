import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/utils/validators/app_validators.dart';
import 'package:isnad_worker/core/utils/widgets/buttons/custom_button.dart';
import 'package:isnad_worker/core/utils/widgets/fields/custom_field_dropdown.dart';
import 'package:isnad_worker/core/utils/widgets/fields/custom_field_phone.dart';
import 'package:isnad_worker/core/utils/widgets/fields/custom_field_text.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_bottom_navigation_bar.dart';
import 'package:isnad_worker/core/utils/widgets/layout/custom_app_bar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String _code = '+20';
  String _initCountry = 'Eg';
  int? _selectedGender;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _idController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(title: 'profile.edit_data'.tr()),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                top: 16.h,
                bottom: 16.h,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomFieldText(
                      validator: (value) => AppValidators.name(value),
                      helperText: 'profile.full_name'.tr(),
                      labelText: 'profile.full_name'.tr(),
                      title: 'profile.full_name'.tr(),
                      controller: _fullNameController,
                    ),
                    SizedBox(height: 16.h),

                    CustomFieldText(
                      helperText: 'auth.login.id'.tr(),
                      labelText: 'auth.login.id'.tr(),
                      validator: (value) => AppValidators.nationalId(value),
                      title: 'auth.login.id'.tr(),
                      controller: _idController,
                    ),
                    SizedBox(height: 16.h),

                    CustomFieldPhone(
                      controller: _phoneController,
                      hintText: "profile.phone".tr(),
                      title: "profile.phone".tr(),
                      enabled: false,
                      initialCountryCode: _initCountry,
                    ),
                    SizedBox(height: 16.h),

                    CustomFieldText(
                      helperText: 'profile.email'.tr(),
                      labelText: 'profile.email'.tr(),
                      title: 'profile.email'.tr(),
                      controller: _emailController,
                      enabled: false,
                    ),
                    SizedBox(height: 16.h),

                    CustomFieldDropdown<int>(
                      title: 'auth.register.gender'.tr(),
                      hintText: 'auth.register.gender_hint'.tr(),
                      selected: _selectedGender,
                      onChanged: (value) =>
                          setState(() => _selectedGender = value),
                      items: [
                        DropdownItem(
                          id: 0,
                          label: 'auth.register.gender_male'.tr(),
                        ),
                        DropdownItem(
                          id: 1,
                          label: 'auth.register.gender_female'.tr(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          AppBottomActionBar(
            child: CustomButton(
              title: 'profile.save_changes'.tr(),

              onTap: () {
                FocusScope.of(context).unfocus();
                if (_formKey.currentState!.validate()) {}
              },
            ),
          ),

          // SizedBox(height: bottomInset),
        ],
      ),
    );
  }
}
