import 'package:flutter/material.dart';
import 'package:money_tracker/views/plan_view.dart';
import 'package:money_tracker/views/profile_view.dart';
import 'package:money_tracker/views/category_view.dart';
import 'package:money_tracker/views/profits_view.dart';

class HomeScreen extends StatefulWidget {
  final List<BottomNavigationBarItem> items;
  const HomeScreen({super.key, required this.items});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.items.length, vsync: this);
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
        items: widget.items,
        unselectedItemColor: Colors.grey,
      ),
      body: TabBarView(
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
