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

  String _nombrePeriodo(PeriodoVentas p) => switch (p) {
        PeriodoVentas.todas => 'Todas',
        PeriodoVentas.hoy => 'Hoy',
        PeriodoVentas.semana => 'Semana',
        PeriodoVentas.mes => 'Mes',
      };

  void _mostrarDetalle(VentaModel venta) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Venta #${venta.codVenta}',
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<VentasProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Ventas')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: TextField(
              onChanged: p.setBusqueda,
              decoration: const InputDecoration(
                hintText: 'Buscar por número o total',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          SizedBox(
            height: 56,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: PeriodoVentas.values
                  .map(
                    (periodo) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(_nombrePeriodo(periodo)),
                        selected: p.periodo == periodo,
                        onSelected: (_) => p.setPeriodo(periodo),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(
            child: p.cargando
                ? const Center(child: CircularProgressIndicator())
                : p.error != null
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
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
                      )
                    : RefreshIndicator(
                        onRefresh: p.cargar,
                        child: ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.all(12),
                          itemCount: p.ventas.length + (p.hayMas ? 1 : 0),
                          itemBuilder: (_, i) {
                            if (i == p.ventas.length) {
                              return const Padding(
                                padding: EdgeInsets.all(16),
                                child: Center(child: CircularProgressIndicator()),
                              );
                            }
                            final v = p.ventas[i];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: ListTile(
                                onTap: () => _mostrarDetalle(v),
                                title: Text('Venta #${v.codVenta}'),
                                subtitle: Text(_fecha(v.fechaVenta)),
                                trailing:
                                    Text('C\$ ${v.total.toStringAsFixed(2)}'),
                              ),
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}