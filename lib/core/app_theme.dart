import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Palette {
  static const cream = Color(0xFFFFF9E9);
  static const yellow = Color(0xFFF9BA12);
  static const blue = Color(0xFF205ABC);
  static const deepBlue = Color(0xFF13438F);
  static const navy = Color(0xFF152238);
  static const gray = Color(0xFF78808E);
  static const line = Color(0xFFEDE3C9);
  static const ice = Color(0xFFE8F2FF);
  static const mint = Color(0xFFDDF6EB);
  static const green = Color(0xFF168966);
  static const red = Color(0xFFC8424A);
}

ThemeData buildTheme() {
  const font = 'Roboto';
  return ThemeData(
    useMaterial3: true,
    fontFamily: font,
    scaffoldBackgroundColor: Palette.cream,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Palette.blue,
      primary: Palette.blue,
      surface: Palette.cream,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Palette.cream,
      elevation: 0,
      scrolledUnderElevation: 0,
      foregroundColor: Palette.blue,
      centerTitle: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
      hintStyle: const TextStyle(color: Color(0xFF9AA1AA), fontSize: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: const BorderSide(color: Palette.line),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: const BorderSide(color: Palette.line),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: const BorderSide(color: Palette.blue),
      ),
    ),
  );
}
