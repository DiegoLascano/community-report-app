import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:community_reports/color_swatches.dart';
import 'package:community_reports/auth_verify_screen.dart';
import 'package:community_reports/services/auth_service.dart';
//import 'package:community_reports/color_swatches.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthInterface>(
      create: (_) => Auth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Community Report',
        home: AuthVerifyScreen(),
        theme: ThemeData(
          // brightness: Brightness.light,
          textTheme: GoogleFonts.ralewayTextTheme(),
          primarySwatch: blueGraySwatch,
          // accentColor: yellowVividSwatch[600],
        ),
      ),
    );
  }
}
