import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isnad_worker/features/home/presentation/screens/home_screen.dart';
import 'package:isnad_worker/features/home/presentation/widgets/nav_bar.dart';
import 'package:isnad_worker/features/profile/presentation/screens/profile_screen/profile_screen.dart';
import 'package:isnad_worker/features/trips_history/presentation/screens/trips_histrory_screen.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key, this.initialIndex});
  final int? initialIndex;

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const TripsHistoryScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (_selectedIndex != 0) {
          setState(() => _selectedIndex = 0);
        } else {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                Expanded(
                  child: IndexedStack(
                    index: _selectedIndex,
                    children: _screens,
                  ),
                ),
              ],
            ),

            if (MediaQuery.of(context).viewInsets.bottom == 0)
              CustomBottomNavBar(
                selectedIndex: _selectedIndex,
                onItemTapped: (index) {
                  setState(() => _selectedIndex = index);
                },
              ),
          ],
        ),
      ),
    );
  }
}
