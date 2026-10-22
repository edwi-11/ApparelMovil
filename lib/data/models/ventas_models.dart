class VentaModel {
  final int id;
  final DateTime fecha;
  final double total;
  final String estado;
  final String cliente;
  final String usuario;

  VentaModel({
    required this.id,
    required this.fecha,
    required this.total,
    required this.estado,
    required this.cliente,
    required this.usuario,
  });

  static VentaModel fromJson(Map<String, dynamic> json) {
    return VentaModel(
      id: json['codVenta'],
      fecha: DateTime.parse(json['fecha']),
      total: (json['total'] as num).toDouble(),
      estado: json['estado'],
      cliente: json['cliente'],
      usuario: json['usuario'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codVenta': id,
      'fecha': fecha.toIso8601String(),
      'total': total,
      'estado': estado,
      'cliente': cliente,
      'usuario': usuario,
    };
  }
}