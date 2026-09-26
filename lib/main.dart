import 'package:flutter/material.dart';
import 'layouts/app_layout.dart';
import 'screens/empleados/empleados_screen.dart';

void main() {
  runApp(
    const MaterialApp(
      home: AppLayout(
        child: EmpleadosScreen(),
      )
    ),
  );
}
