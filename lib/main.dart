import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prev_ler/src/modules/auth/auth_controller.dart';
import 'package:prev_ler/src/modules/contents/shared/contents_controller.dart';
import 'package:prev_ler/src/modules/contents/shared/contents_service.dart';
import 'package:prev_ler/src/modules/injuries/shared/injuries_controller.dart';
import 'package:prev_ler/src/modules/injuries/shared/injuries_service.dart';
import 'package:prev_ler/src/modules/register_user/register_user_controller.dart';
import 'package:prev_ler/src/my_material_app.dart';
import 'package:prev_ler/src/shared/controllers/dark_mode_controller.dart';
import 'package:prev_ler/src/shared/controllers/user_controller.dart';
import 'package:prev_ler/src/shared/http/client_http.dart';
import 'package:prev_ler/src/shared/services/secure_store.dart';
import 'package:prev_ler/src/shared/services/user_service.dart';
import 'package:provider/provider.dart';

class Environment {
  static String get apiBaseUrl =>
      dotenv.get('API_BASE_URL', fallback: 'URL NOT FOUND');
}

void main() async {
  await dotenv.load(fileName: '.env');

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => SecureStore(const FlutterSecureStorage())),
        Provider(create: (_) => ClientHttp()),
        Provider(create: (ctx) => UserService(ctx.read(), ctx.read())),
        Provider(create: (ctx) => ContentsServiceImpl(ctx.read())),
        Provider(create: (ctx) => InjuriesServiceImpl(ctx.read())),
        ChangeNotifierProvider(
          create: (_) => DarkModeController(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => UserController(ctx.read<UserService>()),
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
