import 'package:community_reports/services/auth_service.dart';
import 'package:community_reports/widgets/common/platform_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    final auth = Provider.of<AuthInterface>(context, listen: false);
    try {
      await auth.signOut();
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final _signOutConfirmed = await PlatformAlertDialog(
      title: 'Cerrar sesión',
      content: 'Seguro que quieres cerrar sesión',
      defaultActionText: 'Cerrar Sesión',
      cancelActionText: 'Cancelar',
    ).show(context);
    if (_signOutConfirmed) _signOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: <Widget>[
        FlatButton(
          onPressed: () => _confirmSignOut(context),
          child: Text('Logout'),
        ),
        Expanded(
          child: Container(),
        ),
        Center(
          child: Text('Home Screen'),
        ),
        SizedBox(height: 20.0)
      ],
    );
  }
}
