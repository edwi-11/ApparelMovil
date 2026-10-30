import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apparel_movil/data/models/clientes_models.dart';
import 'package:apparel_movil/presentation/providers/clientes_provider.dart';

class ClientesScreen extends StatefulWidget {
  const ClientesScreen({super.key});

  @override
  State<ClientesScreen> createState() => _ClientesScreenState();
}

class _ClientesScreenState extends State<ClientesScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<ClientesProvider>().cargarMas();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ClientesProvider>().cargar();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  String _codigo(int cod) => 'N° ${cod.toString().padLeft(3, '0')}';

  String _telefono(int numero) {
    final t = numero.toString();
    if (t.length == 8) return '+505 ${t.substring(0, 4)} ${t.substring(4)}';
    return '+505 $t';
  }

  Future<void> _abrirFormulario({ClienteModel? cliente}) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: _ClienteForm(cliente: cliente),
      ),
    );
  }

  Future<void> _confirmarEliminar(ClienteModel cliente) async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar cliente'),
        content: Text('¿Seguro que quieres eliminar a ${cliente.nombreCompleto}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmado != true || !mounted) return;

    final error =
        await context.read<ClientesProvider>().eliminar(cliente.codCliente);

    if (error != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    }
  }

  void _mostrarDetalle(ClienteModel c) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              c.nombreCompleto,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Cliente ${_codigo(c.codCliente)}'),
            Text('Teléfono: ${_telefono(c.numeroTelefono)}'),
            Text('Cédula: ${c.cedula}'),
            Text('Compras: ${c.numeroCompra}'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(ctx);
                      _abrirFormulario(cliente: c);
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Editar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(ctx);
                      _confirmarEliminar(c);
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text('Eliminar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 238, 181, 200),
                      foregroundColor: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _tarjeta(ClienteModel c) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
        width: 370,
        height: 70,
        child: ElevatedButton(
          onPressed: () => _mostrarDetalle(c),
          child: Row(
            children: [
              const Icon(
                Icons.account_circle,
                size: 40,
                color: Color.fromARGB(255, 245, 120, 162),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c.nombreCompleto,
                      style: const TextStyle(color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(_codigo(c.codCliente),
                        style: const TextStyle(color: Colors.black)),
                    Text(_telefono(c.numeroTelefono),
                        style: const TextStyle(color: Colors.black)),
                  ],
                ),
              ),
              Text(
                '${c.numeroCompra} compras',
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

  Widget _contenido(ClientesProvider p) {
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

    if (p.clientes.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 40),
        child: SizedBox(
          width: double.infinity,
          child: Center(child: Text('No hay clientes para mostrar.')),
        ),
      );
    }

    return Column(
      children: [
        ...p.clientes.map(_tarjeta),
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
    final p = context.watch<ClientesProvider>();

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
                'Clientes',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
              ),
              const Text('Gestiona la información de tus clientes'),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    SizedBox(
                      width: 310,
                      child: SearchBar(
                        hintText: 'Buscar Cliente',
                        leading: const Icon(Icons.search),
                        onChanged: p.setBusqueda,
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_alt_rounded),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: 380,
                  child: ElevatedButton.icon(
                    onPressed: () => _abrirFormulario(),
                    icon: const Icon(Icons.add),
                    label: const Text('Nuevo cliente'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 238, 181, 200),
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

class _ClienteForm extends StatefulWidget {
  final ClienteModel? cliente;

  const _ClienteForm({this.cliente});

  @override
  State<_ClienteForm> createState() => _ClienteFormState();
}

class _ClienteFormState extends State<_ClienteForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nombreCtrl =
      TextEditingController(text: widget.cliente?.nombre ?? '');
  late final TextEditingController _apellidoCtrl =
      TextEditingController(text: widget.cliente?.apellido ?? '');
  late final TextEditingController _telefonoCtrl = TextEditingController(
      text: widget.cliente?.numeroTelefono.toString() ?? '');
  late final TextEditingController _cedulaCtrl =
      TextEditingController(text: widget.cliente?.cedula ?? '');

  bool _guardando = false;
  String? _error;

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _apellidoCtrl.dispose();
    _telefonoCtrl.dispose();
    _cedulaCtrl.dispose();
    super.dispose();
  }

  String? _requerido(String? valor) =>
      (valor == null || valor.trim().isEmpty) ? 'Campo obligatorio' : null;

  String? _telefono(String? valor) {
    if (_requerido(valor) != null) return 'Campo obligatorio';
    return RegExp(r'^\d{8}$').hasMatch(valor!.trim())
        ? null
        : 'Debe tener 8 dígitos';
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _guardando = true;
      _error = null;
    });

    final provider = context.read<ClientesProvider>();
    final original = widget.cliente;

    final error = original == null
        ? await provider.crear(
            nombre: _nombreCtrl.text,
            apellido: _apellidoCtrl.text,
            telefono: _telefonoCtrl.text,
            cedula: _cedulaCtrl.text,
          )
        : await provider.actualizar(
            original,
            nombre: _nombreCtrl.text,
            apellido: _apellidoCtrl.text,
            telefono: _telefonoCtrl.text,
            cedula: _cedulaCtrl.text,
          );

    if (!mounted) return;

    if (error == null) {
      Navigator.pop(context);
    } else {
      setState(() {
        _guardando = false;
        _error = error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final editando = widget.cliente != null;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                editando ? 'Editar cliente' : 'Nuevo cliente',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _nombreCtrl,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: _requerido,
              ),
              TextFormField(
                controller: _apellidoCtrl,
                decoration: const InputDecoration(labelText: 'Apellido'),
                validator: _requerido,
              ),
              TextFormField(
                controller: _telefonoCtrl,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Teléfono'),
                validator: _telefono,
              ),
              TextFormField(
                controller: _cedulaCtrl,
                decoration: const InputDecoration(labelText: 'Cédula'),
                validator: _requerido,
              ),
              if (_error != null) ...[
                const SizedBox(height: 8),
                Text(_error!, style: const TextStyle(color: Colors.red)),
              ],
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _guardando ? null : _guardar,
                  child: Text(_guardando ? 'Guardando...' : 'Guardar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}