import 'package:apparel_movil/data/models/user_models.dart';
import 'package:apparel_movil/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

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

  
// menu de opciones para cada usuario
  void _mostrarOpciones(UsuarioModel u) {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${u.nombre} ${u.apellidos}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Usuario: ${u.usuarioLogin}'),
            Text('Cédula: ${u.cedula}'),
            Text('Rol: ${_nombreRol(u.codRol, u.rolNombre)}'), // CAMBIO ROL
            Text('Estado: ${u.estado == 1 ? 'Activo' : 'Inactivo'}'),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // lápiz = editar
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.pop(sheetContext);
                    _editar(u);
                  },
                ),
                const SizedBox(width: 8),
                // botón eliminar
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(sheetContext);
                    _confirmarEliminar(u);
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text('Eliminar'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

// Avisa si elimina o no el usuario
  Future<void> _confirmarEliminar(UsuarioModel u) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Eliminar usuario'),
        content: Text('¿Seguro que quieres eliminar a ${u.nombre} ${u.apellidos}?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: const Text('Cancelar')),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmar != true || !mounted) return;

    final provider = context.read<UsuariosProvider>();
    final ok = await provider.darDeBaja(u.codUsuario);
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(ok ? 'Usuario eliminado' : (provider.error ?? 'No se pudo eliminar'))),
    );
  }

  //formulario para crear un usuario
  void _crear() {
    final nombre = TextEditingController();
    final apellidos = TextEditingController();
    final login = TextEditingController();
    final cedula = TextEditingController();
    final pass = TextEditingController();
    int rolSeleccionado = 2;

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (ctx, setStateDialog) => AlertDialog(
          title: const Text('Nuevo usuario'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: nombre, decoration: const InputDecoration(labelText: 'Nombre')),
                TextField(controller: apellidos, decoration: const InputDecoration(labelText: 'Apellidos')),
                TextField(controller: login, decoration: const InputDecoration(labelText: 'Usuario')),
                TextField(controller: cedula, decoration: const InputDecoration(labelText: 'Cédula')),
                TextField(
                  controller: pass,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Contraseña'),
                ),
                DropdownButtonFormField<int>(
                  value: rolSeleccionado,
                  decoration: const InputDecoration(labelText: 'Rol'),
                  items: const [
                    DropdownMenuItem(value: 1, child: Text('Admin')),
                    DropdownMenuItem(value: 2, child: Text('Empleado')),
                  ],
                  onChanged: (v) {
                    if (v != null) setStateDialog(() => rolSeleccionado = v);
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () async {
                if (nombre.text.trim().isEmpty ||
                    login.text.trim().isEmpty ||
                    pass.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Nombre, usuario y contraseña son obligatorios')),
                  );
                  return;
                }

                final nuevo = UsuarioModel(
                  codUsuario: 0,
                  nombre: nombre.text.trim(),
                  apellidos: apellidos.text.trim(),
                  usuarioLogin: login.text.trim(),
                  cedula: cedula.text.trim(),
                  codRol: rolSeleccionado,
                  rolNombre: _nombreRol(rolSeleccionado, ''),
                  estado: 1,
                  contrasena: pass.text,
                );

                final provider = context.read<UsuariosProvider>();
                final ok = await provider.crear(nuevo);
                debugPrint('JSON ENVIADO: ${jsonEncode(nuevo.toJson())}');

                if (dialogContext.mounted && ok) Navigator.pop(dialogContext);
                if (!mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(ok ? 'Usuario creado' : (provider.error ?? 'No se pudo crear'))),
                );
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  void _editar(UsuarioModel u) {
  final nombre = TextEditingController(text: u.nombre);
  final apellidos = TextEditingController(text: u.apellidos);
  final login = TextEditingController(text: u.usuarioLogin);
  final cedula = TextEditingController(text: u.cedula);
  final rol = TextEditingController(text: u.codRol > 0 ? u.codRol.toString() : '');
  final estado = TextEditingController(text: u.estado > 0 ? u.estado.toString() : '1');
  final pass = TextEditingController();

  showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Editar usuario'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nombre, decoration: const InputDecoration(labelText: 'Nombre')),
            TextField(controller: apellidos, decoration: const InputDecoration(labelText: 'Apellidos')),
            TextField(controller: login, decoration: const InputDecoration(labelText: 'Usuario')),
            TextField(controller: cedula, decoration: const InputDecoration(labelText: 'Cédula')),
            TextField(
              controller: rol,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Código de rol (mayor a 0)'),
            ),
            TextField(
              controller: estado,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Estado (mayor a 0)'),
            ),
            TextField(
              controller: pass,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Nueva contraseña (opcional)'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () async {
            final codRol = int.tryParse(rol.text.trim()) ?? 0;
            final est = int.tryParse(estado.text.trim()) ?? 0;

            if (codRol <= 0 || est <= 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('El rol y el estado deben ser mayores a 0')),
              );
              return;
            }

            final actualizado = UsuarioModel(
              codUsuario: u.codUsuario,
              nombre: nombre.text.trim(),
              apellidos: apellidos.text.trim(),
              usuarioLogin: login.text.trim(),
              cedula: cedula.text.trim(),
              codRol: codRol,
              rolNombre: _nombreRol(codRol, u.rolNombre), // CAMBIO ROL
              estado: est,
              contrasena: pass.text.isEmpty ? null : pass.text,
            );

            final provider = context.read<UsuariosProvider>();
            final ok = await provider.actualizar(actualizado);

            if (dialogContext.mounted && ok) Navigator.pop(dialogContext);
            if (!mounted) return;

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(ok ? 'Usuario actualizado' : (provider.error ?? 'No se pudo actualizar'))),
            );
          },
          child: const Text('Guardar'),
        ),
      ],
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UsuariosProvider>();

      return SingleChildScrollView(
child: Column(


  children: [
    Padding(
    padding: const EdgeInsets.only(left:10, top:30),
child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
    
    children:[ 
      
      const Text ('Usuarios', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
      const Text ('Administra a los usuarios del sistema'),
      Padding(padding: const 
      EdgeInsets.only(top:20),
     child: Row( 
        children: [
      SizedBox(width: 310,
      child: SearchBar(
        hintText: ('Buscar Usuario'),
        leading:  Icon (Icons.search),
        onChanged: provider.setBusqueda,
        trailing: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.filter_alt_rounded)),
        ],
        ),
      ),
       const SizedBox(width: 10,),
      SizedBox(
        width: 50,
        height: 50,
        child: ElevatedButton(
          onPressed: _crear,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: Color.fromARGB(255, 238, 181, 200),
            foregroundColor: Colors.black,
          ),
          child: const Icon(Icons.add),
        ),
      ),
        ]
      )
      ),

if (provider.cargando)
  const Padding(
    padding: EdgeInsets.only(top:40),
    child: SizedBox(
      width: 370,
      child: Center(child: CircularProgressIndicator()),
    ),
  ),

if (provider.error != null)
  Padding(
    padding: const EdgeInsets.only(top:40),
    child: SizedBox(
      width: 370,
      child: Column(
        children: [
          Text(provider.error!, textAlign: TextAlign.center, style: const TextStyle(color: Colors.red)),
          const SizedBox(height: 12,),
          FilledButton(onPressed: provider.cargar, child: const Text('Reintentar')),
        ],
      ),
    ),
  ),

if (!provider.cargando && provider.error == null && provider.usuarios.isEmpty)
  const Padding(
    padding: EdgeInsets.only(top:40),
    child: SizedBox(
      width: 370,
      child: Center(child: Text('No hay usuarios')),
    ),
  ),

if (!provider.cargando && provider.error == null)
  ...provider.usuarios.map((u) => Padding(
  padding: const EdgeInsets.only(top:20),
  child: SizedBox(
    width: 370,
    height:70,
    child: ElevatedButton(onPressed: () => _mostrarOpciones(u), 
    child: Row(
      children: [
        const Icon(Icons.account_circle, size: 40, color:(Color.fromARGB(255, 245, 120, 162)),),

        
        const SizedBox(width: 15,),

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text ('${u.nombre} ${u.apellidos}', style: const TextStyle(color:(Colors.black)),),
            Text (_nombreRol(u.codRol, u.rolNombre), style: const TextStyle(color:(Colors.black),),), // CAMBIO ROL
          ],
        ),

        const Spacer(),

        Text(u.estado == 1 ? 'Activo' : 'Inactivo', style: TextStyle(color: u.estado == 1 ? Colors.green : Colors.red)),

        const Spacer(),
         
        const Icon(Icons.chevron_right)

      ],
    ),
    
  )
  
  ),
)),

    ]
  ),
    ),
  ],

),

      );
  }
}