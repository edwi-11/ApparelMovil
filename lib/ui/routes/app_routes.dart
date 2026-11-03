import 'package:flutter/material.dart';

import 'package:apparel_movil/presentation/screens/login/login_screen.dart';
import 'package:apparel_movil/presentation/screens/clientes/clientes_screen.dart';
import 'package:apparel_movil/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:apparel_movil/presentation/screens/productos/productos_screen.dart';
import 'package:apparel_movil/presentation/screens/ventas/ventas_screen.dart';
import 'package:apparel_movil/presentation/screens/empleados/empleados_screen.dart';
import 'package:apparel_movil/ui/layouts/app_layout.dart';
import 'package:apparel_movil/presentation/screens/logs/logs_screen.dart';
import 'package:apparel_movil/presentation/screens/configuracion/configuracion_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/login': (context) => const LoginScreen(),
  '/dashboard': (context) => const AppLayout(
        currentIndex: 0,
        child: DashboardScreen(),
      ),
  '/clientes': (context) => const AppLayout(
        currentIndex: 1,
        child: ClientesScreen(),
      ),
  '/empleados': (context) => const AppLayout(
        currentIndex: 2,
        child: EmpleadosScreen(),
      ),
  '/ventas': (context) => const AppLayout(
        currentIndex: 3,
        child: VentasScreen(),
      ),
  '/logs': (context) => const AppLayout(
        currentIndex: 4,
        child: LogsScreen(),
      ),
  '/productos': (context) => const AppLayout(
        currentIndex: 5,
        child: ProductosScreen(),
      ),
  '/config': (context) => const AppLayout(
        child: ConfiguracionScreen(),
      ),
};