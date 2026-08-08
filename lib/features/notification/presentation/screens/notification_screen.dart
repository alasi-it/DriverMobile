import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:isnad_worker/core/utils/widgets/layout/custom_app_bar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: 'notifications.title'.tr()));
  }
}
