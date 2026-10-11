import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/constant/app_assets.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/widgets/images/custom_svg.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';
import 'package:isnad_worker/core/utils/widgets/layout/status_badge_widget.dart';

class RequestCardHeader extends StatelessWidget {
  const RequestCardHeader({
    super.key,
    required this.orderId,
    required this.sequenceNumber,
    required this.subtitleLabel,
    required this.badgeColor,
    required this.badgeLabelKey,
  });

  final String orderId;
  final int sequenceNumber;
  final String subtitleLabel;
  final Color badgeColor;
  final String badgeLabelKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SequenceBadge(number: sequenceNumber, color: badgeColor),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderId,
                  style: AppTextStyles.font16Bold.copyWith(
                    color: AppColors.typographyHeading,
                  ),
                ),
                Text(
                  subtitleLabel,
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.typographySubtitle,
                  ),
                ),
              ],
            ),
          ],
        ),
        StatusBadgeWidget(color: badgeColor, labelKey: badgeLabelKey),
      ],
    );
  }
}

class SequenceBadge extends StatelessWidget {
  const SequenceBadge({super.key, required this.number, required this.color});

  final int number;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      width: 32.w,
      height: 32.w,
      alignment: Alignment.center,
      padding: EdgeInsets.zero,
      shape: BoxShape.circle,
      color: color,
      child: Text(
        number.toString(),
        style: AppTextStyles.font16Bold.copyWith(color: AppColors.white),
      ),
    );
  }
}

class RouteAddressesRow extends StatelessWidget {
  const RouteAddressesRow({
    super.key,
    required this.pickupLocationName,
    required this.destinationLocationName,
  });

  final String pickupLocationName;
  final String destinationLocationName;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            pickupLocationName,
            textAlign: TextAlign.start,
            style: AppTextStyles.font14Bold.copyWith(
              color: AppColors.typographyHeading,
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Text(
            destinationLocationName,
            textAlign: TextAlign.end,
            style: AppTextStyles.font14Bold.copyWith(
              color: AppColors.typographyHeading,
            ),
          ),
        ),
      ],
    );
  }
}

class RouteConnector extends StatelessWidget {
  const RouteConnector({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              const RouteDot(),
              Expanded(
                child: CustomPaint(
                  size: Size(double.infinity, 2.h),
                  painter: DashedLinePainter(color: AppColors.primary700),
                ),
              ),
              const RouteDot(),
            ],
          ),
          CustomSvg(svg: AppIcons.carIcon, width: 24.w, height: 24.w),
        ],
      ),
    );
  }
}

class RouteDot extends StatelessWidget {
  const RouteDot({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      width: 10.w,
      height: 10.w,
      shape: BoxShape.circle,
      color: AppColors.primary700,
      boxShadow: [
        // BoxShadow(
        //   color: AppColors.primary700.withValues(alpha: 0.4),
        //   blurRadius: 8.r,
        //   spreadRadius: 2.r,
        // ),
      ],
    );
  }
}

class DashedLinePainter extends CustomPainter {
  DashedLinePainter({required this.color});

  final Color color;

  static const double _dashWidth = 6;
  static const double _dashSpace = 5;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final y = size.height / 2;
    for (double x = 0; x < size.width; x += _dashWidth + _dashSpace) {
      canvas.drawLine(Offset(x, y), Offset(x + _dashWidth, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant DashedLinePainter oldDelegate) =>
      oldDelegate.color != color;
}

class RouteContactsRow extends StatelessWidget {
  const RouteContactsRow({
    super.key,
    required this.pickupContactName,
    required this.pickupContactPhone,
    required this.destinationContactName,
    required this.destinationContactPhone,
  });

  final String pickupContactName;
  final String pickupContactPhone;
  final String destinationContactName;
  final String destinationContactPhone;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ContactColumn(
            labelKey: 'trips.request_item.pickup_point',
            name: pickupContactName,
            phone: pickupContactPhone,
            alignment: CrossAxisAlignment.start,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: ContactColumn(
            labelKey: 'trips.request_item.destination',
            name: destinationContactName,
            phone: destinationContactPhone,
            alignment: CrossAxisAlignment.end,
          ),
        ),
      ],
    );
  }
}

class ContactColumn extends StatelessWidget {
  const ContactColumn({
    super.key,
    required this.labelKey,
    required this.name,
    required this.phone,
    required this.alignment,
  });

  final String labelKey;
  final String name;
  final String phone;
  final CrossAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    final textAlign = alignment == CrossAxisAlignment.start
        ? TextAlign.start
        : TextAlign.end;
    return Column(
      crossAxisAlignment: alignment,
      spacing: 4.h,
      children: [
        Text(
          labelKey.tr(),
          textAlign: textAlign,
          style: AppTextStyles.font12Regular.copyWith(
            color: AppColors.typographySubtitle,
          ),
        ),
        Text(
          name,
          textAlign: textAlign,
          style: AppTextStyles.font14Bold.copyWith(color: AppColors.primary700),
        ),
        Text(
          phone,
          textAlign: textAlign,
          style: AppTextStyles.font13Regular.copyWith(
            color: AppColors.typographyBody,
          ),
        ),
      ],
    );
  }
}
