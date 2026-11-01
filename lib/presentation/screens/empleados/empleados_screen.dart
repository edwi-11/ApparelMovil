import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apparel_movil/data/models/user_models.dart';
import 'package:apparel_movil/presentation/providers/user_provider.dart';

class EmpleadosScreen extends StatefulWidget {
  const EmpleadosScreen({super.key});

  @override
  State<EmpleadosScreen> createState() => _EmpleadosScreenState();
}

class _EmpleadosScreenState extends State<EmpleadosScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UsuariosProvider>().cargar();
    });
  }

  String _nombreRol(int codRol, String respaldo) {
    switch (codRol) {
      case 1:
        return 'Admin';
      case 2:
        return 'Empleado';
      default:
        return respaldo.isNotEmpty && respaldo != 'N/A' ? respaldo : 'Sin rol';
    }
  }

  Future<void> _abrirFormulario({UsuarioModel? usuario}) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: _UsuarioForm(usuario: usuario),
      ),
    );
  }

  Future<void> _confirmarEliminar(UsuarioModel u) async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar usuario'),
        content: Text('¿Seguro que quieres eliminar a ${u.nombre} ${u.apellidos}?'),
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

    final provider = context.read<UsuariosProvider>();
    final ok = await provider.darDeBaja(u.codUsuario);

    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(provider.error ?? 'No se pudo eliminar')),
      );
    }
  }

  void _mostrarDetalle(UsuarioModel u) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${u.nombre} ${u.apellidos}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Usuario: ${u.usuarioLogin}'),
            Text('Cédula: ${u.cedula}'),
            Text('Rol: ${_nombreRol(u.codRol, u.rolNombre)}'),
            Text('Estado: ${u.estado == 1 ? 'Activo' : 'Inactivo'}'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(ctx);
                      _abrirFormulario(usuario: u);
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
                      _confirmarEliminar(u);
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

  Widget _tarjeta(UsuarioModel u) {
    final activo = u.estado == 1;

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
        width: 370,
        height: 70,
        child: ElevatedButton(
          onPressed: () => _mostrarDetalle(u),
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
                      '${u.nombre} ${u.apellidos}',
                      style: const TextStyle(color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      _nombreRol(u.codRol, u.rolNombre),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              Text(
                activo ? 'Activo' : 'Inactivo',
                style: TextStyle(color: activo ? Colors.green : Colors.red),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }

  Widget _contenido(UsuariosProvider p) {
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

    if (p.usuarios.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 40),
        child: SizedBox(
          width: double.infinity,
          child: Center(child: Text('No hay usuarios para mostrar.')),
        ),
      );
    }

    return Column(
      children: p.usuarios.map(_tarjeta).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<UsuariosProvider>();

    return RefreshIndicator(
      onRefresh: p.cargar,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Usuarios',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
              ),
              const Text('Administra a los usuarios del sistema'),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    SizedBox(
                      width: 310,
                      child: SearchBar(
                        hintText: 'Buscar Usuario',
                        leading: const Icon(Icons.search),
                        onChanged: p.setBusqueda,
                        trailing: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.filter_alt_rounded),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => _abrirFormulario(),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: const Color.fromARGB(255, 238, 181, 200),
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

class _UsuarioForm extends StatefulWidget {
  final UsuarioModel? usuario;

  const _UsuarioForm({this.usuario});

  @override
  State<_UsuarioForm> createState() => _UsuarioFormState();
}

class _UsuarioFormState extends State<_UsuarioForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nombreCtrl =
      TextEditingController(text: widget.usuario?.nombre ?? '');
  late final TextEditingController _apellidosCtrl =
      TextEditingController(text: widget.usuario?.apellidos ?? '');
  late final TextEditingController _loginCtrl =
      TextEditingController(text: widget.usuario?.usuarioLogin ?? '');
  late final TextEditingController _cedulaCtrl =
      TextEditingController(text: widget.usuario?.cedula ?? '');
  late final TextEditingController _passCtrl = TextEditingController();
  late int _rol = (widget.usuario?.codRol == 1 || widget.usuario?.codRol == 2)
      ? widget.usuario!.codRol
      : 2;

  bool _guardando = false;
  String? _error;

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _apellidosCtrl.dispose();
    _loginCtrl.dispose();
    _cedulaCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  String? _requerido(String? valor) =>
      (valor == null || valor.trim().isEmpty) ? 'Campo obligatorio' : null;

  String? _contrasena(String? valor) {
    if (widget.usuario != null) return null;
    return (valor == null || valor.isEmpty) ? 'Campo obligatorio' : null;
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _guardando = true;
      _error = null;
    });

    final provider = context.read<UsuariosProvider>();
    final original = widget.usuario;

    final modelo = UsuarioModel(
      codUsuario: original?.codUsuario ?? 0,
      nombre: _nombreCtrl.text.trim(),
      apellidos: _apellidosCtrl.text.trim(),
      usuarioLogin: _loginCtrl.text.trim(),
      cedula: _cedulaCtrl.text.trim(),
      codRol: _rol,
      rolNombre: _rol == 1 ? 'Admin' : 'Empleado',
      estado: original?.estado ?? 1,
      contrasena: _passCtrl.text.isEmpty ? null : _passCtrl.text,
    );

    final ok = original == null
        ? await provider.crear(modelo)
        : await provider.actualizar(modelo);

    if (!mounted) return;

    if (ok) {
      Navigator.pop(context);
    } else {
      setState(() {
        _guardando = false;
        _error = provider.error ?? 'No se pudo guardar';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final editando = widget.usuario != null;

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
                editando ? 'Editar usuario' : 'Nuevo usuario',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _nombreCtrl,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: _requerido,
              ),
              TextFormField(
                controller: _apellidosCtrl,
                decoration: const InputDecoration(labelText: 'Apellidos'),
                validator: _requerido,
              ),
              TextFormField(
                controller: _loginCtrl,
                decoration: const InputDecoration(labelText: 'Usuario'),
                validator: _requerido,
              ),
              TextFormField(
                controller: _cedulaCtrl,
                decoration: const InputDecoration(labelText: 'Cédula'),
                validator: _requerido,
              ),
              TextFormField(
                controller: _passCtrl,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: editando ? 'Nueva contraseña (opcional)' : 'Contraseña',
                ),
                validator: _contrasena,
              ),
              DropdownButtonFormField<int>(
                value: _rol,
                decoration: const InputDecoration(labelText: 'Rol'),
                items: const [
                  DropdownMenuItem(value: 1, child: Text('Admin')),
                  DropdownMenuItem(value: 2, child: Text('Empleado')),
                ],
                onChanged: (v) {
                  if (v != null) setState(() => _rol = v);
                },
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