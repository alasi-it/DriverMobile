import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';
import 'package:isnad_worker/core/utils/widgets/layout/status_badge_widget.dart';
import 'package:isnad_worker/features/home/data/models/order_card_model.dart';

class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({super.key, required this.order});

  final OrderCardModel order;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: order.onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: AppContainer(
          borderRadius: BorderRadius.circular(20.r),
          padding: EdgeInsets.all(16.w),
          border: BorderDirectional(
            start: BorderSide(color: order.status.color, width: 4.w),
          ),

          child: Column(
            spacing: 12.h,
            children: [
              _Header(order: order),
              Row(
                children: [
                  Expanded(
                    child: _InfoChip(
                      icon: Icons.calendar_today_outlined,
                      label: order.dateLabel,
                    ),
                  ),
                  Expanded(
                    child: _InfoChip(
                      icon: Icons.access_time_rounded,
                      label: order.timeLabel,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.directions_bus_filled_outlined,
                    size: 18.sp,
                    color: AppColors.typographySubtitle,
                  ),
                  SizedBox(width: 6.w),

                  Flexible(
                    child: Text(
                      '${order.vehicleType}, ${order.plateNumber}',
                      style: AppTextStyles.font13Regular.copyWith(
                        color: AppColors.typographyBody,
                      ),
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 12.w,
                children: [
                  Expanded(
                    child: _StatBox(
                      value: order.passengersCount.toString(),
                      labelKey: 'home.order_card.passengers',
                      backgroundColor: AppColors.primarySurface,
                      valueColor: AppColors.primaryText,
                    ),
                  ),
                  Expanded(
                    child: _StatBox(
                      value: order.requestsCount.toString(),
                      labelKey: 'home.order_card.requests',
                      backgroundColor: AppColors.neutralSurface.withOpacity(
                        0.5,
                      ),
                      valueColor: AppColors.typographyHeading,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    order.description,
                    style: AppTextStyles.font13Regular.copyWith(
                      color: AppColors.typographySubtitle,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              Divider(height: 1.h, color: AppColors.divider),
              _OrderTimeline(steps: order.steps),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.order});

  final OrderCardModel order;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                order.orderId,
                style: AppTextStyles.font16Bold.copyWith(
                  color: AppColors.typographyHeading,
                ),
              ),
              Text(
                order.tripType,
                style: AppTextStyles.font12Regular.copyWith(
                  color: AppColors.typographySubtitle,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        StatusBadgeWidget(
          color: order.status.color,
          labelKey: order.status.labelKey,
        ),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 6.w,
      children: [
        Icon(icon, size: 16.sp, color: AppColors.typographySubtitle),
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            style: AppTextStyles.font13Regular.copyWith(
              color: AppColors.typographyBody,
            ),
          ),
        ),
      ],
    );
  }
}

class _StatBox extends StatelessWidget {
  const _StatBox({
    required this.value,
    required this.labelKey,
    required this.backgroundColor,
    required this.valueColor,
  });

  final String value;
  final String labelKey;
  final Color backgroundColor;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      color: backgroundColor,
      boxShadow: [],
      borderRadius: BorderRadius.circular(14.r),
      child: Column(
        spacing: 2.h,
        children: [
          Text(
            value,
            style: AppTextStyles.font18Bold.copyWith(color: valueColor),
          ),
          Text(
            labelKey.tr(),
            style: AppTextStyles.font12Regular.copyWith(
              color: AppColors.typographySubtitle,
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderTimeline extends StatelessWidget {
  const _OrderTimeline({required this.steps});

  final List<OrderTimelineStepModel> steps;

  @override
  Widget build(BuildContext context) {
    if (steps.isEmpty) return const SizedBox.shrink();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var index = 0; index < steps.length; index++) ...[
          _StepNode(step: steps[index]),
          if (index != steps.length - 1)
            Expanded(
              child: _StepConnector(isCompleted: steps[index + 1].isCompleted),
            ),
        ],
      ],
    );
  }
}

class _StepNode extends StatelessWidget {
  const _StepNode({required this.step});

  final OrderTimelineStepModel step;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _StepDot(isCompleted: step.isCompleted),
        SizedBox(height: 8.h),
        Text(
          step.labelKey.tr(),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.font10Regular.copyWith(
            color: step.isCompleted
                ? AppColors.typographyBody
                : AppColors.typographySubtitle,
          ),
        ),
      ],
    );
  }
}

class _StepDot extends StatelessWidget {
  const _StepDot({required this.isCompleted});

  final bool isCompleted;

  static double get _boxSize => 22.w;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _boxSize,
      height: _boxSize,
      child: Center(
        child: AppContainer(
          width: 22.w,
          height: 22.h,
          alignment: Alignment.center,
          padding: EdgeInsets.zero,
          shape: BoxShape.circle,
          color: AppColors.cardBackground,
          border: Border.all(
            color: isCompleted ? AppColors.primary700 : AppColors.border,
            width: 2.w,
          ),
          child: AppContainer(
            width: 16.w,
            height: 16.h,
            shape: BoxShape.circle,
            color: isCompleted ? AppColors.primary700 : AppColors.border,
          ),
        ),
      ),
    );
  }
}

class _StepConnector extends StatelessWidget {
  const _StepConnector({required this.isCompleted});

  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 22.w,
      child: CustomPaint(
        size: Size.infinite,
        painter: _DottedLinePainter(
          color: isCompleted ? AppColors.primary700 : AppColors.border,
          dotRadius: 1.3.w,
          gap: 5.w,
        ),
      ),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  _DottedLinePainter({
    required this.color,
    required this.dotRadius,
    required this.gap,
  });

  final Color color;
  final double dotRadius;
  final double gap;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final y = size.height / 2;
    for (double x = dotRadius; x <= size.width - dotRadius; x += gap) {
      canvas.drawCircle(Offset(x, y), dotRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _DottedLinePainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.dotRadius != dotRadius ||
      oldDelegate.gap != gap;
}
