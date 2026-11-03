import 'package:flutter/material.dart';
import 'package:apparel_movil/core/errors/app_exception.dart';
import 'package:apparel_movil/data/models/productos_models.dart';
import 'package:apparel_movil/services/productos_service.dart';

enum FiltroStock { todos, conStock, agotados }

class ProductosProvider extends ChangeNotifier {
  final ProductosService _service;

  ProductosProvider(this._service);

  List<ProductoModel> _productos = [];
  bool _cargando = false;
  String? _error;
  String _busqueda = '';
  FiltroStock _filtro = FiltroStock.todos;

  bool get cargando => _cargando;
  String? get error => _error;
  FiltroStock get filtro => _filtro;

  /// Lista ya filtrada por búsqueda y por stock.
  List<ProductoModel> get productos {
    final q = _busqueda.trim().toLowerCase();
    return _productos.where((p) {
      final coincideTexto = q.isEmpty ||
          p.nombre.toLowerCase().contains(q) ||
          p.marca.toLowerCase().contains(q) ||
          p.descripcion.toLowerCase().contains(q) ||
          p.codigo.toString().contains(q);
      final coincideStock = switch (_filtro) {
        FiltroStock.todos => true,
        FiltroStock.conStock => !p.agotado,
        FiltroStock.agotados => p.agotado,
      };
      return coincideTexto && coincideStock;
    }).toList();
  }

  String _mensaje(Object e) {
    if (e is ServerException) {
      if (e.statusCode == 403) return 'Solo un administrador puede hacer esto.';
      return e.message;
    }
    if (e is AppException) return e.message;
    return 'Ocurrió un error inesperado.';
  }

  Future<void> cargar() async {
    _cargando = true;
    _error = null;
    notifyListeners();

    try {
      _productos = await _service.obtenerProductos();
    } catch (e) {
      _error = _mensaje(e);
    }

    _cargando = false;
    notifyListeners();
  }

  /// Vuelve a pedir la lista sin mostrar el indicador de carga.
  Future<void> _refrescar() async {
    _productos = await _service.obtenerProductos();
    notifyListeners();
  }

  /// Devuelve null si todo salió bien, o el mensaje de error.
  Future<String?> crear({
    required String nombre,
    required String descripcion,
    required String marca,
    required String precio,
    required String talla,
    required String stock,
    required int estado,
  }) async {
    try {
      await _service.crear(ProductoModel(
        codigo: 0,
        nombre: nombre.trim(),
        descripcion: descripcion.trim(),
        marca: marca.trim(),
        precio: double.parse(precio.trim().replaceAll(',', '.')),
        talla: int.parse(talla.trim()),
        estado: estado,
        stock: int.parse(stock.trim()),
      ));
      await _refrescar();
      return null;
    } catch (e) {
      return _mensaje(e);
    }
  }

  Future<String?> actualizar(
    ProductoModel original, {
    required String nombre,
    required String descripcion,
    required String marca,
    required String precio,
    required String talla,
    required int estado,
  }) async {
    try {
      await _service.actualizar(ProductoModel(
        codigo: original.codigo,
        nombre: nombre.trim(),
        descripcion: descripcion.trim(),
        marca: marca.trim(),
        precio: double.parse(precio.trim().replaceAll(',', '.')),
        talla: int.parse(talla.trim()),
        estado: estado,
        stock: original.stock,
      ));
      await _refrescar();
      return null;
    } catch (e) {
      return _mensaje(e);
    }
  }

  Future<String?> eliminar(int codigo) async {
    try {
      await _service.eliminar(codigo);
      await _refrescar();
      return null;
    } catch (e) {
      return _mensaje(e);
    }
  }

  void setBusqueda(String texto) {
    _busqueda = texto;
    notifyListeners();
  }

  void setFiltro(FiltroStock valor) {
    _filtro = valor;
    notifyListeners();
  }
}