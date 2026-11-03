class ProductoModel {
  final int codigo;
  final String nombre;
  final String descripcion;
  final String marca;
  final double precio;
  final String talla;
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

  bool get activo => estado == 1;

  String get estadoTexto => activo ? 'Activo' : 'Inactivo';

  ProductoModel copyWith({
    int? codigo,
    String? nombre,
    String? descripcion,
    String? marca,
    double? precio,
    String? talla,
    int? estado,
    int? stock,
  }) =>
      ProductoModel(
        codigo: codigo ?? this.codigo,
        nombre: nombre ?? this.nombre,
        descripcion: descripcion ?? this.descripcion,
        marca: marca ?? this.marca,
        precio: precio ?? this.precio,
        talla: talla ?? this.talla,
        estado: estado ?? this.estado,
        stock: stock ?? this.stock,
      );

  static ProductoModel fromJson(Map<String, dynamic> json) => ProductoModel(
        codigo: (json['codigoProducto'] as num?)?.toInt() ?? 0,
        nombre: json['nombre']?.toString() ?? '',
        descripcion: json['descripcion']?.toString() ?? '',
        marca: json['marca']?.toString() ?? '',
        precio: (json['precio'] as num?)?.toDouble() ?? 0,
        talla: json['talla']?.toString() ?? '',
        estado: (json['estado'] as num?)?.toInt() ?? 0,
        stock: (json['stock'] as num?)?.toInt() ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'codigoProducto': codigo,
        'nombre': nombre,
        'descripcion': descripcion,
        'marca': marca,
        'precio': precio,
        'talla': talla,
        'estado': estado,
        'stock': stock,
      };
}