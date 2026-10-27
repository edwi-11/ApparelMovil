import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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

  runApp(const ApparelApp());
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