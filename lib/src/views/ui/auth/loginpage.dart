import 'package:flutter/material.dart';
import 'package:kaboom_dart/kaboom_dart.dart';
import 'package:kaboom_mobile/src/business_logic/api.dart';
import 'package:kaboom_mobile/src/views/ui/auth/signuppage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kaboom_mobile/src/views/ui/main/homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController serverController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    serverController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logo = Padding(
      padding: const EdgeInsets.all(20),
      child: Hero(
          tag: 'hero',
          child: CircleAvatar(
            radius: 50.0,
            child: Image.asset('assets/images/logo.png'),
          )),
    );

    const header = Padding(
      padding: EdgeInsets.all(25),
      child: Center(
        child: Text(
          "Welcome back!",
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

    final buttonLogin = Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: ButtonTheme(
          height: 56,
          child: ElevatedButton(
            child: const Text('Login',
                style: TextStyle(color: Colors.white, fontSize: 20)),
            onPressed: login,
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                )),
                backgroundColor: MaterialStateProperty.all(Colors.black87),
                padding: MaterialStateProperty.all(const EdgeInsets.all(15))),
          ),
        ));

    const buttonForgotPassword = TextButton(
        onPressed: null,
        child: Text(
          "Forgot Password",
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ));

    final buttonSignup = TextButton(
        onPressed: signupInstead,
        child: const Text(
          "Signup Instead",
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ));

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: <Widget>[
              logo,
              header,
              inputServer,
              inputUsername,
              inputPassword,
              buttonLogin,
              buttonForgotPassword,
              buttonSignup
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> login() async {
    // Get the details
    String? server = serverController.text;
    String? username = usernameController.text;
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

    if (username.isNotEmpty && password.isNotEmpty) {
      // Login to Kaboom
      var t = await KaboomAPI.client?.login(username, password);
      // Save the accessToken
      var accessToken = t?.token;
      var kaboomUsername = t?.username;
      pref.setString("kaboomAccessToken", accessToken!);
      pref.setString("kaboomUsername", kaboomUsername!);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }

  void signupInstead() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignupPage()));
  }
}
