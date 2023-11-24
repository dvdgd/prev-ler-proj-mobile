import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
import 'package:prev_ler/src/modules/routines/shared/repositories/routine_http_repository.dart';
import 'package:prev_ler/src/modules/routines/shared/routines_controller.dart';
import 'package:prev_ler/src/modules/routines/shared/routines_service.dart';
import 'package:prev_ler/src/modules/routines/shared/week_day_controller.dart';
import 'package:prev_ler/src/my_material_app.dart';
import 'package:prev_ler/src/shared/controllers/dark_mode_controller.dart';
import 'package:prev_ler/src/shared/controllers/user_controller.dart';
import 'package:prev_ler/src/shared/http/client_http.dart';
import 'package:prev_ler/src/shared/services/notification_service.dart';
import 'package:prev_ler/src/shared/services/user_service.dart';
import 'package:prev_ler/src/shared/utils/my_converter.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sup;

class Environment {
  static String get apiBaseUrl =>
      dotenv.get('API_BASE_URL', fallback: 'URL NOT FOUND');
  static String get supabaseUrl =>
      dotenv.get('SUPABASE_URL', fallback: 'URL NOT FOUND');
  static String get supabaseAnonKey =>
      dotenv.get('SUPABASE_ANON_KEY', fallback: 'URL NOT FOUND');
}

final supabaseClient = sup.Supabase.instance.client;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  await sup.Supabase.initialize(
    url: Environment.supabaseUrl,
    anonKey: Environment.supabaseAnonKey,
  );

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => MyConverter()),
        Provider(create: (_) => NotificationConfig()),
        Provider(
          create: (ctx) =>
              FlutterNotificationService(ctx.read<NotificationConfig>()),
        ),
        Provider(create: (ctx) => ClientHttp()),
        Provider(create: (ctx) => ContentsServiceImpl()),
        Provider(create: (ctx) => InjuriesServiceImpl()),
        Provider(create: (ctx) => RoutineHttpRepository()),
        Provider(
          create: (ctx) => ExercisesServiceImpl(ctx.read<MyConverter>()),
        ),
        Provider(
          create: (ctx) => UserService(),
        ),
        Provider(
          create: (ctx) => RoutinesServiceImpl(
            ctx.read<RoutineHttpRepository>(),
            ctx.read<FlutterNotificationService>(),
          ),
        ),
        Provider(create: (ctx) => NotificationServiceImp()),
        ChangeNotifierProvider(create: (_) => WeekDayController()),
        ChangeNotifierProvider(create: (_) => ExerciseCartController()),
        ChangeNotifierProvider(create: (_) => DarkModeController()),
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
