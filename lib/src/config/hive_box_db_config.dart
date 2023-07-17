import 'package:hive_flutter/hive_flutter.dart';
import 'package:prev_ler/src/shared/database/hive/cache_model_database.dart';
import 'package:prev_ler/src/shared/database/hive/routine_model_database.dart';

class HiveBoxDbConfig {
  late final Box<CacheModelDatabase> cacheBox;
  late final Box<RoutineModelDatabase> routineBox;

  Future initDb() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CacheModelDatabaseAdapter());
    Hive.registerAdapter(RoutineModelDatabaseAdapter());

    cacheBox = await Hive.openBox<CacheModelDatabase>('cacheBox');
    routineBox = await Hive.openBox<RoutineModelDatabase>('routineBox');
  }
}
