import 'package:flutter/material.dart';
import 'package:kaboom_mobile/src/views/ui/main/subscriptions.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List screens = [const ComicSubsPage(), const CartoonSubsPage(), const Text("Discover"), const Text("Profile")];
  int currentScreen = 0;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "Comics"),
            BottomNavigationBarItem(icon: Icon(Icons.tv), label: "Cartoons"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Discover"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
          onTap: (int value) => {
            setState(() {
              currentScreen = value;
            })
          },
          currentIndex: currentScreen,),
        body: screens[currentScreen],
      ),
    );
  }
}
