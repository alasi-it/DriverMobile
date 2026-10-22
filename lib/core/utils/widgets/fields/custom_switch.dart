import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/app_colors.dart';

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({super.key, this.initialValue = false, this.onChange});

  final bool initialValue;
  final Function(bool)? onChange;

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  late bool value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  void _toggle() {
    setState(() {
      value = !value;
    });

    if (widget.onChange != null) {
      widget.onChange!(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color activeTrack = AppColors.primary;
    final Color inactiveTrack = AppColors.neutralSurface;
    const Color thumbColor = Colors.white;

    return GestureDetector(
      onTap: widget.onChange != null ? _toggle : _toggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: 44.w,
        height: 24.h,
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.r),
          color: value ? activeTrack : inactiveTrack,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          alignment: value
              ? AlignmentDirectional.centerEnd
              : AlignmentDirectional.centerStart,
          child: Container(
            width: 22.w,
            height: 22.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: thumbColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
