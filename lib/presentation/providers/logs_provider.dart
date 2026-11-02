import 'dart:async';

import 'package:flutter/material.dart';
import 'package:apparel_movil/core/errors/app_exception.dart';
import 'package:apparel_movil/data/models/logs_models.dart';
import 'package:apparel_movil/services/logs_service.dart';

class LogsProvider extends ChangeNotifier {
  static const int _tamanoPagina = 20;

  final LogsService _logsService;

  LogsProvider(this._logsService);

  List<LogModel> _logs = [];
  int _total = 0;
  int _pagina = 1;
  bool _cargando = false;
  bool _cargandoMas = false;
  String? _error;

  String _busqueda = '';
  String? _modulo;
  String? _metodo;

  Timer? _debounce;
  int _peticion = 0; // descarta respuestas viejas si el usuario sigue filtrando

  List<LogModel> get logs => _logs;
  int get total => _total;
  bool get hayMas => _logs.length < _total;
  bool get cargando => _cargando;
  bool get cargandoMas => _cargandoMas;
  String? get error => _error;
  String? get modulo => _modulo;
  String? get metodo => _metodo;
  bool get hayFiltros => _modulo != null || _metodo != null;

  Future<void> cargar() async {
    final id = ++_peticion;
    _cargando = true;
    _cargandoMas = false;
    _error = null;
    _pagina = 1;
    notifyListeners();

    try {
      final resultado = await _logsService.obtenerLogs(
        pagina: 1,
        tamanoPagina: _tamanoPagina,
        texto: _busqueda,
        modulo: _modulo,
        metodo: _metodo,
      );
      if (id != _peticion) return;
      _logs = resultado.items;
      _total = resultado.total;
    } on ServerException catch (e) {
      if (id != _peticion) return;
      _error = e.statusCode == 403
          ? 'Solo un administrador puede ver los logs.'
          : e.message;
    } on AppException catch (e) {
      if (id != _peticion) return;
      _error = e.message;
    } catch (_) {
      if (id != _peticion) return;
      _error = 'Ocurrió un error inesperado.';
    }

    if (id != _peticion) return;
    _cargando = false;
    notifyListeners();
  }

  Future<void> cargarMas() async {
    if (_cargando || _cargandoMas || !hayMas || _error != null) return;

    final id = _peticion;
    _cargandoMas = true;
    notifyListeners();

    try {
      final resultado = await _logsService.obtenerLogs(
        pagina: _pagina + 1,
        tamanoPagina: _tamanoPagina,
        texto: _busqueda,
        modulo: _modulo,
        metodo: _metodo,
      );
      if (id != _peticion) return;
      _pagina = resultado.pagina;
      _logs = [..._logs, ...resultado.items];
      _total = resultado.total;
    } catch (_) {
      // Si falla la página siguiente se conserva lo ya cargado.
    }

    if (id != _peticion) return;
    _cargandoMas = false;
    notifyListeners();
  }

  /// Espera un momento a que el usuario termine de escribir antes de consultar.
  void setBusqueda(String texto) {
    _busqueda = texto;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), cargar);
  }

  void setModulo(String? valor) {
    _modulo = valor;
    cargar();
  }

  void setMetodo(String? valor) {
    _metodo = valor;
    cargar();
  }

  void limpiarFiltros() {
    _modulo = null;
    _metodo = null;
    cargar();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}