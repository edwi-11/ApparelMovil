class DetalleVentaModel {
  final int codDetalleVenta;
  final int codVenta;
  final int codigoProducto;
  final int cantidad;
  final double precioUnitario;
  final double descuento;
  final double subtotal;

  DetalleVentaModel({
    required this.codDetalleVenta,
    required this.codVenta,
    required this.codigoProducto,
    required this.cantidad,
    required this.precioUnitario,
    required this.descuento,
    required this.subtotal,
  });

  static DetalleVentaModel fromJson(Map<String, dynamic> json) {
    return DetalleVentaModel(
      codDetalleVenta: json['codDetalleVenta'],
      codVenta: json['codVenta'],
      codigoProducto: json['codigoProducto'],
      cantidad: json['cantidad'],
      precioUnitario: (json['precioUnitario'] as num).toDouble(),
      descuento: (json['descuento'] as num).toDouble(),
      subtotal: (json['subtotal'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codDetalleVenta': codDetalleVenta,
      'codVenta': codVenta,
      'codigoProducto': codigoProducto,
      'cantidad': cantidad,
      'precioUnitario': precioUnitario,
      'descuento': descuento,
      'subtotal': subtotal,
    };
  }
}

class VentaModel {
  final int codVenta;
  final int codCliente;
  final int codUsuario;
  final DateTime fechaVenta;
  final double total;
  final List<DetalleVentaModel> detalles;

  VentaModel({
    required this.codVenta,
    required this.codCliente,
    required this.codUsuario,
    required this.fechaVenta,
    required this.total,
    required this.detalles,
  });

  static VentaModel fromJson(Map<String, dynamic> json) {
    return VentaModel(
      codVenta: json['codVenta'],
      codCliente: json['codCliente'],
      codUsuario: json['codUsuario'],
      fechaVenta: DateTime.parse(json['fechaVenta']),
      total: (json['total'] as num).toDouble(),
      detalles: (json['detalles'] as List? ?? [])
          .map((e) => DetalleVentaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codVenta': codVenta,
      'codCliente': codCliente,
      'codUsuario': codUsuario,
      'fechaVenta': fechaVenta.toIso8601String(),
      'total': total,
      'detalles': detalles.map((d) => d.toJson()).toList(),
    };
  }
}