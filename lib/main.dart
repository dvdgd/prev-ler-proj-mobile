import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prev_ler/src/config/notification_config.dart';
import 'package:prev_ler/src/modules/auth/shared/auth_controller.dart';
import 'package:prev_ler/src/modules/auth/shared/register_user_controller.dart';
import 'package:prev_ler/src/modules/contents/shared/contents_controller.dart';
import 'package:prev_ler/src/modules/contents/shared/contents_service.dart';
import 'package:prev_ler/src/modules/exercises/shared/exercises_controller.dart';
import 'package:prev_ler/src/modules/exercises/shared/exercises_service.dart';
import 'package:prev_ler/src/modules/home/shared/lasts_contents_controller.dart';
import 'package:prev_ler/src/modules/home/shared/lasts_exercises_controller.dart';
import 'package:prev_ler/src/modules/injuries/shared/injuries_controller.dart';
import 'package:prev_ler/src/modules/injuries/shared/injuries_service.dart';
import 'package:prev_ler/src/modules/notifications/shared/notification_controller.dart';
import 'package:prev_ler/src/modules/notifications/shared/routine_notification_repository.dart';
import 'package:prev_ler/src/modules/routines/shared/controllers/exercise_cart_controller.dart';
import 'package:prev_ler/src/modules/routines/shared/controllers/routines_controller.dart';
import 'package:prev_ler/src/modules/routines/shared/controllers/week_day_controller.dart';
import 'package:prev_ler/src/modules/routines/shared/repositories/routine_repository.dart';
import 'package:prev_ler/src/modules/routines/shared/routines_service.dart';
import 'package:prev_ler/src/my_material_app.dart';
import 'package:prev_ler/src/shared/controllers/dark_mode_controller.dart';
import 'package:prev_ler/src/shared/controllers/user_controller.dart';
import 'package:prev_ler/src/shared/http/client_http.dart';
import 'package:prev_ler/src/shared/services/auth_service.dart';
import 'package:prev_ler/src/shared/services/notification_service.dart';
import 'package:prev_ler/src/shared/services/secure_store.dart';
import 'package:prev_ler/src/shared/services/user_service.dart';
import 'package:prev_ler/src/shared/utils/my_converter.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sup;

class Environment {
  static String get supabaseUrl =>
      dotenv.get('SUPABASE_URL', fallback: 'URL NOT FOUND');
  static String get supabaseAnonKey =>
      dotenv.get('SUPABASE_ANON_KEY', fallback: 'ANON KEY NOT FOUND');
}

final supabaseClient = sup.Supabase.instance.client;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  await sup.Supabase.initialize(
    url: Environment.supabaseUrl,
    anonKey: Environment.supabaseAnonKey,
    authFlowType: sup.AuthFlowType.implicit,
  );

  final secureStore = SecureStore(const FlutterSecureStorage());
  supabaseClient.auth.onAuthStateChange.listen((data) {
    final sup.AuthChangeEvent event = data.event;
    if (event == sup.AuthChangeEvent.tokenRefreshed) {
      secureStore.saveBearer(jsonEncode(data.session?.toJson()));
    }
  });

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => MyConverter()),
        Provider(create: (_) => NotificationConfig()),
        Provider(create: (_) => SecureStore(const FlutterSecureStorage())),
        Provider(
          create: (ctx) =>
              FlutterNotificationService(ctx.read<NotificationConfig>()),
        ),
        Provider(create: (_) => ClientHttp()),
        Provider(create: (_) => ContentsServiceImpl()),
        Provider(create: (_) => InjuriesServiceImpl()),
        Provider(
          create: (ctx) => RoutineNotificationRepository(),
        ),
        Provider(
          create: (ctx) => RoutineRepository(
            ctx.read<RoutineNotificationRepository>(),
          ),
        ),
        Provider(
          create: (ctx) => ExercisesServiceImpl(ctx.read<MyConverter>()),
        ),
        Provider(
          create: (ctx) => AuthService(
            userService: UserService(),
            secureStore: ctx.read(),
          ),
        ),
        Provider(
          create: (ctx) => RoutinesServiceImpl(
            ctx.read<RoutineRepository>(),
            ctx.read<FlutterNotificationService>(),
          ),
        ),
        Provider(create: (ctx) => ctx.read<RoutineNotificationRepository>()),
        ChangeNotifierProvider(create: (_) => WeekDayController()),
        ChangeNotifierProvider(create: (_) => ExerciseCartController()),
        ChangeNotifierProvider(create: (_) => DarkModeController()),
        ChangeNotifierProvider(
          create: (ctx) => LastsExercisesController(
            ctx.read<ExercisesServiceImpl>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => LastsContentsController(
            ctx.read<ContentsServiceImpl>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => UserController(ctx.read<AuthService>()),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ExercisesController(
            ctx.read<ExercisesServiceImpl>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => AuthController(
            ctx.read<AuthService>(),
            ctx.read<ClientHttp>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => RegisterUserController(
            ctx.read<AuthService>(),
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
            ctx.read<AuthService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => NotificationController(
            ctx.read<RoutineNotificationRepository>(),
            ctx.read<AuthService>(),
            ctx.read<RoutineRepository>(),
          ),
        ),
      ],
      child: const MyMaterialApp(),
    ),
  );
}
