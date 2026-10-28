import 'package:get_it/get_it.dart';
import 'package:apparel_movil/core/network/api_client.dart';
import 'package:apparel_movil/core/network/session_store.dart';
import 'package:apparel_movil/data/repositories/ventas_repository.dart';
import 'package:apparel_movil/presentation/providers/ventas_provider.dart';
import 'package:apparel_movil/services/ventas_service.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Core
  getIt.registerLazySingleton<SessionStore>(() => SessionStore());
  getIt.registerLazySingleton<ApiClient>(
    () => ApiClient(() => getIt<SessionStore>().token),
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