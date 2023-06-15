import 'package:flutter/material.dart';
import 'package:gesive_web_app/src/pages/page_form_employee.dart';
import 'package:gesive_web_app/src/pages/page_history_reports.dart';
import 'package:gesive_web_app/src/pages/page_list_employee.dart';
import 'package:gesive_web_app/src/pages/page_login.dart';
import 'package:gesive_web_app/src/pages/page_register.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListEmployeePage(),
      routes: {
        LoginPage.routeName: (_) => LoginPage(),
        RegisterClientPage.routeName: (_) => RegisterClientPage(),
        FormEmployeePage.routename: (_) => FormEmployeePage()
      },
    );
  }
}
