import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Color Palette
  static const Color pine = Color(0xFF0F2F23);
  static const Color forest = Color(0xFF174936);
  static const Color emerald = Color(0xFF2F7D57);
  static const Color sage = Color(0xFF83A98C);
  static const Color mint = Color(0xFFDCECDF);
  static const Color tea = Color(0xFFEEF7E9);
  static const Color cream = Color(0xFFFBF6E9);
  static const Color paper = Color(0xFFFFFDF5);
  static const Color olive = Color(0xFF6F8F4E);
  static const Color limeSoft = Color(0xFFC8E6A0);
  static const Color ink = Color(0xFF13251B);
  static const Color muted = Color(0xFF63746A);
  static const Color softGray = Color(0xFF9AA69E);
  static const Color danger = Color(0xFFA0483F);

  // Text Styles
  static TextTheme textTheme = TextTheme(
    displayLarge: GoogleFonts.fraunces(
      fontSize: 42,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.05 * 42,
      color: pine,
    ),
    displayMedium: GoogleFonts.fraunces(
      fontSize: 24,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.04 * 24,
      color: pine,
    ),
    headlineLarge: GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.03 * 18,
      color: pine,
    ),
    headlineMedium: GoogleFonts.inter(
      fontSize: 15,
      fontWeight: FontWeight.w800, // 850 in css, but 800 is closest
      letterSpacing: -0.02 * 15,
      color: pine,
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: ink,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 13.5,
      fontWeight: FontWeight.w400,
      color: ink,
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: 12.5,
      fontWeight: FontWeight.w500,
      color: muted,
    ),
    labelLarge: GoogleFonts.inter(
      fontSize: 13,
      fontWeight: FontWeight.w800,
      color: cream,
    ),
  );

  static ThemeData get themeData {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: emerald, surface: paper),
      textTheme: textTheme,
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.transparent, // Background will be handled by a container
    );
  }

  // Gradients
  static const LinearGradient glassGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xEBFFFDF5), // rgba(255, 253, 245, 0.92)
      Color(0xC7EFF8EC), // rgba(239, 248, 236, 0.78)
    ],
  );

  static const LinearGradient popupBackground = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFBF6E9),
      Color(0xFFEAF4E7),
      Color(0xFFDFEEE0),
    ],
    stops: [0.0, 0.48, 1.0],
  );

  static const LinearGradient primaryButtonGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [emerald, pine],
  );

  static const LinearGradient secondaryButtonGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF8F8EB), mint],
  );

  static const LinearGradient dangerButtonGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [danger, Color(0xFFC36B55)],
  );

  static const LinearGradient premiumButtonGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xDBFFFFFF), Color(0xB8CCD5C0)],
  );

  static const LinearGradient modeCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xF5174936), Color(0xEB2F7D57)],
  );
}
