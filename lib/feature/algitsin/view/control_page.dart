import 'package:algitsin/feature/algitsin/view/basket_page.dart';
import 'package:algitsin/feature/algitsin/view/category_page.dart';
import 'package:algitsin/feature/algitsin/view/home_page.dart';
import 'package:algitsin/feature/algitsin/view/search_page.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({Key? key}) : super(key: key);

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  late PageController _pageController;

  int _selectedPage = 0;

  List<Widget> pages = [
    const HomePage(),
    const SearchPage(),
    const BasketPage(),
    const CategoryPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (index) => setState(() {
          _selectedPage = index;
        }),
        controller: _pageController,
        children: [...pages],
      ),
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _selectedPage,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _onItemTapped(index);
        }),
        items: [
          FlashyTabBarItem(
            icon: const Icon(Icons.home_outlined),
            title: const Text('Home'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.search),
            title: const Text('Search'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.shopping_bag_outlined),
            title: const Text('Cart'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.account_circle_outlined),
            title: const Text('Profile'),
          ),
        ],
      ),
    );
  }
}
