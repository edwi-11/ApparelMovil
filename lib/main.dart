import 'package:apparel_movil/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:apparel_movil/core/di/injection.dart';
import 'package:apparel_movil/presentation/providers/ventas_provider.dart';
import 'package:apparel_movil/ui/routes/app_routes.dart';


const String _apiUrlPorDefecto =
    'https://apparelmovilapi-dgdpgjc5gafxfyfp.canadacentral-01.azurewebsites.net';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: '.env');
  } catch (_) {
    dotenv.loadFromString(envString: 'BASE_API_URL=$_apiUrlPorDefecto');
  }

  if ((dotenv.env['BASE_API_URL'] ?? '').trim().isEmpty) {
    dotenv.loadFromString(envString: 'BASE_API_URL=$_apiUrlPorDefecto');
  }

  setupDependencies();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<VentasProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<AuthProvider>()),
      ],
      child: const ApparelApp(),
    ),
  );
}

class ApparelApp extends StatelessWidget {
  const ApparelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apparel Móvil',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: appRoutes,
    );
  }
}