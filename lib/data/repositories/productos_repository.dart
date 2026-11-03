import 'package:apparel_movil/core/constants/api_constants.dart';
import 'package:apparel_movil/core/errors/app_exception.dart';
import 'package:apparel_movil/core/network/api_client.dart';
import 'package:apparel_movil/data/models/productos_models.dart';

class ProductosRepository {
  final ApiClient _apiClient;

  ProductosRepository(this._apiClient);

  Future<List<ProductoModel>> obtenerTodos() async {
    try {
      final json = await _apiClient.get(ApiConstants.productos);
      if (json is! List) throw const ParsingException();
      return json
          .map((e) => ProductoModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on ServerException catch (e) {
      if (e.statusCode == 404) return []; // "No hay productos registrados"
      rethrow;
    }
  }

  Future<int> obtenerStock(int codigo) async {
    final json = await _apiClient.get(ApiConstants.stockActual(codigo));
    if (json is num) return json.toInt();
    if (json is String) return int.tryParse(json) ?? 0;
    return 0;
  }

  Future<void> crear(ProductoModel p) =>
      _sinCuerpoJson(() => _apiClient.post(ApiConstants.insertarProducto, body: p.toJson()));

  Future<void> actualizar(ProductoModel p) => _sinCuerpoJson(
      () => _apiClient.put(ApiConstants.actualizarProducto(p.codigo), body: p.toJson()));

  Future<void> eliminar(int codigo) =>
      _sinCuerpoJson(() => _apiClient.delete(ApiConstants.eliminarProducto(codigo)));

  /// La API responde texto plano en crear/actualizar/eliminar, no JSON.
  Future<void> _sinCuerpoJson(Future<dynamic> Function() accion) async {
    try {
      await accion();
    } on ParsingException {
      // La operación sí se hizo; solo falló al leer el texto de respuesta.
    }
  }
}