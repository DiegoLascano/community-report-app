import 'package:community_reports/services/auth_service.dart';
import 'package:flutter/foundation.dart';

class SignInBloc {
  SignInBloc({
    @required this.auth,
    @required this.isLoading,
  });

  final AuthInterface auth;
  final ValueNotifier<bool> isLoading;

  Future<AppUser> _authenticate(Future<AppUser> Function() authMethod) async {
    try {
      isLoading.value = true;
      return await authMethod();
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  Future<AppUser> signinAnonymously() async => await _authenticate(
        auth.signInAnonymously,
      );

  Future<AppUser> signinWithGoogle() async =>
      await _authenticate(auth.signInWithGoogle);
}
