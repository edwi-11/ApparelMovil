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
import 'package:apparel_movil/data/repositories/logs_repository.dart';
import 'package:apparel_movil/services/logs_service.dart';
import 'package:apparel_movil/presentation/providers/logs_provider.dart';
import 'package:apparel_movil/data/repositories/productos_repository.dart';
import 'package:apparel_movil/services/productos_service.dart';
import 'package:apparel_movil/presentation/providers/productos_provider.dart';

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
  getIt.registerLazySingleton<UsuariosRepository>(
    () => UsuariosRepository(getIt<ApiClient>()),
  );
  // NUEVO: repositorio de clientes
  getIt.registerLazySingleton<ClientesRepository>(
    () => ClientesRepository(getIt<ApiClient>()),
  );

  // Services
  getIt.registerLazySingleton<AuthService>(
    () => AuthService(getIt<AuthRepository>(), getIt<TokenRepository>()),
  );
  // NUEVO: servicio de usuarios
  getIt.registerLazySingleton<UsuariosService>(
    () => UsuariosService(getIt<UsuariosRepository>()),
  );
  // NUEVO: servicio de clientes
  getIt.registerLazySingleton<ClientesService>(
    () => ClientesService(getIt<ClientesRepository>()),
  );

  // Providers
  getIt.registerFactory<AuthProvider>(
    () => AuthProvider(getIt<AuthService>()),
  );
  // NUEVO: provider de usuarios (el que faltaba y daba el error)
  getIt.registerFactory<UsuariosProvider>(
    () => UsuariosProvider(getIt<UsuariosService>()),
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

  // Logs
  getIt.registerLazySingleton<LogsRepository>(
    () => LogsRepository(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<LogsService>(
    () => LogsService(getIt<LogsRepository>()),
  );
  getIt.registerFactory<LogsProvider>(
    () => LogsProvider(getIt<LogsService>()),
  );

  // Productos
  getIt.registerLazySingleton<ProductosRepository>(
    () => ProductosRepository(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<ProductosService>(
    () => ProductosService(getIt<ProductosRepository>()),
  );
  getIt.registerFactory<ProductosProvider>(
    () => ProductosProvider(getIt<ProductosService>()),
  );
}