import 'package:apparel_movil/data/models/user_models.dart';
import 'package:apparel_movil/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:apparel_movil/core/errors/app_exception.dart';

class UsuariosProvider extends ChangeNotifier {
  final UsuariosService _usuariosService;

  UsuariosProvider(this._usuariosService);

  List<UsuarioModel> _usuarios = [];
  bool _cargando = false;
  bool _guardando = false;
  String? _error;
  String _busqueda = '';

  List<UsuarioModel> get usuarios =>
      _usuariosService.filtrar(_usuarios, _busqueda);
  bool get cargando => _cargando;
  bool get guardando => _guardando;
  String? get error => _error;

  Future<void> cargar() async {
    _cargando = true;
    _error = null;
    notifyListeners();

    try {
      _usuarios = await _usuariosService.obtenerUsuarios();
    } on AppException catch (e) {
      _error = e.message;
    } catch (_) {
      _error = 'Ocurrió un error inesperado.';
    }

    _cargando = false;
    notifyListeners();
  }

  void setBusqueda(String texto) {
    _busqueda = texto;
    notifyListeners();
  }

  Future<bool> crear(UsuarioModel usuario) =>
      _ejecutar(() => _usuariosService.crear(usuario));

  Future<bool> actualizar(UsuarioModel usuario) =>
      _ejecutar(() => _usuariosService.actualizar(usuario));

  Future<bool> darDeBaja(int codUsuario) =>
      _ejecutar(() => _usuariosService.darDeBaja(codUsuario));

  // Ejecuta crear/actualizar/baja y recarga la lista si salió bien.
  Future<bool> _ejecutar(Future<void> Function() accion) async {
    _guardando = true;
    _error = null;
    notifyListeners();

    var ok = false;
    try {
      await accion();
      ok = true;
    } on AppException catch (e) {
      _error = e.message;
    } catch (_) {
      _error = 'Ocurrió un error inesperado.';
    }

    _guardando = false;
    notifyListeners();

    if (ok) await cargar();
    return ok;
  }
}