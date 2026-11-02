import 'package:apparel_movil/data/models/logs_models.dart';
import 'package:apparel_movil/data/repositories/logs_repository.dart';

class LogsService {
  final LogsRepository _logsRepository;

  LogsService(this._logsRepository);

  Future<LogsPagina> obtenerLogs({
    required int pagina,
    required int tamanoPagina,
    String texto = '',
    String? modulo,
    String? metodo,
  }) {
    return _logsRepository.obtener(
      pagina: pagina,
      tamanoPagina: tamanoPagina,
      texto: texto.trim(),
      modulo: modulo,
      metodo: metodo,
    );
  }
}