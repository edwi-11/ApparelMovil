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