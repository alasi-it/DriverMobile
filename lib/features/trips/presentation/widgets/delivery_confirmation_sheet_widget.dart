import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/app_dimensions.dart';
import 'package:isnad_worker/core/utils/widgets/buttons/custom_button.dart';
import 'package:isnad_worker/core/utils/widgets/fields/custom_field_text.dart';
import 'package:isnad_worker/core/utils/widgets/layout/custom_divider_widget.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';
import 'package:isnad_worker/features/trips/presentation/widgets/delivery_confirmation_sheet_widgets.dart';

class DeliveryConfirmationSheetWidget extends StatelessWidget {
  const DeliveryConfirmationSheetWidget({super.key, required this.orderId});

  final String orderId;

  static Future<void> show(BuildContext context, {required String orderId}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => DeliveryConfirmationSheetWidget(orderId: orderId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _DeliveryConfirmationSheetView(orderId: orderId);
  }
}

class _DeliveryConfirmationSheetView extends StatefulWidget {
  const _DeliveryConfirmationSheetView({required this.orderId});

  final String orderId;

  @override
  State<_DeliveryConfirmationSheetView> createState() =>
      _DeliveryConfirmationSheetViewState();
}

class _DeliveryConfirmationSheetViewState
    extends State<_DeliveryConfirmationSheetView> {
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  bool _isConfirmed = false;

  @override
  void dispose() {
    _otpController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppContainer(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: 16.h,
          bottom: 16.h + MediaQuery.of(context).viewInsets.bottom,
        ),
        boxShadow: [AppDimensions.sheetShadow],
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16.h,
            children: [
              DeliverySheetHeaderRow(orderId: widget.orderId),
              CustomDivider(),
              if (_isConfirmed)
                const DeliveryConfirmationSuccessView()
              else ...[
                OtpVerificationSection(
                  controller: _otpController,
                  onCompleted: () {},
                ),
                CustomFieldText(
                  title: 'trips.delivery_sheet.notes_title'.tr(),
                  controller: _notesController,
                  minLines: 2,
                  hintText: 'trips.delivery_sheet.notes_hint'.tr(),
                ),
                CustomButton(
                  title: 'trips.delivery_sheet.confirm_button'.tr(),
                  onTap: () => setState(() => _isConfirmed = true),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
