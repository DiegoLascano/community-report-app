import 'package:community_reports/blocs/auth_form_bloc.dart';
import 'package:community_reports/screens/auth/signin_screen.dart';
import 'package:community_reports/services/auth_service.dart';
import 'package:community_reports/widgets/common/platform_exception_alert_dialog.dart';
import 'package:community_reports/widgets/signin/signin_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({
    Key key,
    @required this.authFormBloc,
  }) : super(key: key);

  final AuthFormBloc authFormBloc;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthInterface>(context, listen: false);
    return Provider<AuthFormBloc>(
      create: (context) => AuthFormBloc(auth: auth),
      dispose: (context, authFormBloc) => authFormBloc.dispose(),
      child: Consumer<AuthFormBloc>(
        builder: (context, authFormBloc, _) =>
            RegisterScreen(authFormBloc: authFormBloc),
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    try {
      await authFormBloc.createUserWithEmailAndPassword();
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Error al crear su cuenta',
        exception: e,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                child: _buildContent(context),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildHeading(),
        _buildEmailInput(),
        _buildPassInput(),
        _buildSubmitButton(context),
        FlatButton(
          onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => SignInScreen.create(context),
            ),
          ),
          child: Text('Ingresa'),
        ),
      ],
    );
  }

  Widget _buildHeading() {
    return Container(
      child: Text('Title here'),
    );
  }

  Widget _buildEmailInput() {
    return StreamBuilder(
      stream: authFormBloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'nombre@ejemplo.com',
              errorText: snapshot.error,
            ),
            onChanged: authFormBloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _buildPassInput() {
    return StreamBuilder(
      stream: authFormBloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Contraseña',
//              hintText: '*************',
              errorText: snapshot.error,
            ),
            onChanged: authFormBloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return StreamBuilder(
      stream: authFormBloc.authValidationStream,
      builder: (context, snapshot) {
        final validated = snapshot.data;
        return SignInButton(
          text: 'Registrar',
          onPressed: (snapshot.hasData)
              ? (snapshot.data ? () => _submit(context) : null)
              : null,
        );
      },
    );
  }
}
