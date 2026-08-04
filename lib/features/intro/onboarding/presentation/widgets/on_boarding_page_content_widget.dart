import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/constant/app_assets.dart';
import 'package:isnad_worker/features/intro/onboarding/presentation/screens/on_boarding_info.dart';
import 'package:isnad_worker/features/intro/onboarding/presentation/widgets/on_boarding_text_content_widget.dart';

class OnBoardingPageContentWidget extends StatelessWidget {
  final OnBoardingInfo item;
  final int index;
  final int itemsCount;

  const OnBoardingPageContentWidget({
    super.key,
    required this.item,
    required this.index,
    required this.itemsCount,
  });

  @override
  Widget build(BuildContext context) {
    final isFirst = index == 0;
    final isLast = index == itemsCount - 1;
    final isEdge = isFirst || isLast;

    final imageTop = MediaQuery.of(context).padding.top + 60.h;

    final image = Image(
      image: AssetImage(item.image),

      height: isEdge ? 340 : 340.h,
    );

    return Stack(
      fit: StackFit.expand,
      children: [
        Image(image: AssetImage(AppImages.splashBackground), fit: BoxFit.fill),

        PositionedDirectional(
          top: imageTop,
          start: isLast ? null : 0,
          end: isFirst ? null : 0,
          child: isEdge ? image : Center(child: image),
        ),
        PositionedDirectional(
          bottom: MediaQuery.of(context).padding.bottom + 150.h,
          start: 16.w,
          end: 16.w,
          child: OnBoardingTextContentWidget(item: item),
        ),
      ],
    );
  }
}
