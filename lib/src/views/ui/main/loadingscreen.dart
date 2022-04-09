import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kaboom_mobile/src/views/ui/auth/loginpage.dart';
import 'package:kaboom_mobile/src/business_logic/api.dart';
import 'package:kaboom_dart/kaboom_dart.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({ Key? key }) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    checkAuth().then(((value) => {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => value))
    }));

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              padding: const EdgeInsets.only(
                left: 50,
                right: 50,
              ),
              child: Column(
                children: const <Widget>[
                  Icon(Icons.bar_chart)
                ],
              ),
            ),
            const Text("Loading....")
          ],
        ),
      ),
    );
  }

  Future<Widget> checkAuth() async {
    // Try and get the access token from SharedPreferences
    SharedPreferences pref = await SharedPreferences.getInstance();

    String? accessToken = pref.getString("kaboomAccessToken");
    String? url = pref.getString("kaboomUrl");

    if (url != null) {
      KaboomAPI.client = KaboomClient(url: url);
    }

    if (accessToken == null) {
      // User has not Logged in, return a Login page
      return const LoginPage();
    } else {
      // User has Logged in, return home page
      return const Text("Home Page");
    }
  }
}