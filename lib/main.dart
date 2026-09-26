import 'package:flutter/material.dart';
import 'layouts/app_layout.dart';
import 'screens/empleados/empleados_screen.dart';
import 'screens/ventas/ventas_screen.dart';

void main() {
  runApp(
    const MaterialApp(
      home: AppLayout(
        child: VentasScreen(),
      )
    ),
  );
}
