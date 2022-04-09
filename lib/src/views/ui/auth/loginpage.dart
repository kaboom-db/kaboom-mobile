import 'package:flutter/material.dart';

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

    const buttonSignup = TextButton(
        onPressed: null,
        child: Text(
          "Signup",
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
              inputServer,
              inputUsername,
              inputPassword,
              buttonLogin,
              Row(
                children: const [
                  buttonForgotPassword,
                  Text("|"),
                  buttonSignup,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    // Get the details
    String? server = serverController.text;
    String? username = usernameController.text;
    String? password = passwordController.text;

    print(server);
    print(username);
    print(password);
  }
}
