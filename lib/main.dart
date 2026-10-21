import 'package:flutter/material.dart';
import '/ui/routes/app_routes.dart';

void main() {
  runApp(
     MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: '/login',

      routes: appRoutes,


    ),
  );
}
