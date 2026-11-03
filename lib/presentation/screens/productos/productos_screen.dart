import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apparel_movil/data/models/productos_models.dart';
import 'package:apparel_movil/presentation/providers/productos_provider.dart';

const _rosa = Color.fromARGB(255, 238, 181, 200);
const _rosaIcono = Color.fromARGB(255, 245, 120, 162);

class ProductosScreen extends StatefulWidget {
  const ProductosScreen({super.key});

  @override
  State<ProductosScreen> createState() => _ProductosScreenState();
}

class _ProductosScreenState extends State<ProductosScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductosProvider>().cargar();
    });
  }

  String _codigo(int c) => 'N° ${c.toString().padLeft(3, '0')}';
  String _precio(double p) => 'C\$ ${p.toStringAsFixed(2)}';

  Future<void> _abrirFormulario({ProductoModel? producto}) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: _ProductoForm(producto: producto),
      ),
    );
  }

  Future<void> _confirmarEliminar(ProductoModel p) async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar producto'),
        content: Text('¿Seguro que quieres eliminar "${p.nombre}"?'),
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

    final error = await context.read<ProductosProvider>().eliminar(p.codigo);
    if (error != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    }
  }

  void _mostrarDetalle(ProductoModel p) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(p.nombre,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Producto ${_codigo(p.codigo)}'),
            Text('Descripción: ${p.descripcion}'),
            Text('Marca: ${p.marca}'),
            Text('Talla: ${p.talla}'),
            Text('Precio: ${_precio(p.precio)}'),
            Text('Stock: ${p.agotado ? 'Agotado' : p.stock}'),
            Text('Estado: ${p.estadoTexto}'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(ctx);
                      _abrirFormulario(producto: p);
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
                      _confirmarEliminar(p);
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text('Eliminar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _rosa,
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

  Widget _tarjeta(ProductoModel p) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
        width: 370,
        height: 70,
        child: ElevatedButton(
          onPressed: () => _mostrarDetalle(p),
          child: Row(
            children: [
              const Icon(Icons.checkroom, size: 40, color: _rosaIcono),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.nombre,
                        style: const TextStyle(color: Colors.black),
                        overflow: TextOverflow.ellipsis),
                    Text('${p.marca} · Talla ${p.talla}',
                        style: const TextStyle(color: Colors.black),
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(_precio(p.precio),
                      style: const TextStyle(color: Colors.green)),
                  Text(
                    p.agotado ? 'Agotado' : 'Stock: ${p.stock}',
                    style: TextStyle(
                      color: p.agotado ? Colors.red : Colors.black54,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }

  Widget _contenido(ProductosProvider p) {
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
              ElevatedButton(onPressed: p.cargar, child: const Text('Reintentar')),
            ],
          ),
        ),
      );
    }

    if (p.productos.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 40),
        child: SizedBox(
          width: double.infinity,
          child: Center(child: Text('No hay productos para mostrar.')),
        ),
      );
    }

    return Column(children: p.productos.map(_tarjeta).toList());
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<ProductosProvider>();

    return RefreshIndicator(
      onRefresh: p.cargar,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Inventario',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
              const Text('Gestiona los productos de tu inventario'),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: SearchBar(
                        hintText: 'Buscar producto',
                        leading: const Icon(Icons.search),
                        onChanged: p.setBusqueda,
                        trailing: [
                          PopupMenuButton<FiltroStock>(
                            icon: const Icon(Icons.filter_alt_rounded),
                            initialValue: p.filtro,
                            onSelected: p.setFiltro,
                            itemBuilder: (_) => const [
                              PopupMenuItem(
                                  value: FiltroStock.todos, child: Text('Todos')),
                              PopupMenuItem(
                                  value: FiltroStock.conStock,
                                  child: Text('Con stock')),
                              PopupMenuItem(
                                  value: FiltroStock.agotados,
                                  child: Text('Agotados')),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 56,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () => _abrirFormulario(),
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: EdgeInsets.zero,
                          backgroundColor: _rosa,
                          foregroundColor: Colors.black,
                        ),
                        child: const Icon(Icons.add),
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

class _ProductoForm extends StatefulWidget {
  final ProductoModel? producto;

  const _ProductoForm({this.producto});

  @override
  State<_ProductoForm> createState() => _ProductoFormState();
}

class _ProductoFormState extends State<_ProductoForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nombreCtrl =
      TextEditingController(text: widget.producto?.nombre ?? '');
  late final TextEditingController _descripcionCtrl =
      TextEditingController(text: widget.producto?.descripcion ?? '');
  late final TextEditingController _marcaCtrl =
      TextEditingController(text: widget.producto?.marca ?? '');
  late final TextEditingController _precioCtrl = TextEditingController(
      text: widget.producto == null ? '' : widget.producto!.precio.toString());
  late final TextEditingController _tallaCtrl = TextEditingController(
      text: widget.producto == null ? '' : widget.producto!.talla.toString());
  final _stockCtrl = TextEditingController();
  late int _estado = widget.producto?.estado ?? 1;

  bool _guardando = false;
  String? _error;

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _descripcionCtrl.dispose();
    _marcaCtrl.dispose();
    _precioCtrl.dispose();
    _tallaCtrl.dispose();
    _stockCtrl.dispose();
    super.dispose();
  }

  String? _requerido(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Campo obligatorio' : null;

  double? _leerPrecio() => double.tryParse(_precioCtrl.text.trim().replaceAll(',', '.'));

  String? _validarPrecio(String? v) {
    if (_requerido(v) != null) return 'Campo obligatorio';
    final n = _leerPrecio();
    return (n == null || n <= 0) ? 'Precio inválido' : null;
  }

  String? _validarEntero(String? v) {
    if (_requerido(v) != null) return 'Campo obligatorio';
    final n = int.tryParse(v!.trim());
    return (n == null || n <= 0) ? 'Debe ser mayor que 0' : null;
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _guardando = true;
      _error = null;
    });

    final provider = context.read<ProductosProvider>();
    final original = widget.producto;

    final producto = ProductoModel(
      codigo: original?.codigo ?? 0,
      nombre: _nombreCtrl.text.trim(),
      descripcion: _descripcionCtrl.text.trim(),
      marca: _marcaCtrl.text.trim(),
      precio: _leerPrecio()!,
      talla: int.parse(_tallaCtrl.text.trim()),
      estado: _estado,
      stock: original == null ? int.parse(_stockCtrl.text.trim()) : original.stock,
    );

    final error = original == null
        ? await provider.crear(producto)
        : await provider.actualizar(producto);

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
    final editando = widget.producto != null;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(editando ? 'Editar producto' : 'Nuevo producto',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TextFormField(
                controller: _nombreCtrl,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: _requerido,
              ),
              TextFormField(
                controller: _descripcionCtrl,
                decoration: const InputDecoration(labelText: 'Descripción'),
                validator: _requerido,
              ),
              TextFormField(
                controller: _marcaCtrl,
                decoration: const InputDecoration(labelText: 'Marca'),
                validator: _requerido,
              ),
              TextFormField(
                controller: _precioCtrl,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Precio'),
                validator: _validarPrecio,
              ),
              TextFormField(
                controller: _tallaCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Talla'),
                validator: _validarEntero,
              ),
              if (!editando)
                TextFormField(
                  controller: _stockCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Stock inicial'),
                  validator: _validarEntero,
                ),
              DropdownButtonFormField<int>(
                value: _estado,
                decoration: const InputDecoration(labelText: 'Estado'),
                items: const [
                  DropdownMenuItem(value: 1, child: Text('Activo')),
                  DropdownMenuItem(value: 2, child: Text('Inactivo')),
                ],
                onChanged: (v) => setState(() => _estado = v ?? 1),
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