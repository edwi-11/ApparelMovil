import 'package:apparel_movil/core/constants/api_constants.dart';
import 'package:apparel_movil/core/errors/app_exception.dart';
import 'package:apparel_movil/core/network/api_client.dart';
import 'package:apparel_movil/data/models/ventas_models.dart';

class VentasRepository {
  final ApiClient _apiClient;

  VentasRepository(this._apiClient);

  Future<List<VentaModel>> search() async {
    final json = await _apiClient.get(ApiConstants.ventas);

    if (json is! Map<String, dynamic>) throw ParsingException();
    if (json['success'] != true) {
      throw ServerException('No se pudieron obtener las ventas.');
    }

    final data = json['data'];
    if (data is! List) throw ParsingException();

    return data
        .map((e) => VentaModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}