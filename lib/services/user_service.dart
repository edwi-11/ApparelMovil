import 'package:apparel_movil/data/models/user_models.dart';
import 'package:apparel_movil/data/repositories/user_repository.dart';

class UsuariosService {
  final UsuariosRepository _usuariosRepository;

  UsuariosService(this._usuariosRepository);

  Future<List<UsuarioModel>> obtenerUsuarios() async {
    final usuarios = await _usuariosRepository.obtenerTodos();
    usuarios.sort((a, b) => a.nombre.toLowerCase().compareTo(b.nombre.toLowerCase()));
    return usuarios;
  }

  List<UsuarioModel> filtrar(List<UsuarioModel> usuarios, String texto) {
    final busqueda = texto.trim().toLowerCase();

    return usuarios.where((u) {
      return busqueda.isEmpty ||
          u.nombre.toLowerCase().contains(busqueda) ||
          u.apellidos.toLowerCase().contains(busqueda) ||
          u.usuarioLogin.toLowerCase().contains(busqueda) ||
          u.cedula.toLowerCase().contains(busqueda);
    }).toList();
  }

  Future<void> crear(UsuarioModel usuario) => _usuariosRepository.crear(usuario);

  Future<void> actualizar(UsuarioModel usuario) =>
      _usuariosRepository.actualizar(usuario);

  Future<void> darDeBaja(int codUsuario) =>
      _usuariosRepository.darDeBaja(codUsuario);
}