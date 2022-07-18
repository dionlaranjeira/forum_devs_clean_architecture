import 'package:flutter/material.dart';
import 'package:forum_devs_clean_architecture/home.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
          useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const Home())
  );
}
