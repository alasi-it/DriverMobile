import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/widgets/fields/custom_switch.dart';

class ProfileNotificationTileWidget extends StatefulWidget {
  const ProfileNotificationTileWidget({
    super.key,
    required this.svgAsset,
    required this.title,
    required this.initialValue,
  });

  final String svgAsset;
  final String title;
  final bool initialValue;

  @override
  State<ProfileNotificationTileWidget> createState() =>
      _ProfileNotificationTileWidgetState();
}

class _ProfileNotificationTileWidgetState
    extends State<ProfileNotificationTileWidget> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          SvgPicture.asset(widget.svgAsset),
          12.horizontalSpace,

          Expanded(
            child: Text(widget.title, style: AppTextStyles.font16Medium),
          ),
          CustomSwitch(initialValue: _value, onChange: (v) {}),
        ],
      ),
    );
  }
}
