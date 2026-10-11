// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:isnad_worker/core/utils/widgets/layout/segmented_tab_widget.dart';

// class TabBarContentWidget extends StatefulWidget {
//   const TabBarContentWidget({
//     super.key,
//     required this.tabs,
//     required this.children,
//     this.initialIndex = 0,
//     this.onTabChanged,
//   }) : assert(tabs.length == children.length);

//   final List<String> tabs;
//   final List<Widget> children;
//   final int initialIndex;
//   final ValueChanged<int>? onTabChanged;

//   @override
//   State<TabBarContentWidget> createState() => _TabBarContentWidgetState();
// }

// class _TabBarContentWidgetState extends State<TabBarContentWidget> {
//   late int _selectedIndex;

//   @override
//   void initState() {
//     super.initState();
//     _selectedIndex = widget.initialIndex;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SegmentedTabWidget(
//           tabs: widget.tabs,
//           selectedIndex: _selectedIndex,
//           onTabChanged: (index) {
//             setState(() => _selectedIndex = index);
//             widget.onTabChanged?.call(index);
//           },
//         ),
//         16.verticalSpace,
//         Expanded(
//           child: IndexedStack(index: _selectedIndex, children: widget.children),
//         ),
//       ],
//     );
//   }
// }
