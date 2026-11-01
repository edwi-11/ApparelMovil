import 'package:apparel_movil/data/repositories/token_repository.dart';
import 'package:apparel_movil/data/repositories/user_repository.dart';
import 'package:apparel_movil/presentation/providers/user_provider.dart';
import 'package:apparel_movil/services/auth_service.dart';
import 'package:apparel_movil/services/user_service.dart';
import 'package:get_it/get_it.dart';
import 'package:apparel_movil/core/network/api_client.dart';
import 'package:apparel_movil/data/repositories/ventas_repository.dart';
import 'package:apparel_movil/presentation/providers/ventas_provider.dart';
import 'package:apparel_movil/presentation/providers/auth_provider.dart';
import 'package:apparel_movil/services/ventas_service.dart';
import 'package:apparel_movil/data/repositories/clientes_repository.dart';
import 'package:apparel_movil/presentation/providers/clientes_provider.dart';
import 'package:apparel_movil/services/clientes_service.dart';

import 'package:apparel_movil/data/repositories/auth_repository.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Token 
  getIt.registerLazySingleton<TokenRepository>(() => TokenRepository());

  // ApiClient con la función que entrega el token
  getIt.registerLazySingleton<ApiClient>(
    () => ApiClient(() => getIt<TokenRepository>().currentToken),
    dispose: (client) => client.dispose(),
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<TokenRepository>(() => TokenRepository());

  // Services
  getIt.registerLazySingleton<AuthService>(
    () => AuthService(getIt<AuthRepository>(), getIt<TokenRepository>()),
  );

  // Providers
  getIt.registerFactory<AuthProvider>(
    () => AuthProvider(getIt<AuthService>()),
  );
   getIt.registerFactory<ClientesProvider>(
    () => ClientesProvider(getIt<ClientesService>()),
  );

  // Ventas
  getIt.registerLazySingleton<VentasRepository>(
    () => VentasRepository(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<VentasService>(
    () => VentasService(getIt<VentasRepository>()),
  );
  getIt.registerFactory<VentasProvider>(
    () => VentasProvider(getIt<VentasService>()),
  );
}