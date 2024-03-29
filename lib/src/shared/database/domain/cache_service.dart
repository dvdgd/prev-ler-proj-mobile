import 'package:prev_ler/src/shared/database/domain/cache_model.dart';

abstract class ICacheAdapter {
  Future<CacheModel?> get(String id);
  Future<void> put(CacheModel data);
}
