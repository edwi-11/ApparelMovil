class LogModel {
  final String id;
  final DateTime fecha;
  final String usuario;
  final String metodo;
  final String ruta;
  final String modulo;
  final int status;
  final double tiempoRespuestaMs;

  LogModel({
    required this.id,
    required this.fecha,
    required this.usuario,
    required this.metodo,
    required this.ruta,
    required this.modulo,
    required this.status,
    required this.tiempoRespuestaMs,
  });

  bool get exitoso => status < 400;

  String get etiquetaModulo => switch (modulo.toLowerCase()) {
        'cliente' => 'Clientes',
        'usuarios' => 'Usuarios',
        'productos' => 'Inventario',
        'ventas' => 'Ventas',
        'compras' => 'Compras',
        'login' => 'Sesión',
        'logs' => 'Logs',
        '' => 'General',
        _ => modulo,
      };

  String get descripcion {
    final r = ruta.toLowerCase();
    final m = metodo.toUpperCase();

    String? texto;

    if (r.contains('/login/')) {
      texto = 'Ingresó al sistema';
    } else if (r.contains('/cliente')) {
      texto = switch (m) {
        'GET' => r.contains('/telefono/')
            ? 'Buscó un cliente por teléfono'
            : 'Consultó los clientes',
        'POST' => 'Registró un cliente',
        'PUT' => 'Actualizó un cliente',
        'DELETE' => 'Eliminó un cliente',
        _ => null,
      };
    } else if (r.contains('/usuarios/')) {
      if (r.contains('darbaja')) {
        texto = 'Dio de baja a un usuario';
      } else if (r.contains('agregarusuario')) {
        texto = 'Registró un usuario';
      } else if (r.contains('actualizarusuario')) {
        texto = 'Actualizó un usuario';
      } else if (r.contains('verusuario')) {
        texto = 'Consultó un usuario';
      } else if (r.contains('obtenerusuarios')) {
        texto = 'Consultó los usuarios';
      }
    } else if (r.contains('/productos/')) {
      if (r.contains('insertarproducto')) {
        texto = 'Registró un producto';
      } else if (r.contains('actualizarproducto')) {
        texto = 'Actualizó un producto';
      } else if (r.contains('eliminarproducto')) {
        texto = 'Eliminó un producto';
      } else if (r.contains('obtenerstockactual')) {
        texto = 'Consultó el stock de un producto';
      } else if (r.contains('obtenertodosproductos')) {
        texto = 'Consultó el inventario';
      } else if (r.contains('obtenerproductos')) {
        texto = 'Consultó un producto';
      }
    } else if (r.contains('/ventas')) {
      texto = switch (m) {
        'GET' => 'Consultó las ventas',
        'POST' => 'Registró una venta',
        _ => null,
      };
    } else if (r.contains('/compras/')) {
      if (r.contains('insertardetallecompra')) {
        texto = 'Registró el detalle de una compra';
      } else if (r.contains('insertarcompra')) {
        texto = 'Registró una compra';
      } else if (r.contains('listarcompras')) {
        texto = 'Consultó las compras';
      }
    } else if (r.contains('/logs')) {
      texto = 'Consultó los logs';
    }

    // Si la ruta no está en la lista, se describe por el método.
    texto ??= switch (m) {
      'GET' => 'Consultó ${etiquetaModulo.toLowerCase()}',
      'POST' => 'Registró en ${etiquetaModulo.toLowerCase()}',
      'PUT' => 'Actualizó en ${etiquetaModulo.toLowerCase()}',
      'DELETE' => 'Eliminó en ${etiquetaModulo.toLowerCase()}',
      _ => 'Realizó una acción',
    };

    return exitoso ? texto : '$texto (falló)';
  }

  static LogModel fromJson(Map<String, dynamic> json) => LogModel(
        id: json['id']?.toString() ?? '',
        fecha: (DateTime.tryParse(json['fecha']?.toString() ?? '') ??
                DateTime.fromMillisecondsSinceEpoch(0))
            .toLocal(),
        usuario: json['usuario']?.toString() ?? 'Anónimo',
        metodo: json['metodo']?.toString() ?? '',
        ruta: json['ruta']?.toString() ?? '',
        modulo: json['modulo']?.toString() ?? '',
        status: (json['status'] as num?)?.toInt() ?? 0,
        tiempoRespuestaMs: (json['tiempoRespuestaMs'] as num?)?.toDouble() ?? 0,
      );
}

class LogsPagina {
  final List<LogModel> items;
  final int total;
  final int pagina;

  LogsPagina({
    required this.items,
    required this.total,
    required this.pagina,
  });
}