import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apparel_movil/data/models/ventas_models.dart';
import 'package:apparel_movil/presentation/providers/ventas_provider.dart';
import 'package:apparel_movil/services/ventas_service.dart';

class VentasScreen extends StatefulWidget {
  const VentasScreen({super.key});

  @override
  State<VentasScreen> createState() => _VentasScreenState();
}

class _VentasScreenState extends State<VentasScreen> {
  static const _rosaClaro = Color.fromARGB(255, 238, 181, 200);
  static const _rosaFuerte = Color.fromARGB(255, 245, 120, 162);

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<VentasProvider>().cargarMas();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VentasProvider>().cargar();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  String _fecha(DateTime f) =>
      '${f.day.toString().padLeft(2, '0')}/${f.month.toString().padLeft(2, '0')}/${f.year}';

  String _codigo(int cod) => 'N° ${cod.toString().padLeft(3, '0')}';

  String _nombrePeriodo(PeriodoVentas p) => switch (p) {
        PeriodoVentas.todas => 'Todas',
        PeriodoVentas.hoy => 'Hoy',
        PeriodoVentas.semana => 'Semana',
        PeriodoVentas.mes => 'Mes',
      };

  void _mostrarFiltro() {
    final provider = context.read<VentasProvider>();
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Filtrar por período',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ...PeriodoVentas.values.map(
              (periodo) => ListTile(
                leading: Icon(
                  provider.periodo == periodo
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: _rosaFuerte,
                ),
                title: Text(_nombrePeriodo(periodo)),
                onTap: () {
                  provider.setPeriodo(periodo);
                  Navigator.pop(ctx);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarDetalle(VentaModel venta) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Venta ${_codigo(venta.codVenta)}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('Fecha: ${_fecha(venta.fechaVenta)}'),
              Text('Cliente: ${venta.codCliente}'),
              Text('Usuario: ${venta.codUsuario}'),
              const Divider(),
              ...venta.detalles.map(
                (d) => ListTile(
                  dense: true,
                  title: Text('Producto ${d.codigoProducto}'),
                  subtitle: Text(
                    'Cantidad: ${d.cantidad} · C\$ ${d.precioUnitario.toStringAsFixed(2)}',
                  ),
                  trailing: Text('C\$ ${d.subtotal.toStringAsFixed(2)}'),
                ),
              ),
              const Divider(),
              Text(
                'Total: C\$ ${venta.total.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tarjeta(VentaModel v) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
        width: double.infinity,
        height: 70,
        child: ElevatedButton(
          onPressed: () => _mostrarDetalle(v),
          child: Row(
            children: [
              const Icon(Icons.receipt_long, size: 40, color: _rosaFuerte),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Venta ${_codigo(v.codVenta)}',
                      style: const TextStyle(color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      _fecha(v.fechaVenta),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              Text(
                'C\$ ${v.total.toStringAsFixed(2)}',
                style: const TextStyle(color: Colors.green),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }

  Widget _contenido(VentasProvider p) {
    if (p.cargando) {
      return const Padding(
        padding: EdgeInsets.only(top: 40),
        child: SizedBox(
          width: double.infinity,
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (p.error != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 40),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Text(p.error!, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: p.cargar,
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      );
    }

    if (p.ventas.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 40),
        child: SizedBox(
          width: double.infinity,
          child: Center(child: Text('No hay ventas para mostrar.')),
        ),
      );
    }

    return Column(
      children: [
        ...p.ventas.map(_tarjeta),
        if (p.hayMas)
          const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<VentasProvider>();

    return RefreshIndicator(
      onRefresh: p.cargar,
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ventas',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
              ),
              const Text('Consulta el historial de ventas'),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: SearchBar(
                        hintText: 'Buscar Venta',
                        leading: const Icon(Icons.search),
                        onChanged: p.setBusqueda,
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: _mostrarFiltro,
                      icon: Icon(
                        Icons.filter_alt_rounded,
                        color: p.periodo == PeriodoVentas.todas
                            ? null
                            : _rosaFuerte,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Próximamente')),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Nueva venta'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _rosaClaro,
                      foregroundColor: Colors.black,
                    ),
                  ),
                ),
              ),
              _contenido(p),
            ],
          ),
        ),
      ),
    );
  }
}