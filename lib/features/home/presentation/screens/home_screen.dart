import 'package:flutter/material.dart';
import 'package:isnad_worker/core/routing/app_navigator.dart';
import 'package:isnad_worker/features/home/data/models/order_card_model.dart';
import 'package:isnad_worker/features/home/presentation/widgets/home_topbar_widget.dart';
import 'package:isnad_worker/features/home/presentation/widgets/orders_list_view.dart';
import 'package:isnad_worker/features/trips/presentation/screens/trip_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // TODO: replace with orders coming from the home cubit/API once available.
  static final List<OrderCardModel> _mockOrders = [
    OrderCardModel(
      orderId: 'ORD-123456',
      status: OrderStatus.active,
      tripType: 'متعددة المحطات',
      dateLabel: '04 أغسطس, 2026',
      onTap: () {
        AppNavigator.push(TripDetailsScreen());
      },
      timeLabel: '01:45 م',
      vehicleType: 'حافلة',
      plateNumber: '123 أ ب ج',
      requestsCount: 6,
      passengersCount: 38,
      description: 'نقل موظفي الإدارة للمكتب الرئيسي',
      steps: const [
        OrderTimelineStepModel(
          labelKey: 'home.order_card.timeline.shipped',
          isCompleted: true,
        ),
        OrderTimelineStepModel(
          labelKey: 'home.order_card.timeline.loaded',
          isCompleted: true,
        ),
        OrderTimelineStepModel(
          labelKey: 'home.order_card.timeline.on_the_way',
          isCompleted: true,
        ),
        OrderTimelineStepModel(
          labelKey: 'home.order_card.timeline.arrived',
          isCompleted: false,
        ),
      ],
    ),
    OrderCardModel(
      orderId: 'ORD-123457',
      status: OrderStatus.pending,
      tripType: 'محطة واحدة',
      dateLabel: '05 أغسطس, 2026',
      timeLabel: '09:00 ص',
      vehicleType: 'ميكروباص',
      plateNumber: '456 د هـ و',
      requestsCount: 2,
      passengersCount: 14,
      description: 'نقل عمالة إلى موقع المشروع',
      steps: const [
        OrderTimelineStepModel(
          labelKey: 'home.order_card.timeline.shipped',
          isCompleted: true,
        ),
        OrderTimelineStepModel(
          labelKey: 'home.order_card.timeline.loaded',
          isCompleted: false,
        ),
        OrderTimelineStepModel(
          labelKey: 'home.order_card.timeline.on_the_way',
          isCompleted: false,
        ),
        OrderTimelineStepModel(
          labelKey: 'home.order_card.timeline.arrived',
          isCompleted: false,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HomeTopBarWidget(),
          Expanded(child: OrdersListView(orders: _mockOrders)),
        ],
      ),
    );
  }
}
