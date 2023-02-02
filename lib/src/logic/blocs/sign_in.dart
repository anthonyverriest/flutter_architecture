import 'package:flutter_architecture/src/data/mockdb/mockdb.dart';
import 'package:flutter_architecture/src/data/models/user.dart';
import 'package:flutter_architecture/src/data/repositories/auth.dart';
import 'package:flutter_architecture/src/logic/value_broadcast_notifier.dart';
import 'package:flutter_architecture/src/logic/services/text_field_validator.dart';

enum SignInStates {
  loading,
  success,
  emailNotVerified,
  defaultError,
  incorrectEmailOrPassword;
}

class SignInBloc extends ValueBroadcastNotifier<SignInBloc, SignInStates?> {
  final AuthRepository _authRepository = AuthRepository();

  SignInBloc() : super(null);

  void signIn(String? email, String? password) async {
    value = SignInStates.loading;

    value = await _signIn(email, password);
  }

  Future<SignInStates> _signIn(String? email, String? password) async {
    try {
      //Optional checks to lower bad requests
      if (TextFieldValidator.isEmptyOrNull(email)) {
        return SignInStates.incorrectEmailOrPassword;
      }

      if (TextFieldValidator.isEmptyOrNull(password)) {
        return SignInStates.incorrectEmailOrPassword;
      }

      final trimmedEmail = email!.trim();

      if (!TextFieldValidator.isValidEmail(trimmedEmail)) {
        return SignInStates.incorrectEmailOrPassword;
      }

      final User? user = await _authRepository.signIn(trimmedEmail, password!);

      if (user == null) {
        return SignInStates.defaultError;
      }

      //CHECK CONF MAIL

      return SignInStates.success;
    } on MockDBException catch (e) {
      if (e.toString() == 'user-not-found') {
        return SignInStates.incorrectEmailOrPassword;
      } else if (e.toString() == 'wrong-password') {
        return SignInStates.incorrectEmailOrPassword;
      } else if (e.toString() == 'invalid-email') {
        return SignInStates.incorrectEmailOrPassword;
      }
      return SignInStates.defaultError;
    } catch (_) {
      return SignInStates.defaultError;
    }
  }
}
