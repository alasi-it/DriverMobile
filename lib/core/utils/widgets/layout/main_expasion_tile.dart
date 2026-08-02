import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:isnad_worker/core/constant/app_assets.dart';

class MainExpansionTile extends StatefulWidget {
  final String title;
  final List<Widget>? children;
  final bool enabled;
  final Widget? leading;
  final Color backgroundColor;
  final bool initiallyExpanded;

  const MainExpansionTile({
    super.key,
    required this.title,
    this.children,
    this.enabled = true,
    this.leading,
    this.backgroundColor = Colors.transparent,
    this.initiallyExpanded = false,
  });

  @override
  State<MainExpansionTile> createState() => _MainExpansionTileState();
}

class _MainExpansionTileState extends State<MainExpansionTile> {
  late bool isExpanded;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.initiallyExpanded;
  }

  bool get hasChildren =>
      widget.children != null && widget.children!.isNotEmpty;

  void toggle() {
    if (!widget.enabled || !hasChildren) return;
    setState(() => isExpanded = !isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(12.r),
          child: InkWell(
            onTap: toggle,
            borderRadius: BorderRadius.circular(12.r),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
              child: Row(
                children: [
                  if (hasChildren)
                    Expanded(
                      child: Text(
                        widget.title,

                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: SvgPicture.asset(AppIcons.dropDownIcon),
                  ),
                ],
              ),
            ),
          ),
        ),

        if (hasChildren && isExpanded)
          Padding(
            padding: EdgeInsetsDirectional.only(start: 8.w),
            child: Column(children: widget.children!),
          ),
      ],
    );
  }
}
