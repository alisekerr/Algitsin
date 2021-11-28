import 'package:algitsin/core/extensions/size_extention.dart';
import 'package:algitsin/feature/view/basket_page.dart';
import 'package:algitsin/feature/view/category_page.dart';
import 'package:algitsin/feature/view/home_page.dart';
import 'package:algitsin/feature/view/search_page.dart';
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
      bottomNavigationBar: SizedBox(
        height: 50.0.h,
        child: buildBottomNavBar(context),
      ),
    );
  }

  BottomNavigationBar buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: _selectedPage,
        onTap: (index) {
          _onItemTapped(index);
        },
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor:Theme.of(context).dividerColor ,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
        ],
      );
  }
}
