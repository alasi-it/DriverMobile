import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/features/home/data/models/order_card_model.dart';
import 'package:isnad_worker/features/home/presentation/widgets/order_card_widget.dart';

/// Displays a set of [OrderCardModel]s as a separated, scrollable list.
/// Purely presentational — pass whatever data source (mock, cubit state, API) via [orders].
class OrdersListView extends StatelessWidget {
  const OrdersListView({
    super.key,
    required this.orders,
    this.padding,
    this.physics,
    this.shrinkWrap = false,
  });

  final List<OrderCardModel> orders;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      physics: physics,
      shrinkWrap: shrinkWrap,
      itemCount: orders.length,
      separatorBuilder: (_, _) => SizedBox(height: 14.h),
      itemBuilder: (context, index) => OrderCardWidget(order: orders[index]),
    );
  }
}
