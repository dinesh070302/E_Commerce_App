import 'package:e_commerce_website/Tabs/home_tab.dart';
import 'package:e_commerce_website/Tabs/search_tab.dart';
import 'package:e_commerce_website/Widgets/bottom_tabs.dart';
import 'package:e_commerce_website/Tabs/saved_tab.dart';
import 'package:e_commerce_website/Tabs/search_tab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _tabsPageController;
  int _selectedTab = 0;

  @override
  void initState() {
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // int selectedIndex = 0;
    // final screens = [
    //   HomePage(),
    //   SearchPage(),
    //   SavedPage(),
    // ];

    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: PageView(
            controller: _tabsPageController,
            onPageChanged: (num) {
              setState(() {
                _selectedTab = num;
              });
            },
            children: [
              HomeTab(),
              SearchPage(),
              SavedPage(),
            ],
          ),
        ),
        BottomTabs(
          selectedTab: _selectedTab,
          tabPressed: (num) {
            _tabsPageController.animateToPage(
              num,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
            );
          },
        ),
      ],
    ));
  }
}
