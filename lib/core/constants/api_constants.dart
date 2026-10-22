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
  static String clientePorTelefono(int telefono) =>'/api/Cliente/telefono/$telefono';
  static String actualizarCliente(int id) => '/api/Cliente/$id';
  static String eliminarCliente(int id) => '/api/Cliente/$id';

  // Usuarios
  static const String usuarios = '/api/Usuarios/ObtenerUsuarios';
  static const String agregarUsuario = '/api/Usuarios/AgregarUsuario';
  static String verUsuario(int cod) => '/api/Usuarios/VerUsuario/$cod';
  static String actualizarUsuario(int cod) =>'/api/Usuarios/ActualizarUsuario/$cod';
  static String darBajaUsuario(int cod) =>'/api/Usuarios/DarBajaUsuario/$cod';

  // Productos
  static const String productos = '/api/Productos/ObtenerTodosProductos';
  static const String insertarProducto = '/api/Productos/InsertarProducto';
  static String productoPorCodigo(int codigo) =>'/api/Productos/ObtenerProductos/$codigo';
  static String stockActual(int codigo) =>'/api/Productos/ObtenerStockActual/$codigo';
  static String actualizarProducto(int codigo) =>'/api/Productos/ActualizarProducto/$codigo';
  static String eliminarProducto(int codigo) =>'/api/Productos/EliminarProducto/$codigo';

  // Ventas 
  static const String ventas = '/api/Ventas/ListarVentas';
 
  static const Duration timeoutDuration = Duration(seconds: 15);
}