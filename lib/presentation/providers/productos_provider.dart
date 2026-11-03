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

  Future<List<ProductoModel>> _conStock(List<ProductoModel> lista) {
    return Future.wait(lista.map((p) async {
      try {
        return p.copyWith(stock: await _service.obtenerStock(p.codigo));
      } catch (_) {
        return p;
      }
    }));
  }

  Future<void> cargar() async {
    _cargando = true;
    _error = null;
    notifyListeners();

    try {
      _productos = await _conStock(await _service.obtenerProductos());
    } on AppException catch (e) {
      _error = e.message;
    } catch (_) {
      _error = 'Ocurrió un error inesperado.';
    }

    _cargando = false;
    notifyListeners();
  }

  Future<void> _refrescar() async {
    try {
      _productos = await _conStock(await _service.obtenerProductos());
      _error = null;
    } catch (_) {
      // se conserva la lista anterior
    }
    notifyListeners();
  }

  Future<String?> _ejecutar(Future<void> Function() accion) async {
    try {
      await accion();
      await _refrescar();
      return null;
    } on ServerException catch (e) {
      return e.statusCode == 403
          ? 'Solo un administrador puede hacer esto.'
          : e.message;
    } on AppException catch (e) {
      return e.message;
    } catch (_) {
      return 'Ocurrió un error inesperado.';
    }
  }

  Future<String?> crear(ProductoModel p) => _ejecutar(() => _service.crear(p));
  Future<String?> actualizar(ProductoModel p) =>
      _ejecutar(() => _service.actualizar(p));
  Future<String?> eliminar(int codigo) =>
      _ejecutar(() => _service.eliminar(codigo));

  void setBusqueda(String texto) {
    _busqueda = texto;
    notifyListeners();
  }

  void setFiltro(FiltroStock valor) {
    _filtro = valor;
    notifyListeners();
  }
}