import 'package:apparel_movil/data/models/ventas_models.dart';
import 'package:apparel_movil/data/repositories/ventas_repository.dart';

enum PeriodoVentas { todas, hoy, semana, mes }

class VentasService {
  final VentasRepository _ventasRepository;

  VentasService(this._ventasRepository);

  Future<List<VentaModel>> obtenerVentas() async {
    final ventas = await _ventasRepository.search();
    ventas.sort((a, b) => b.fechaVenta.compareTo(a.fechaVenta));
    return ventas;
  }

  List<VentaModel> filtrar(
    List<VentaModel> ventas,
    PeriodoVentas periodo,
    String texto,
  ) {
    final busqueda = texto.trim().toLowerCase();
    final ahora = DateTime.now();

    return ventas.where((v) {
      final f = v.fechaVenta;

      final coincidePeriodo = switch (periodo) {
        PeriodoVentas.todas => true,
        PeriodoVentas.hoy =>
          f.year == ahora.year && f.month == ahora.month && f.day == ahora.day,
        PeriodoVentas.semana => ahora.difference(f).inDays < 7,
        PeriodoVentas.mes => f.year == ahora.year && f.month == ahora.month,
      };

      final coincideTexto = busqueda.isEmpty ||
          v.codVenta.toString().contains(busqueda) ||
          v.total.toStringAsFixed(2).contains(busqueda);

      return coincidePeriodo && coincideTexto;
    }).toList();
  }
}