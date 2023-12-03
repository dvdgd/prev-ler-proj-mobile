import 'package:prev_ler/main.dart';
import 'package:prev_ler/src/shared/entities/user.dart';
import 'package:prev_ler/src/shared/errors/base_error.dart';
import 'package:prev_ler/src/shared/mappers/user_mapper.dart';

class UserService {
  Future<User?> getUserProfile() async {
    final userId = supabaseClient.auth.currentUser?.id;

    final response = await supabaseClient
        .from('usuario_empresa_assinaturra')
        .select('*')
        .eq("id_usuario", userId)
        .single();

    if (response == null) return null;

    if (response['assinatura'] == null) {
      throw BaseError(
        message: 'Ops... Não foi possivel enconstrar nenhuma assinatura ativa.',
      );
    }

    return userFromSupabase(response);
  }
}
