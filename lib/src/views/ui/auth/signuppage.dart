import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kaboom_dart/kaboom_dart.dart';
import 'package:kaboom_mobile/src/business_logic/api.dart';

import 'package:kaboom_mobile/src/views/ui/main/homepage.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController serverController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    serverController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const header = Padding(
      padding: EdgeInsets.all(25),
      child: Center(
        child: Text(
          "Looks like you're new here!",
          style: TextStyle(
            color: Colors.black87, 
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    final inputServer = Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        keyboardType: TextInputType.url,
        decoration: InputDecoration(
          hintText: 'Server URL',
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
        controller: serverController,
      ),
    );

    final inputUsername = Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Username *',
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
        controller: usernameController,
      ),
    );

    final inputEmail = Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Email *',
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
        controller: emailController,
      ),
    );

    final inputPassword = Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Password *',
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
        controller: passwordController,
      ),
    );

    final buttonSignup = Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: ButtonTheme(
          height: 56,
          child: ElevatedButton(
            child: const Text('Signup',
                style: TextStyle(color: Colors.white, fontSize: 20)),
            onPressed: signup,
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                )),
                backgroundColor: MaterialStateProperty.all(Colors.black87),
                padding: MaterialStateProperty.all(const EdgeInsets.all(15))),
          ),
        ));

    final buttonLogin = TextButton(
        onPressed: loginInstead,
        child: const Text(
          "Login Instead",
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ));

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: <Widget>[
              header,
              inputServer,
              inputUsername,
              inputEmail,
              inputPassword,
              buttonSignup,
              buttonLogin
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> signup() async {
    String? server = serverController.text;
    String? username = usernameController.text;
    String? email = emailController.text;
    String? password = passwordController.text;

    SharedPreferences pref = await SharedPreferences.getInstance();

    if (server.isNotEmpty) {
      KaboomAPI.client = KaboomClient(url: server);
      // Set the url
      pref.setString("kaboomUrl", server);
    } else {
      // Try and get a SharedPref for it
      String? prefServer = pref.getString("kaboomUrl");
      if (prefServer == null) {
        KaboomAPI.client = KaboomClient();
        // If there is no pref for the url, and there is no input, save the staging url
        String? saveUrl = KaboomAPI.client?.url;
        pref.setString("kaboomUrl", saveUrl!);
      } else {
        KaboomAPI.client = KaboomClient(url: prefServer);
      }
    }

    if (username.isNotEmpty && password.isNotEmpty && email.isNotEmpty) {
      // Signup to Kaboom
      var t = await KaboomAPI.client?.signup(username, password, email);
      // Save the accessToken
      var accessToken = t?.token;
      var kaboomUsername = t?.username;
      pref.setString("kaboomAccessToken", accessToken!);
      pref.setString("kaboomUsername", kaboomUsername!);
      KaboomAPI.accessToken = accessToken;

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }

  void loginInstead() {
    Navigator.pop(context);
  }
}
