import 'package:flutter/material.dart';
import 'package:isnad_worker/core/style/app_colors.dart';

enum TripHistoryStatus { completed, partiallyCompleted, cancelled }

extension TripHistoryStatusX on TripHistoryStatus {
  String get labelKey {
    switch (this) {
      case TripHistoryStatus.completed:
        return 'trips_history.card.status.completed';
      case TripHistoryStatus.partiallyCompleted:
        return 'trips_history.card.status.partially_completed';
      case TripHistoryStatus.cancelled:
        return 'trips_history.card.status.cancelled';
    }
  }

  Color get color {
    switch (this) {
      case TripHistoryStatus.completed:
        return AppColors.green700;
      case TripHistoryStatus.partiallyCompleted:
        return AppColors.warning2Color;
      case TripHistoryStatus.cancelled:
        return AppColors.errorColor;
    }
  }
}

class TripHistoryModel {
  const TripHistoryModel({
    required this.orderId,
    required this.status,
    required this.tripType,
    required this.dateLabel,
    required this.timeLabel,
    required this.vehicleType,
    required this.plateNumber,
    required this.requestsCount,
    required this.passengersCount,
    required this.completedRequestsCount,
    this.onTap,
  });

  final String orderId;
  final TripHistoryStatus status;
  final String tripType;
  final String dateLabel;
  final String timeLabel;
  final String vehicleType;
  final String plateNumber;
  final int requestsCount;
  final int passengersCount;
  final int completedRequestsCount;
  final VoidCallback? onTap;
}
