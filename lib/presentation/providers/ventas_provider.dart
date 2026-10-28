import 'package:flutter/material.dart';
import 'package:apparel_movil/core/errors/app_exception.dart';
import 'package:apparel_movil/data/models/ventas_models.dart';
import 'package:apparel_movil/services/ventas_service.dart';

class VentasProvider extends ChangeNotifier {
  static const int _tamanoPagina = 20;

  final VentasService _ventasService;

  VentasProvider(this._ventasService);

  List<VentaModel> _ventas = [];
  bool _cargando = false;
  String? _error;
  PeriodoVentas _periodo = PeriodoVentas.todas;
  String _busqueda = '';
  int _limite = _tamanoPagina;

  List<VentaModel> get _filtradas =>
      _ventasService.filtrar(_ventas, _periodo, _busqueda);

  List<VentaModel> get ventas => _filtradas.take(_limite).toList();
  bool get hayMas => _filtradas.length > _limite;
  int get totalFiltradas => _filtradas.length;
  bool get cargando => _cargando;
  String? get error => _error;
  PeriodoVentas get periodo => _periodo;

  Future<void> cargar() async {
    _cargando = true;
    _error = null;
    _limite = _tamanoPagina;
    notifyListeners();

    try {
      _ventas = await _ventasService.obtenerVentas();
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

  void setPeriodo(PeriodoVentas periodo) {
    _periodo = periodo;
    _limite = _tamanoPagina;
    notifyListeners();
  }

  void setBusqueda(String texto) {
    _busqueda = texto;
    _limite = _tamanoPagina;
    notifyListeners();
  }
}