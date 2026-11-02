import 'package:apparel_movil/core/constants/api_constants.dart';
import 'package:apparel_movil/core/errors/app_exception.dart';
import 'package:apparel_movil/core/network/api_client.dart';
import 'package:apparel_movil/data/models/logs_models.dart';

class LogsRepository {
  final ApiClient _apiClient;

  LogsRepository(this._apiClient);

  Future<LogsPagina> obtener({
    required int pagina,
    required int tamanoPagina,
    String? texto,
    String? modulo,
    String? metodo,
  }) async {
    final query = <String, String>{
      'pagina': '$pagina',
      'tamanoPagina': '$tamanoPagina',
      if (texto != null && texto.isNotEmpty) 'texto': texto,
      if (modulo != null && modulo.isNotEmpty) 'modulo': modulo,
      if (metodo != null && metodo.isNotEmpty) 'metodo': metodo,
    };

    final json = await _apiClient.get(ApiConstants.logs, query: query);

    if (json is! Map<String, dynamic>) throw const ParsingException();
    if (json['success'] == false) {
      throw const ServerException('No se pudieron obtener los logs.');
    }

    final data = json['data'];
    if (data is! List) throw const ParsingException();

    return LogsPagina(
      items: data
          .map((e) => LogModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toInt() ?? 0,
      pagina: (json['pagina'] as num?)?.toInt() ?? pagina,
    );
  }
}