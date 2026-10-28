import 'package:apparel_movil/data/models/clientes_models.dart';
import 'package:apparel_movil/data/repositories/clientes_repository.dart';

class ClientesService {
  final ClientesRepository _clientesRepository;

  ClientesService(this._clientesRepository);

  Future<List<ClienteModel>> obtenerClientes() async {
    final clientes = await _clientesRepository.search();
    clientes.sort(
      (a, b) => a.nombreCompleto
          .toLowerCase()
          .compareTo(b.nombreCompleto.toLowerCase()),
    );
    return clientes;
  }

  List<ClienteModel> filtrar(List<ClienteModel> clientes, String texto) {
    final busqueda = texto.trim().toLowerCase();
    if (busqueda.isEmpty) return clientes;

    return clientes.where((c) {
      return c.nombreCompleto.toLowerCase().contains(busqueda) ||
          c.cedula.toLowerCase().contains(busqueda) ||
          c.numeroTelefono.toString().contains(busqueda);
    }).toList();
  }

  Future<void> crear({
    required String nombre,
    required String apellido,
    required String telefono,
    required String cedula,
  }) async {
    final cliente = _construir(
      nombre: nombre,
      apellido: apellido,
      telefono: telefono,
      cedula: cedula,
    );
    await _clientesRepository.create(cliente);
  }

  Future<void> actualizar(
    ClienteModel original, {
    required String nombre,
    required String apellido,
    required String telefono,
    required String cedula,
  }) async {
    final cliente = _construir(
      codCliente: original.codCliente,
      numeroCompra: original.numeroCompra,
      nombre: nombre,
      apellido: apellido,
      telefono: telefono,
      cedula: cedula,
    );
    await _clientesRepository.update(cliente);
  }

  Future<void> eliminar(int id) async {
    await _clientesRepository.delete(id);
  }

  ClienteModel _construir({
    int codCliente = 0,
    int numeroCompra = 0,
    required String nombre,
    required String apellido,
    required String telefono,
    required String cedula,
  }) {
    final trimmedNombre = nombre.trim();
    final trimmedApellido = apellido.trim();
    final trimmedTelefono = telefono.trim();
    final trimmedCedula = cedula.trim();

    if (trimmedNombre.isEmpty || trimmedApellido.isEmpty) {
      throw const FormatException('El nombre y el apellido son obligatorios.');
    }

    if (!RegExp(r'^\d{8}$').hasMatch(trimmedTelefono)) {
      throw const FormatException('El teléfono debe tener 8 dígitos.');
    }

    if (trimmedCedula.isEmpty) {
      throw const FormatException('La cédula es obligatoria.');
    }

    return ClienteModel(
      codCliente: codCliente,
      numeroCompra: numeroCompra,
      nombre: trimmedNombre,
      apellido: trimmedApellido,
      numeroTelefono: int.parse(trimmedTelefono),
      cedula: trimmedCedula,
    );
  }
}