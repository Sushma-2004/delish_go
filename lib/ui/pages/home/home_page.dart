import 'package:delish_go/ui/pages/cart/cart_page.dart';
import 'package:delish_go/ui/pages/home/main_food_page.dart';
import 'package:delish_go/ui/pages/order_history/order_history.dart';
import 'package:delish_go/ui/utils/AppColors/app_colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
int _selectedIndex = 0;
List pages = [
  MainFoodPage(),
  OrderHistory(),
  CartPage(),
];

void onTapNav(int index){
   setState(() {
     _selectedIndex = index;
   });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
         currentIndex: _selectedIndex,
        onTap: onTapNav,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.archive),
            label: "History",
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          
        ],),
    );
  }
}