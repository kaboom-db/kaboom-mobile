import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Email *',
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

  Future<dynamic> signup() async {}

  void loginInstead() {
    Navigator.pop(context);
  }
}
