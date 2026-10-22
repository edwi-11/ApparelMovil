import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:apparel_movil/ui/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
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