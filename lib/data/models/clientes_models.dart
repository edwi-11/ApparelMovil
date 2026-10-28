class ClienteModel {
  final int codCliente;
  final int numeroCompra;
  final String nombre;
  final String apellido;
  final int numeroTelefono;
  final String cedula;

  ClienteModel({
    required this.codCliente,
    required this.numeroCompra,
    required this.nombre,
    required this.apellido,
    required this.numeroTelefono,
    required this.cedula,
  });

  String get nombreCompleto => '$nombre $apellido';

  static ClienteModel fromJson(Map<String, dynamic> json) => ClienteModel(
        codCliente: json['codCliente'] ?? 0,
        numeroCompra: json['numeroCompra'] ?? 0,
        nombre: json['nombre'] ?? '',
        apellido: json['apellido'] ?? '',
        numeroTelefono: json['numeroTelefono'] ?? 0,
        cedula: json['cedula'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'codCliente': codCliente,
        'numeroCompra': numeroCompra,
        'nombre': nombre,
        'apellido': apellido,
        'numeroTelefono': numeroTelefono,
        'cedula': cedula,
      };
}