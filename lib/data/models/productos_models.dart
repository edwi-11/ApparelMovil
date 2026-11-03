class ProductoModel {
  final int codigo;
  final String nombre;
  final String descripcion;
  final String marca;
  final double precio;
  final int talla;
  final int estado;
  final int stock;

  ProductoModel({
    required this.codigo,
    required this.nombre,
    required this.descripcion,
    required this.marca,
    required this.precio,
    required this.talla,
    required this.estado,
    required this.stock,
  });

  bool get agotado => stock <= 0;

  String get estadoTexto => estado == 1 ? 'Activo' : 'Inactivo';

  static ProductoModel fromJson(Map<String, dynamic> json) => ProductoModel(
        codigo: (json['codigoProducto'] as num?)?.toInt() ?? 0,
        nombre: json['nombre']?.toString() ?? '',
        descripcion: json['descripcion']?.toString() ?? '',
        marca: json['marca']?.toString() ?? '',
        precio: (json['precio'] as num?)?.toDouble() ?? 0,
        talla: (json['talla'] as num?)?.toInt() ?? 0,
        estado: (json['estado'] as num?)?.toInt() ?? 0,
        stock: (json['stock'] as num?)?.toInt() ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'codigoProducto': codigo,
        'nombre': nombre,
        'descripcion': descripcion,
        'precio': precio,
        'talla': talla,
        'estado': estado,
        'stock': stock,
        'marca': marca,
      };
}