import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prev_ler/src/config/hive_box_db_config.dart';
import 'package:prev_ler/src/config/notification_config.dart';
import 'package:prev_ler/src/modules/auth/shared/auth_controller.dart';
import 'package:prev_ler/src/modules/auth/shared/register_user_controller.dart';
import 'package:prev_ler/src/modules/contents/shared/contents_controller.dart';
import 'package:prev_ler/src/modules/contents/shared/contents_service.dart';
import 'package:prev_ler/src/modules/exercises/shared/exercises_controller.dart';
import 'package:prev_ler/src/modules/exercises/shared/exercises_service.dart';
import 'package:prev_ler/src/modules/injuries/shared/injuries_controller.dart';
import 'package:prev_ler/src/modules/injuries/shared/injuries_service.dart';
import 'package:prev_ler/src/modules/notifications/shared/notification_controller.dart';
import 'package:prev_ler/src/modules/notifications/shared/notification_service.dart';
import 'package:prev_ler/src/modules/routines/shared/exercise_cart_controller.dart';
import 'package:prev_ler/src/modules/routines/shared/repositories/routine_hive_repository.dart';
import 'package:prev_ler/src/modules/routines/shared/repositories/routine_http_repository.dart';
import 'package:prev_ler/src/modules/routines/shared/routines_controller.dart';
import 'package:prev_ler/src/modules/routines/shared/routines_service.dart';
import 'package:prev_ler/src/modules/routines/shared/week_day_controller.dart';
import 'package:prev_ler/src/my_material_app.dart';
import 'package:prev_ler/src/shared/controllers/dark_mode_controller.dart';
import 'package:prev_ler/src/shared/controllers/user_controller.dart';
import 'package:prev_ler/src/shared/database/services/cache_hive.dart';
import 'package:prev_ler/src/shared/http/cache_interceptor.dart';
import 'package:prev_ler/src/shared/http/client_http.dart';
import 'package:prev_ler/src/shared/services/check_internet.dart';
import 'package:prev_ler/src/shared/services/notification_service.dart';
import 'package:prev_ler/src/shared/services/secure_store.dart';
import 'package:prev_ler/src/shared/services/user_service.dart';
import 'package:prev_ler/src/shared/utils/my_converter.dart';
import 'package:provider/provider.dart';

class Environment {
  static String get apiBaseUrl =>
      dotenv.get('API_BASE_URL', fallback: 'URL NOT FOUND');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  final hiveBox = HiveBoxDbConfig();
  await hiveBox.initDb();

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => SecureStore(const FlutterSecureStorage())),
        Provider(create: (_) => CacheHive(hiveBox.cacheBox)),
        Provider(create: (_) => CheckInternet()),
        Provider(create: (_) => MyConverter()),
        Provider(create: (_) => RoutineHiveRepository(hiveBox.routineBox)),
        Provider(create: (_) => NotificationConfig()),
        Provider(
          create: (ctx) =>
              FlutterNotificationService(ctx.read<NotificationConfig>()),
        ),
        Provider(
          create: (ctx) => CacheInterceptor(
            cacheAdapter: ctx.read<CacheHive>(),
            checkInternet: ctx.read<CheckInternet>(),
          ),
        ),
        Provider(create: (ctx) => ClientHttp([ctx.read<CacheInterceptor>()])),
        Provider(create: (ctx) => ContentsServiceImpl(ctx.read<ClientHttp>())),
        Provider(create: (ctx) => InjuriesServiceImpl(ctx.read<ClientHttp>())),
        Provider(
          create: (ctx) => RoutineHttpRepository(ctx.read<ClientHttp>()),
        ),
        Provider(
          create: (ctx) => ExercisesServiceImpl(
            ctx.read<ClientHttp>(),
            ctx.read<MyConverter>(),
          ),
        ),
        Provider(
          create: (ctx) => UserService(
            ctx.read<ClientHttp>(),
            ctx.read<SecureStore>(),
          ),
        ),
        Provider(
          create: (ctx) => RoutinesServiceImpl(
            ctx.read<RoutineHttpRepository>(),
            ctx.read<FlutterNotificationService>(),
          ),
        ),
        Provider(
          create: (ctx) => NotificationServiceImp(ctx.read<ClientHttp>()),
        ),
        ChangeNotifierProvider(
          create: (_) => WeekDayController(),
        ),
        ChangeNotifierProvider(
          create: (_) => ExerciseCartController(),
        ),
        ChangeNotifierProvider(
          create: (_) => DarkModeController(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => UserController(ctx.read<UserService>()),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ExercisesController(
            ctx.read<ExercisesServiceImpl>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => AuthController(
            ctx.read<UserService>(),
            ctx.read<ClientHttp>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => RegisterUserController(
            ctx.read<UserService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => InjuriesController(ctx.read<InjuriesServiceImpl>()),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ContentsController(ctx.read<ContentsServiceImpl>()),
        ),
        ChangeNotifierProvider(
          create: (ctx) => RoutinesController(
            ctx.read<RoutinesServiceImpl>(),
            ctx.read<UserService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => NotificationController(
            ctx.read<NotificationServiceImp>(),
            ctx.read<UserService>(),
          ),
        ),
      ],
      child: const MyMaterialApp(),
    ),
  );
}
