import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/app_dimensions.dart';
import 'package:isnad_worker/core/utils/widgets/buttons/custom_button.dart';
import 'package:isnad_worker/core/utils/widgets/fields/custom_field_text.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_bottom_navigation_bar.dart';
import 'package:isnad_worker/core/utils/widgets/layout/custom_app_bar.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'profile.contact_us'.tr()),
      bottomNavigationBar: AppBottomActionBar(
        child: CustomButton(title: 'contact_us.send'.tr()),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.symmetric(),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 24.h,
            children: [
              CustomFieldText(
                title: 'contact_us.full_name'.tr(),
                hintText: 'contact_us.full_name_hint'.tr(),
                controller: _nameController,
                validator: (v) => v!.trim().isEmpty
                    ? 'contact_us.full_name_required'.tr()
                    : null,
              ),
              CustomFieldText(
                title: 'contact_us.email'.tr(),
                hintText: 'contact_us.email_hint'.tr(),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'contact_us.email_required'.tr();
                  }
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(v.trim())) {
                    return 'contact_us.email_invalid'.tr();
                  }
                  return null;
                },
              ),
              CustomFieldText(
                title: 'contact_us.phone'.tr(),
                hintText: 'contact_us.phone_hint'.tr(),
                controller: _phoneController,
                keyboardType: TextInputType.phone,
              ),
              CustomFieldText(
                title: 'contact_us.subject'.tr(),
                hintText: 'contact_us.subject_hint'.tr(),
                controller: _subjectController,
                validator: (v) => v!.trim().isEmpty
                    ? 'contact_us.subject_required'.tr()
                    : null,
              ),
              CustomFieldText(
                title: 'contact_us.message'.tr(),
                hintText: 'contact_us.message_hint'.tr(),
                controller: _messageController,
                minLines: 5,
                maxLines: 8,
                validator: (v) => v!.trim().isEmpty
                    ? 'contact_us.message_required'.tr()
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
