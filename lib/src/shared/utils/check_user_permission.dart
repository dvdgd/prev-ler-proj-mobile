import 'package:prev_ler/src/shared/utils/enums.dart';

import '../entities/user.dart';

bool returnTrueIfUserCouldCreateContents(User? user) {
  if (user?.type == null) return false;

  switch (user?.type) {
    case UserType.healthProfessional:
      return true;
    case UserType.employee:
      return false;
    default:
      return false;
  }
}
