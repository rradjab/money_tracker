import 'package:flutter/material.dart';
import 'package:money_tracker/generated/l10n.dart';
import 'package:money_tracker/views/plans/plan_view.dart';
import 'package:money_tracker/views/profile/profile_view.dart';
import 'package:money_tracker/views/spends/spend_category_view.dart';
import 'package:money_tracker/views/profits/profit_category_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;

  final List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: const Icon(Icons.credit_card),
      label: S.current.homeSpends,
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.monetization_on),
      label: S.current.homeProfits,
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.place_outlined),
      label: S.current.homePlans,
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.person),
      label: S.current.homeProfile,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: items.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (currentIndex) {
          _tabController.index = currentIndex;
          setState(() {
            _currentTabIndex = currentIndex;
            _tabController.animateTo(_currentTabIndex);
          });
        },
        selectedItemColor: Colors.blue,
        showSelectedLabels: true,
        currentIndex: _currentTabIndex,
        items: items,
        unselectedItemColor: Colors.grey,
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: const [
          CategoryWidget(),
          ProfitWidget(),
          PlanWidget(),
          ProfileWidget(),
        ],
      ),
    );
  }
}
