import 'package:flutter/material.dart';
import 'package:kaboom_mobile/src/views/ui/main/loadingscreen.dart';

class KaboomMobile extends StatelessWidget {
  const KaboomMobile({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? page = const LoadingScreen();

    return MaterialApp(
      home: page,
    );
  }
}