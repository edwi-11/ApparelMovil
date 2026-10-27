import 'package:flutter/material.dart';
import 'package:apparel_movil/core/errors/app_exception.dart';
import 'package:apparel_movil/data/models/ventas_models.dart';
import 'package:apparel_movil/services/ventas_service.dart';

class VentasProvider extends ChangeNotifier {
  final VentasService _ventasService;

  VentasProvider(this._ventasService);

  List<VentaModel> _ventas = [];
  bool _cargando = false;
  String? _error;
  PeriodoVentas _periodo = PeriodoVentas.todas;
  String _busqueda = '';

  List<VentaModel> get ventas =>
      _ventasService.filtrar(_ventas, _periodo, _busqueda);
  bool get cargando => _cargando;
  String? get error => _error;
  PeriodoVentas get periodo => _periodo;

  Future<void> cargar() async {
    _cargando = true;
    _error = null;
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

  void setPeriodo(PeriodoVentas periodo) {
    _periodo = periodo;
    notifyListeners();
  }

  void setBusqueda(String texto) {
    _busqueda = texto;
    notifyListeners();
  }
}