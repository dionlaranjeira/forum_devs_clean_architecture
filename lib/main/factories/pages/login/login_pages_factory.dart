import 'package:flutter/material.dart';
import 'package:forum_devs_clean_architecture/main/factories/factories.dart';
import 'package:forum_devs_clean_architecture/ui/pages/pages.dart';

Widget makeLoginPage() {

  return LoginPage(makeGetxLoginPresenter());
}