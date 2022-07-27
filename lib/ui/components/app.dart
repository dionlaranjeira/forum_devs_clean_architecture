import 'package:flutter/material.dart';
import 'package:forum_devs_clean_architecture/ui/pages/pages.dart';


class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '4Dev',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
