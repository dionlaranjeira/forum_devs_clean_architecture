import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forum_devs_clean_architecture/ui/pages/pages.dart';


class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    final primaryColor = Color.fromRGBO(136, 14, 79, 1);
    final primaryColorDark = Color.fromRGBO(96, 0, 39, 1);
    final primaryColorLight = Color.fromRGBO(188, 71, 123, 1);
    final backgroundColor = Colors.white;


    return MaterialApp(
      title: '4Dev',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        primaryColorDark: primaryColorDark,
        primaryColorLight: primaryColorLight,
        accentColor: primaryColor,
        backgroundColor: backgroundColor,
          textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: primaryColorDark
            )
          ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: (
          UnderlineInputBorder(
            borderSide: BorderSide(
              color: primaryColorLight
            )
          )
          ),
            focusedBorder: (
                UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: primaryColor
                    )
                )
            ),
          alignLabelWithHint: true
        ),
        buttonTheme: ButtonThemeData(
          colorScheme: ColorScheme.light(primary: primaryColor),
          buttonColor: primaryColor,
          splashColor: primaryColorLight,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          )
        )
      ),
      home: LoginPage(),
    );
  }
}