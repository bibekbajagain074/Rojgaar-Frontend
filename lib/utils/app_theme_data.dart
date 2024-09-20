import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

class AppThemeData {
  static ThemeData appThemeData = ThemeData(
    primaryColor: primaryColor,
    iconTheme: const IconThemeData(color: primaryColor, size: 20),
    fontFamily: GoogleFonts.poppins().fontFamily,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme:
        const AppBarTheme(iconTheme: IconThemeData(color: primaryColor)),
  );
}
