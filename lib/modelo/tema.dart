import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getTemaAplicativo(BuildContext context) {
  return ThemeData(
    // todo o tema de fontes do aplicativo deriva da fonte MontSerrat
    textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),

    primaryColor: Color.fromRGBO(204, 41, 0, 1),
    accentColor: Color.fromRGBO(204, 41, 0, 1),
    appBarTheme: AppBarTheme(color: Color.fromRGBO(204, 41, 0, 1)),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
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
