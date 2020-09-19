import 'dart:async';
import 'package:community_reports/services/auth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:community_reports/blocs/validators.dart';

class AuthFormBloc with Validators {
  AuthFormBloc({@required this.auth});

  final AuthInterface auth;

  /// Streams to manage state
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _loadingController = BehaviorSubject<bool>.seeded(false);

  /// Getters to fetch data from streams
  Stream<String> get emailStream =>
      _emailController.stream.transform(validateEmail);

  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validatePassword);

  Stream<bool> get loadingStream => _loadingController.stream;

  /// Combine streams
  Stream<bool> get authValidationStream => Rx.combineLatest3(
      emailStream,
      passwordStream,
      loadingStream,
      (email, password, loading) => (loading == true) ? false : true);

  /// Get last value of stream
  String get email => _emailController.value;

  String get password => _passwordController.value;

  /// Change value of streams
  Function(String) get changeEmail => _emailController.sink.add;

  Function(String) get changePassword => _passwordController.sink.add;

  Function(bool) get changeLoading => _loadingController.sink.add;

  Future<AppUser> _authenticate(Future<AppUser> Function() authMethod) async {
    try {
      changeLoading(true);
      return await authMethod();
    } catch (e) {
      changeLoading(false);
      rethrow;
    }
  }

  Future<AppUser> signInWithEmailAndPassword() async => await _authenticate(
      () => auth.signInWithEmailAndPassword(email, password));

  Future<AppUser> createUserWithEmailAndPassword() async => await _authenticate(
      () => auth.createUserWithEmailAndPassword(email, password));

  void dispose() {
    _emailController?.close();
    _passwordController?.close();
    _loadingController?.close();
  }
}
