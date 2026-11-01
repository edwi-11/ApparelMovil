import 'package:apparel_movil/core/constants/api_constants.dart';
import 'package:apparel_movil/core/errors/app_exception.dart';
import 'package:apparel_movil/core/network/api_client.dart';
import 'package:apparel_movil/data/models/clientes_models.dart';

class ClientesRepository {
  final ApiClient _apiClient;

  ClientesRepository(this._apiClient);

  Future<List<ClienteModel>> search([Map<String, String>? params]) async {
    final json = await _apiClient.get(ApiConstants.clientes, query: params);
    final data = _extraerLista(json);

    return data
        .map((e) => ClienteModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> create(ClienteModel cliente) async {
    await _apiClient.post(ApiConstants.clientes, body: cliente.toJson());
  }

  Future<void> update(ClienteModel cliente) async {
    await _apiClient.put(
      ApiConstants.actualizarCliente(cliente.codCliente),
      body: cliente.toJson(),
    );
  }

  Future<void> delete(int id) async {
    await _apiClient.delete(ApiConstants.eliminarCliente(id));
  }

  List<dynamic> _extraerLista(dynamic json) {
    if (json is List) return json;

    if (json is Map<String, dynamic>) {
      if (json['success'] == false) {
        throw ServerException('No se pudieron obtener los clientes.');
      }
      final data = json['data'];
      if (data is List) return data;
    }

    throw ParsingException();
  }
}