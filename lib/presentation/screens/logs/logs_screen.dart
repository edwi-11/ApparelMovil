import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apparel_movil/data/models/logs_models.dart';
import 'package:apparel_movil/presentation/providers/logs_provider.dart';

class LogsScreen extends StatefulWidget {
  const LogsScreen({super.key});

  @override
  State<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  static const _rosaClaro = Color.fromARGB(255, 238, 181, 200);
  static const _rosaFuerte = Color.fromARGB(255, 245, 120, 162);

  static const _meses = [
    'ene', 'feb', 'mar', 'abr', 'may', 'jun',
    'jul', 'ago', 'sep', 'oct', 'nov', 'dic',
  ];

  static const _acciones = [
    ('Consultó', 'GET'),
    ('Registró', 'POST'),
    ('Actualizó', 'PUT'),
    ('Eliminó', 'DELETE'),
  ];
  static const _modulos = [
    ('Clientes', 'Cliente'),
    ('Usuarios', 'Usuarios'),
    ('Inventario', 'Productos'),
    ('Ventas', 'Ventas'),
    ('Sesión', 'login'),
  ];

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<LogsProvider>().cargarMas();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LogsProvider>().cargar();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  String _dos(int n) => n.toString().padLeft(2, '0');

  String _fechaHora(DateTime f) {
    final hora12 = f.hour % 12 == 0 ? 12 : f.hour % 12;
    final sufijo = f.hour < 12 ? 'a.m.' : 'p.m.';
    return '${f.day} ${_meses[f.month - 1]} ${f.year} · '
        '${_dos(hora12)}:${_dos(f.minute)} $sufijo';
  }

  Widget _opciones({
    required List<(String, String)> valores,
    required String? seleccionado,
    required void Function(String?) onElegir,
  }) {
    Widget boton(String etiqueta, String? valor) {
      final activo = seleccionado == valor;
      return ElevatedButton(
        onPressed: () => onElegir(valor),
        style: ElevatedButton.styleFrom(
          backgroundColor: activo ? _rosaFuerte : _rosaClaro,
          foregroundColor: activo ? Colors.white : Colors.black,
        ),
        child: Text(etiqueta),
      );
    }

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        boton('Todos', null),
        ...valores.map((v) => boton(v.$1, v.$2)),
      ],
    );
  }

  void _mostrarFiltro() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Consumer<LogsProvider>(
            builder: (_, p, __) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Filtrar logs',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const Text('Acción', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                _opciones(
                  valores: _acciones,
                  seleccionado: p.metodo,
                  onElegir: p.setMetodo,
                ),
                const SizedBox(height: 16),
                const Text('Módulo', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                _opciones(
                  valores: _modulos,
                  seleccionado: p.modulo,
                  onElegir: p.setModulo,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(ctx),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _rosaClaro,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('Listo'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _fila(String etiqueta, String valor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text('$etiqueta: $valor'),
    );
  }

  void _mostrarDetalle(LogModel l) {
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
                l.usuario,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(l.descripcion, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 12),
              _fila('Fecha', _fechaHora(l.fecha)),
              _fila('Módulo', l.etiquetaModulo),
              _fila('Resultado',
                  '${l.exitoso ? 'Exitoso' : 'Con error'} (${l.status})'),
              _fila('Tiempo de respuesta',
                  '${l.tiempoRespuestaMs.toStringAsFixed(1)} ms'),
              _fila('Petición', '${l.metodo} ${l.ruta}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tarjeta(LogModel l) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
        width: double.infinity,
        height: 70,
        child: ElevatedButton(
          onPressed: () => _mostrarDetalle(l),
          child: Row(
            children: [
              const Icon(Icons.account_circle, size: 40, color: _rosaFuerte),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.usuario,
                      style: const TextStyle(color: Colors.black),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      l.descripcion,
                      style: const TextStyle(color: Colors.black),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      _fechaHora(l.fecha),
                      style: const TextStyle(color: Colors.black),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Text(
                l.etiquetaModulo,
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

  Widget _contenido(LogsProvider p) {
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

    if (p.logs.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 40),
        child: SizedBox(
          width: double.infinity,
          child: Center(child: Text('No hay logs para mostrar.')),
        ),
      );
    }

    return Column(
      children: [
        ...p.logs.map(_tarjeta),
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
    final p = context.watch<LogsProvider>();

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
                'Logs',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
              ),
              const Text('Consulta la actividad del sistema'),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: SearchBar(
                        hintText: 'Buscar por usuario o acción',
                        leading: const Icon(Icons.search),
                        onChanged: p.setBusqueda,
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: _mostrarFiltro,
                      icon: Icon(
                        Icons.filter_alt_rounded,
                        color: p.hayFiltros ? _rosaFuerte : null,
                      ),
                    ),
                  ],
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