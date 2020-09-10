import 'package:community_reports/blocs/signin_bloc.dart';
import 'package:community_reports/screens/auth/signin_screen.dart';
import 'package:community_reports/services/auth_service.dart';
import 'package:community_reports/widgets/common/platform_exception_alert_dialog.dart';
import 'package:community_reports/widgets/signin/signin_button.dart';
import 'package:community_reports/widgets/signin/social_signin_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AuthOptionsScreen extends StatelessWidget {
  const AuthOptionsScreen({
    Key key,
    @required this.signInBloc,
  }) : super(key: key);

  final SignInBloc signInBloc;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthInterface>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (context, isLoading, _) => Provider<SignInBloc>(
          create: (context) => SignInBloc(auth: auth, isLoading: isLoading),
          child: Consumer<SignInBloc>(
            builder: (context, signinBloc, _) =>
                AuthOptionsScreen(signInBloc: signinBloc),
          ),
        ),
      ),
    );
  }

  void _showSignInError(BuildContext context, PlatformException exception) {
    PlatformExceptionAlertDialog(
      title: 'Error al iniciar sesión',
      exception: exception,
    ).show(context);
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await signInBloc.signinWithGoogle();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') _showSignInError(context, e);
    }
  }

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => SignInScreen.create(context),
      ),
    );
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await signInBloc.signinAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<ValueNotifier<bool>>(context);
    return Scaffold(
      body: _buildContent(context, isLoading.value),
    );
  }

  Widget _buildContent(BuildContext context, bool isLoading) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text('Titulo'),
            Expanded(
              child: Container(),
            ),
            _buildButtons(context, isLoading),
            SizedBox(height: 20.0)
          ],
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context, bool isLoading) {
    return Column(
      children: <Widget>[
        SocialSignInButton(
          text: 'Ingresa con Google',
          color: Colors.grey[300],
          imagePath: 'assets/logos/google-logo.png',
          onPressed: isLoading ? null : () => _signInWithGoogle(context),
        ),
        SignInButton(
          text: 'Ingresa con tu email',
          color: Colors.grey[300],
          onPressed:
              isLoading ? null : () => _signInWithEmailAndPassword(context),
        ),
        FlatButton(
          onPressed: isLoading ? null : () => _signInAnonymously(context),
          child: Text(
            'SignIn Anonymously',
          ),
        ),
      ],
    );
  }
}
