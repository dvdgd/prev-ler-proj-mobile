import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prev_ler/src/modules/auth/shared/auth_controller.dart';
import 'package:prev_ler/src/modules/auth/shared/register_user_controller.dart';
import 'package:prev_ler/src/modules/contents/shared/contents_controller.dart';
import 'package:prev_ler/src/modules/contents/shared/contents_service.dart';
import 'package:prev_ler/src/modules/exercises/shared/exercises_controller.dart';
import 'package:prev_ler/src/modules/exercises/shared/exercises_service.dart';
import 'package:prev_ler/src/modules/injuries/shared/injuries_controller.dart';
import 'package:prev_ler/src/modules/injuries/shared/injuries_service.dart';
import 'package:prev_ler/src/modules/routines/shared/exercise_cart_controller.dart';
import 'package:prev_ler/src/my_material_app.dart';
import 'package:prev_ler/src/shared/cache/cache_hive.dart';
import 'package:prev_ler/src/shared/controllers/dark_mode_controller.dart';
import 'package:prev_ler/src/shared/controllers/user_controller.dart';
import 'package:prev_ler/src/shared/database/box_container.dart';
import 'package:prev_ler/src/shared/http/cache_interceptor.dart';
import 'package:prev_ler/src/shared/http/client_http.dart';
import 'package:prev_ler/src/shared/services/check_internet.dart';
import 'package:prev_ler/src/shared/services/file_converter.dart';
import 'package:prev_ler/src/shared/services/secure_store.dart';
import 'package:prev_ler/src/shared/services/user_service.dart';
import 'package:provider/provider.dart';

class Environment {
  static String get apiBaseUrl =>
      dotenv.get('API_BASE_URL', fallback: 'URL NOT FOUND');
}

void main() async {
  await dotenv.load(fileName: '.env');
  final hiveBox = HiveBoxContainer();
  await hiveBox.initDb();

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => SecureStore(const FlutterSecureStorage())),
        Provider(create: (_) => CacheHive(hiveBox.cacheBox)),
        Provider(create: (_) => CheckInternet()),
        Provider(create: (_) => FileConverter()),
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
          create: (ctx) => ExercisesServiceImpl(
            ctx.read<ClientHttp>(),
            ctx.read<FileConverter>(),
          ),
        ),
        Provider(
          create: (ctx) => UserService(
            ctx.read<ClientHttp>(),
            ctx.read<SecureStore>(),
          ),
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
      ],
      child: const MyMaterialApp(),
    ),
  );
}
