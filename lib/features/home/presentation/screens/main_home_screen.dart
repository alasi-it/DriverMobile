// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:isnad_customer/features/home/presentation/screens/home_screen.dart';
// import 'package:isnad_customer/features/my_orders/presentation/screens/my_orders_screen.dart';
// import 'package:isnad_customer/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';
// import 'package:isnad_customer/features/profile/presentation/screens/profile_screen/profile_screen.dart';
// import 'package:isnad_customer/features/services/presentation/screens/services_screen.dart';

// import '/features/home/presentation/widgets/nav_bar.dart';

// class MainHomeScreen extends StatefulWidget {
//   const MainHomeScreen({super.key});

//   @override
//   State<MainHomeScreen> createState() => _MainHomeScreenState();
// }

// class _MainHomeScreenState extends State<MainHomeScreen> {
//   int _selectedIndex = 0;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     context.read<ProfileCubit>().getProfile();
//   }

//   final List<Widget> _screens = [
//     HomeScreen(),
//     MyOrdersScreen(),
//     ServicesScreen(),

//     ProfileScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       onPopInvokedWithResult: (didPop, result) {
//         if (_selectedIndex != 0) {
//           setState(() => _selectedIndex = 0);
//         } else {
//           SystemNavigator.pop();
//         }
//       },
//       child: Scaffold(
//         body: _screens[_selectedIndex],
//         bottomNavigationBar: CustomBottomNavBar(
//           selectedIndex: _selectedIndex,
//           onItemTapped: (index) {
//             setState(() => _selectedIndex = index);
//           },
//         ),
//       ),
//     );
//   }
// }
