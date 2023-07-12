import 'package:hive_flutter/hive_flutter.dart';
import 'package:prev_ler/src/shared/database/hive/cache_model_database.dart';

class HiveBoxContainer {
  late final Box<CacheModelDatabase> cacheBox;

  Future initDb() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CacheModelDatabaseAdapter());

    cacheBox = await Hive.openBox<CacheModelDatabase>('cacheBox');
  }
}
