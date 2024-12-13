import 'package:flutter/material.dart';
import 'package:snap_kart_admin/cart/view/cart_screen.dart';

import 'package:snap_kart_admin/category/category_screen_.dart';
import 'package:snap_kart_admin/product/view/product_screen.dart';
import 'package:snap_kart_admin/profile/view/profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;

  final List<Widget> _screens = [
    const ProductScreen(),
    const CategoryScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;

        if (maxWidth >= 1200) {
          return _buildDesktopLayout();
        } else if (maxWidth >= 600) {
          return _buildTabletLayout();
        } else {
          return _buildPhoneLayout();
        }
      },
    );
  }

  Widget _buildDesktopLayout() {
    return Scaffold(

      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: onItemTapped,
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.shopping_bag),
                selectedIcon: Icon(Icons.shopping_bag, color: Colors.blueGrey),
                label: Text('Products'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.category),
                selectedIcon: Icon(Icons.category, color: Colors.blueGrey),
                label: Text('Categories'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.shopping_cart),
                selectedIcon: Icon(Icons.shopping_cart, color: Colors.blueGrey),
                label: Text('Cart'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person),
                selectedIcon: Icon(Icons.person, color: Colors.blueGrey),
                label: Text('Profile'),
              ),
            ],
            selectedIconTheme: const IconThemeData(color: Colors.blueGrey),
            unselectedIconTheme: const IconThemeData(color: Colors.grey),
          ),
          Expanded(
            child: IndexedStack(
              index: selectedIndex,
              children: _screens,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLayout() {
    return Scaffold(

      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: onItemTapped,
            labelType: NavigationRailLabelType.selected,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.shopping_bag),
                selectedIcon: Icon(Icons.shopping_bag, color: Colors.blueGrey),
                label: Text('Products'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.category),
                selectedIcon: Icon(Icons.category, color: Colors.blueGrey),
                label: Text('Categories'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.shopping_cart),
                selectedIcon: Icon(Icons.shopping_cart, color: Colors.blueGrey),
                label: Text('Cart'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person),
                selectedIcon: Icon(Icons.person, color: Colors.blueGrey),
                label: Text('Profile'),
              ),
            ],
            selectedIconTheme: const IconThemeData(color: Colors.blueGrey),
            unselectedIconTheme: const IconThemeData(color: Colors.grey),
          ),
          Expanded(
            child: IndexedStack(
              index: selectedIndex,
              children: _screens,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneLayout() {
    return Scaffold(

      body: IndexedStack(
        index: selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.blueGrey,
        unselectedItemColor: Colors.grey[800],
      ),
    );
  }
}
