sealed class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

/// Sin conexión, falla de DNS, timeout, etc.
class NetworkException extends AppException {
  const NetworkException([super.message = 'Revisa tu conexión a internet.']);
}

/// El servidor respondió con un código que no es 2xx.
class ServerException extends AppException {
  const ServerException(super.message, {this.statusCode});

  final int? statusCode;
}

/// El body de la respuesta no se pudo convertir a nuestros modelos.
class ParsingException extends AppException {
  const ParsingException([super.message = 'Formato de respuesta inesperado.']);
}

/// La sesión expiró o el token no es válido (401).
class UnauthorizedException extends AppException {
  const UnauthorizedException(
      [super.message = 'Tu sesión expiró. Inicia sesión de nuevo.']);
}