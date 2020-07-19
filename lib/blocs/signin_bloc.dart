import 'package:community_reports/services/auth_service.dart';
import 'package:flutter/foundation.dart';

class SignInBloc {
  SignInBloc({
    @required this.auth,
    @required this.isLoading,
  });

  final AuthInterface auth;
  final ValueNotifier<bool> isLoading;

  Future<User> _authenticate(Future<User> Function() authMethod) async {
    try {
      isLoading.value = true;
      return await authMethod();
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  Future<User> signinAnonymously() async => await _authenticate(
        auth.signInAnonymously,
      );

  Future<User> signinWithGoogle() async =>
      await _authenticate(auth.signInWithGoogle);
}
