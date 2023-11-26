import 'package:prev_ler/main.dart';
import 'package:prev_ler/src/shared/entities/user.dart';
import 'package:prev_ler/src/shared/mappers/user_mapper.dart';

class UserService {
  Future<User?> getUserProfile() async {
    final userId = supabaseClient.auth.currentUser?.id;

    final response = await supabaseClient
        .from('profiles')
        .select('*, cargo(nome), empresa(*)')
        .eq("id_usuario", userId)
        .single();

    if (response == null) return null;

    return userFromSupabase(response);
  }
}
