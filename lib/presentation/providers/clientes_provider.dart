import 'package:flutter/material.dart';
import 'package:apparel_movil/core/errors/app_exception.dart';
import 'package:apparel_movil/data/models/clientes_models.dart';
import 'package:apparel_movil/services/clientes_service.dart';

class ClientesProvider extends ChangeNotifier {
  static const int _tamanoPagina = 20;

  final ClientesService _clientesService;

  ClientesProvider(this._clientesService);

  List<ClienteModel> _clientes = [];
  bool _cargando = false;
  String? _error;
  String _busqueda = '';
  int _limite = _tamanoPagina;

  List<ClienteModel> get _filtrados =>
      _clientesService.filtrar(_clientes, _busqueda);

  List<ClienteModel> get clientes => _filtrados.take(_limite).toList();
  bool get hayMas => _filtrados.length > _limite;
  bool get cargando => _cargando;
  String? get error => _error;

  Future<void> cargar() async {
    _cargando = true;
    _error = null;
    _limite = _tamanoPagina;
    notifyListeners();

    try {
      _clientes = await _clientesService.obtenerClientes();
    } on AppException catch (e) {
      _error = e.message;
    } catch (_) {
      _error = 'Ocurrió un error inesperado.';
    }

    _cargando = false;
    notifyListeners();
  }

  void cargarMas() {
    if (!hayMas) return;
    _limite += _tamanoPagina;
    notifyListeners();
  }

  void setBusqueda(String texto) {
    _busqueda = texto;
    _limite = _tamanoPagina;
    notifyListeners();
  }

  Future<String?> crear({
    required String nombre,
    required String apellido,
    required String telefono,
    required String cedula,
  }) {
    return _ejecutar(
      () => _clientesService.crear(
        nombre: nombre,
        apellido: apellido,
        telefono: telefono,
        cedula: cedula,
      ),
    );
  }

  Future<String?> actualizar(
    ClienteModel original, {
    required String nombre,
    required String apellido,
    required String telefono,
    required String cedula,
  }) {
    return _ejecutar(
      () => _clientesService.actualizar(
        original,
        nombre: nombre,
        apellido: apellido,
        telefono: telefono,
        cedula: cedula,
      ),
    );
  }

  Future<String?> eliminar(int id) {
    return _ejecutar(() => _clientesService.eliminar(id));
  }

  Future<String?> _ejecutar(Future<void> Function() accion) async {
    try {
      await accion();
      await cargar();
      return null;
    } on FormatException catch (e) {
      return e.message;
    } on AppException catch (e) {
      return e.message;
    } catch (_) {
      return 'Ocurrió un error inesperado.';
    }
  }
}