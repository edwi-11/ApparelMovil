import 'package:apparel_movil/data/models/productos_models.dart';
import 'package:apparel_movil/data/repositories/productos_repository.dart';

class ProductosService {
  final ProductosRepository _repository;

  ProductosService(this._repository);

  Future<List<ProductoModel>> obtenerProductos() => _repository.obtenerTodos();
  Future<int> obtenerStock(int codigo) => _repository.obtenerStock(codigo);
  Future<void> crear(ProductoModel p) => _repository.crear(p);
  Future<void> actualizar(ProductoModel p) => _repository.actualizar(p);
  Future<void> eliminar(int codigo) => _repository.eliminar(codigo);
}