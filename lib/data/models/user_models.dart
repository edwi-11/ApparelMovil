class UsuarioModel {
  final int codUsuario;
  final String nombre;
  final String apellidos;
  final String usuarioLogin;
  final String cedula;
  final int codRol;
  final String rolNombre;
  final int estado;
  final String? contrasena;

  UsuarioModel({
    this.codUsuario = 0,
    required this.nombre,
    required this.apellidos,
    required this.usuarioLogin,
    required this.cedula,
    required this.codRol,
    this.rolNombre = 'N/A',
    required this.estado,
    this.contrasena,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        codUsuario: json['codUsuario'],
        nombre: json['nombre'],
        apellidos: json['apellidos'],
        usuarioLogin: json['usuarioLogin'],
        cedula: json['cedula'],
        codRol: json['codRol'] ?? 0,
        rolNombre: json['rolNombre'] ?? 'N/A',
        estado: json['estado'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'codUsuario': codUsuario,
        'nombre': nombre,
        'apellidos': apellidos,
        'usuarioLogin': usuarioLogin,
        'cedula': cedula,
        'codRol': codRol,
        'rolNombre': rolNombre,
        'estado': estado,
        'contraseña': contrasena ?? '',
      };
}