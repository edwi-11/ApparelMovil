import 'dart:math';

import 'package:flutter/material.dart';
import 'screens/login/login_screen.dart';
import 'screens/clientes/clientes_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/productos/productos_screen.dart';
import 'screens/ventas/ventas_screen.dart';
import 'screens/empleados/empleados_screen.dart';
import 'layouts/app_layout.dart';

void main() {
  runApp(
     MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
       '/login': (context) => const LoginScreen(),

'/clientes': (context) => const AppLayout(
  currentIndex: 1,
  child: MyWidget(),
),

'/dashboard': (context) => const AppLayout(
  currentIndex: 0,
  child: DashboardScreen(),
),

'/productos': (context) => const AppLayout(
  child: ProductosScreen(),
),

'/ventas': (context) => const AppLayout(
  currentIndex: 3,
  child: VentasScreen(),
),

'/empleados': (context) => const AppLayout(
  currentIndex: 2,
  child: EmpleadosScreen(),
),



      },
    ),
  );
}
