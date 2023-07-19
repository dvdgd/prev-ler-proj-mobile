import 'package:flutter/widgets.dart';
import 'package:prev_ler/src/modules/auth/pages/check_user_state.dart';
import 'package:prev_ler/src/modules/auth/pages/user_register_page.dart';
import 'package:prev_ler/src/modules/contents/pages/content_form_page.dart';
import 'package:prev_ler/src/modules/home/home_page.dart';
import 'package:prev_ler/src/modules/injuries/pages/injury_form_page.dart';
import 'package:prev_ler/src/modules/main/main_page.dart';
import 'package:prev_ler/src/modules/notifications/pages/notifications_page.dart';
import 'package:prev_ler/src/modules/profile/profile_page.dart';
import 'package:prev_ler/src/modules/routines/pages/exercise_cart_page.dart';
import 'package:prev_ler/src/modules/routines/pages/routine_form_page.dart';
import 'package:prev_ler/src/modules/routines/pages/routine_page.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list =
      <String, WidgetBuilder>{
    '/': (_) => const CheckUserState(),
    '/home': (_) => const MainPage(page: HomePage),
    '/register/patient': (_) =>
        const AuthRegisterPage(userType: UserType.patient),
    '/register/medic': (_) => const AuthRegisterPage(userType: UserType.medic),
    '/contents/register': (_) => const ContentFormPage(
          title: 'Cadastrar Conteúdo',
          content: null,
        ),
    '/injuries/register': (_) => const InjuryFormPage(
          title: 'Nova Lesão',
          injury: null,
        ),
    '/profile': (_) => const ProfilePage(),
    '/routines': (_) => const RoutinesPage(),
    '/routines/register': (_) => const RoutineFormPage(
          title: 'Nova Rotina',
          routine: null,
        ),
    '/routines/cart/exercises': (_) => const ExerciseCartPage(),
    '/notifications': (_) => const NotificationsPage(),
  };

  static String initial = '/';
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
