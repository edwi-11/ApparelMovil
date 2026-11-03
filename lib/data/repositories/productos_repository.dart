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
      // La API responde 404 cuando no hay productos registrados.
      if (e.statusCode == 404) return [];
      rethrow;
    }
  }

  Future<void> crear(ProductoModel p) => _sinCuerpoJson(
        () => _apiClient.post(ApiConstants.insertarProducto, body: p.toJson()),
      );

  Future<void> actualizar(ProductoModel p) => _sinCuerpoJson(
        () => _apiClient.put(
          ApiConstants.actualizarProducto(p.codigo),
          body: p.toJson(),
        ),
      );

  Future<void> eliminar(int codigo) => _sinCuerpoJson(
        () => _apiClient.delete(ApiConstants.eliminarProducto(codigo)),
      );

  Future<void> _sinCuerpoJson(Future<dynamic> Function() accion) async {
    try {
      await accion();
    } on ParsingException {
      // respuesta de texto plano con código 2xx
    }
  }
}