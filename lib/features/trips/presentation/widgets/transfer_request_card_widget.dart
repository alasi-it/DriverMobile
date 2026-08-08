import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/constant/app_assets.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/widgets/images/custom_svg.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';
import 'package:isnad_worker/features/trips/data/models/transfer_request_model.dart';

class TransferRequestCardWidget extends StatelessWidget {
  const TransferRequestCardWidget({super.key, required this.request});

  final TransferRequestModel request;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      padding: EdgeInsets.all(16.w),
      borderRadius: BorderRadius.circular(20.r),
      border: BorderDirectional(
        start: BorderSide(color: request.status.color, width: 4.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(request: request),
          SizedBox(height: 16.h),
          Divider(height: 1.h, color: AppColors.grey50),
          SizedBox(height: 16.h),
          _RouteAddresses(request: request),
          SizedBox(height: 16.h),
          const _RouteConnector(),
          SizedBox(height: 16.h),
          _RouteContacts(request: request),
          SizedBox(height: 16.h),
          Divider(height: 1.h, color: AppColors.grey50),
          SizedBox(height: 16.h),
          _Actions(request: request),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.request});

  final TransferRequestModel request;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SequenceBadge(
              number: request.sequenceNumber,
              color: request.status.color,
            ),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  request.orderId,
                  style: AppTextStyles.font16Bold.copyWith(
                    color: AppColors.typographyHeading,
                  ),
                ),
                Text(
                  request.subtitleLabel,
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.typographySubtitle,
                  ),
                ),
              ],
            ),
          ],
        ),
        _StatusPill(status: request.status),
      ],
    );
  }
}

class _SequenceBadge extends StatelessWidget {
  const _SequenceBadge({required this.number, required this.color});

  final int number;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32.w,
      height: 32.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Text(
        number.toString(),
        style: AppTextStyles.font16Bold.copyWith(color: AppColors.white),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.status});

  final TransferRequestStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: status.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(
          color: status.color.withValues(alpha: 0.4),
          width: 1.w,
        ),
      ),
      child: Text(
        status.labelKey.tr(),
        style: AppTextStyles.font12SemiBold.copyWith(color: status.color),
      ),
    );
  }
}

class _RouteAddresses extends StatelessWidget {
  const _RouteAddresses({required this.request});

  final TransferRequestModel request;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            request.pickupLocationName,
            textAlign: TextAlign.start,
            style: AppTextStyles.font14Bold.copyWith(
              color: AppColors.typographyHeading,
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Text(
            request.destinationLocationName,
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

class _RouteConnector extends StatelessWidget {
  const _RouteConnector();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              const _RouteDot(),
              Expanded(
                child: CustomPaint(
                  size: Size(double.infinity, 2.h),
                  painter: _DashedLinePainter(color: AppColors.primary700),
                ),
              ),
              const _RouteDot(),
            ],
          ),
          CustomSvg(svg: AppIcons.carIcon, width: 24.w, height: 24.w),
        ],
      ),
    );
  }
}

class _RouteDot extends StatelessWidget {
  const _RouteDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10.w,
      height: 10.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary700,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary700.withValues(alpha: 0.4),
            blurRadius: 8.r,
            spreadRadius: 2.r,
          ),
        ],
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  _DashedLinePainter({required this.color});

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
      canvas.drawLine(
        Offset(x, y),
        Offset(x + _dashWidth, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DashedLinePainter oldDelegate) =>
      oldDelegate.color != color;
}

class _RouteContacts extends StatelessWidget {
  const _RouteContacts({required this.request});

  final TransferRequestModel request;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _ContactColumn(
            labelKey: 'trips.request_item.pickup_point',
            name: request.pickupContactName,
            phone: request.pickupContactPhone,
            alignment: CrossAxisAlignment.start,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: _ContactColumn(
            labelKey: 'trips.request_item.destination',
            name: request.destinationContactName,
            phone: request.destinationContactPhone,
            alignment: CrossAxisAlignment.end,
          ),
        ),
      ],
    );
  }
}

class _ContactColumn extends StatelessWidget {
  const _ContactColumn({
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
          style: AppTextStyles.font14Bold.copyWith(
            color: AppColors.primary700,
          ),
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

class _Actions extends StatelessWidget {
  const _Actions({required this.request});

  final TransferRequestModel request;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16.w,
      children: [
        Expanded(
          child: _ActionButton(
            labelKey: 'trips.request_item.confirm_delivery',
            icon: Icons.check_rounded,
            backgroundColor: AppColors.primary700,
            foregroundColor: AppColors.white,
            onTap: request.onConfirm,
          ),
        ),
        Expanded(
          child: _ActionButton(
            labelKey: 'trips.request_item.cancel_request',
            icon: Icons.close_rounded,
            backgroundColor: Colors.transparent,
            foregroundColor: AppColors.errorColor,
            borderColor: AppColors.errorColor,
            onTap: request.onCancel,
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.labelKey,
    required this.icon,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onTap,
    this.borderColor,
  });

  final String labelKey;
  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12.r),
            border: borderColor != null
                ? Border.all(color: borderColor!, width: 1.w)
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 6.w,
            children: [
              Text(
                labelKey.tr(),
                style: AppTextStyles.font14SemiBold.copyWith(
                  color: foregroundColor,
                ),
              ),
              Icon(icon, size: 18.sp, color: foregroundColor),
            ],
          ),
        ),
      ),
    );
  }
}
