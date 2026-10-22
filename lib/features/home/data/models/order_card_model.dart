import 'package:flutter/material.dart';
import 'package:isnad_worker/core/style/app_colors.dart';

enum OrderStatus { active, pending, completed, cancelled }

extension OrderStatusX on OrderStatus {
  String get labelKey {
    switch (this) {
      case OrderStatus.active:
        return 'home.order_card.status.active';
      case OrderStatus.pending:
        return 'home.order_card.status.pending';
      case OrderStatus.completed:
        return 'home.order_card.status.completed';
      case OrderStatus.cancelled:
        return 'home.order_card.status.cancelled';
    }
  }

  Color get color {
    switch (this) {
      case OrderStatus.active:
        return AppColors.successForeground;
      case OrderStatus.pending:
        return AppColors.warning2Color;
      case OrderStatus.completed:
        return AppColors.primary700;
      case OrderStatus.cancelled:
        return AppColors.errorForeground;
    }
  }
}

/// A single step in the order's progress timeline (e.g. shipped -> loaded -> on the way -> arrived).
class OrderTimelineStepModel {
  const OrderTimelineStepModel({
    required this.labelKey,
    required this.isCompleted,
  });

  final String labelKey;
  final bool isCompleted;
}

/// Data needed to render one order card. Steps must be ordered chronologically
/// (first = earliest step); the widget lays them out start-to-end so RTL/LTR
/// locales both read correctly.
class OrderCardModel {
  const OrderCardModel({
    required this.orderId,
    required this.status,
    required this.tripType,
    required this.dateLabel,
    required this.timeLabel,
    required this.vehicleType,
    required this.plateNumber,
    required this.requestsCount,
    required this.passengersCount,
    required this.description,
    required this.steps,
    this.onTap,
  });

  final String orderId;
  final OrderStatus status;
  final String tripType;
  final String dateLabel;
  final String timeLabel;
  final String vehicleType;
  final String plateNumber;
  final int requestsCount;
  final int passengersCount;
  final String description;
  final List<OrderTimelineStepModel> steps;
  final VoidCallback? onTap;
}
