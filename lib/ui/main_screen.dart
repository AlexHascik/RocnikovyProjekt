import 'package:flutter/material.dart';
import 'package:rocnikovy_projekt/ui/pages/home_page.dart';
import 'package:rocnikovy_projekt/ui/pages/user_details_page.dart';

class MainScreen extends StatefulWidget{

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  int id =0;

  final _screens =[
    const HomePage(),
    const Center(child: Text('Hráči', style: TextStyle(fontSize: 60))),
    // UserDetailsPage(id: 98),
    const Center(child: Text('Informácie o prihlásenom uživateľovi'))
  ];
  int _currentIndex = 0;
 
  @override
  Widget build(BuildContext context) => Scaffold(
    
    body: IndexedStack(  
      index: _currentIndex,
      children: _screens,
    ),
    bottomNavigationBar: BottomNavigationBar(
      iconSize: 30,
      currentIndex: _currentIndex,
      onTap:(index) => setState(() => _currentIndex = index),
       items: const [
       BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Domov',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star),
          label: 'Obľúbený hráči',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Môj profil',
        ),
      ],
    ),
    
  );
}



