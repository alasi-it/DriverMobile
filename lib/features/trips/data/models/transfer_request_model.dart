import 'package:flutter/material.dart';
import 'package:isnad_worker/core/style/app_colors.dart';

enum TransferRequestStatus { unconfirmed, confirmed, cancelled }

extension TransferRequestStatusX on TransferRequestStatus {
  String get labelKey {
    switch (this) {
      case TransferRequestStatus.unconfirmed:
        return 'trips.request_item.status.unconfirmed';
      case TransferRequestStatus.confirmed:
        return 'trips.request_item.status.confirmed';
      case TransferRequestStatus.cancelled:
        return 'trips.request_item.status.cancelled';
    }
  }

  Color get color {
    switch (this) {
      case TransferRequestStatus.unconfirmed:
        return AppColors.warning2Color;
      case TransferRequestStatus.confirmed:
        return AppColors.successForeground;
      case TransferRequestStatus.cancelled:
        return AppColors.errorForeground;
    }
  }
}

class TransferRequestModel {
  const TransferRequestModel({
    required this.orderId,
    required this.sequenceNumber,
    required this.subtitleLabel,
    required this.status,
    required this.pickupLocationName,
    required this.pickupContactName,
    required this.pickupContactPhone,
    required this.destinationLocationName,
    required this.destinationContactName,
    required this.destinationContactPhone,
    this.onConfirm,
    this.onCancel,
  });

  final String orderId;
  final int sequenceNumber;
  final String subtitleLabel;
  final TransferRequestStatus status;
  final String pickupLocationName;
  final String pickupContactName;
  final String pickupContactPhone;
  final String destinationLocationName;
  final String destinationContactName;
  final String destinationContactPhone;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
}
