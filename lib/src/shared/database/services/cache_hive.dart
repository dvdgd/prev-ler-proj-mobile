import 'dart:async';

import 'package:hive_flutter/adapters.dart';
import 'package:prev_ler/src/shared/database/domain/cache_model.dart';
import 'package:prev_ler/src/shared/database/domain/cache_service.dart';
import 'package:prev_ler/src/shared/database/hive/cache_model_database.dart';

class CacheHive implements ICacheAdapter {
  final Box<CacheModelDatabase> box;

  CacheHive(this.box);

  @override
  Future<void> put(CacheModel cache) async {
    final data = CacheModelDatabase(id: cache.id, data: cache.data);
    await box.put(cache.id, data);
  }

  @override
  Future<CacheModel?> get(String id) async {
    final cacheData = box.get(id);

    if (cacheData == null) return null;

    return CacheModel(
      id: cacheData.id,
      data: cacheData.data,
      date: cacheData.date,
    );
  }
}
