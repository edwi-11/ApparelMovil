import 'package:flutter/material.dart';
import 'package:apparel_movil/layouts/app_layout.dart';
import 'package:apparel_movil/screens/empleados/empleados_screen.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppLayout(
      child : EmpleadosScreen()
      ),
    ),
  );
}