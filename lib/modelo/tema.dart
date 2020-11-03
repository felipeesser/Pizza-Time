import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final _corPadraoApp = Color.fromRGBO(204, 41, 0, 1); // #CC2900FF
final _corRealceApp = Colors.white; // #FFFFFFFF

ThemeData getTemaAplicativo(BuildContext context) {
  return ThemeData(
    // todo o tema de fontes do aplicativo deriva da fonte MontSerrat
    textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),

    // a cor de fundo predominante no app.
    primaryColor: _corPadraoApp,
    accentColor: _corRealceApp,

    // tema dos campos de input do usuario (formulários)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: _corPadraoApp, width: 3),
          borderRadius: BorderRadius.circular(32)),
    ),

    buttonTheme: ButtonThemeData(
      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black, width: 3),
        borderRadius: BorderRadius.circular(32),
      ),
    ),
  );
}
