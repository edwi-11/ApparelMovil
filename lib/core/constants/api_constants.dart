import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  String get baseUrl => dotenv.env['BASE_API_URL'] ?? 'default url';
  String get environment => dotenv.env['ENVIRONMENT'] ?? 'default environment';

  ApiConstants._privateConstructor();
  static final ApiConstants _instance = ApiConstants._privateConstructor();
  static ApiConstants get instance => _instance;

  // Login
  static const String login = '/api/login/IniciarSesion';

  // Clientes
  static const String clientes = '/api/Cliente';
  static String clientePorId(int id) => '/api/Cliente/$id';
  static String clientePorTelefono(int telefono) => '/api/Cliente/telefono/$telefono';

  // Usuarios
  static const String usuarios = '/api/Usuarios/ObtenerUsuarios';
  static const String agregarUsuario = '/api/Usuarios/AgregarUsuario';
  static String verUsuario(int cod) => '/api/Usuarios/VerUsuario/$cod';
  static String actualizarUsuario(int cod) => '/api/Usuarios/ActualizarUsuario/$cod';
  static String darBajaUsuario(int cod) => '/api/Usuarios/DarBajaUsuario/$cod';

  // Ventas
  static const String ventas = '/api/Ventas/ListarVentas';
}