import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colores principales
  static const Color primaryBlue = Color(0xFF3B82F6);
  static const Color primaryRed = Color(0xFFF44336);
  static const Color backgroundLight = Color(0xFFFAFAFA);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF1E1E1E);
  static const Color textLight = Color(0xFF212121);
  static const Color textDark = Color(0xFFE0E0E0);

  // Getter para compatibilidad
  static Color get backgroundColor => backgroundLight;

  // Tema claro
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryBlue,
        brightness: Brightness.light,
        surface: cardLight,
        onSurface: textLight,
      ),
      scaffoldBackgroundColor: backgroundLight,
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundLight,
        foregroundColor: textLight,
        elevation: 0,
        centerTitle: true,
        // Reducir tamaño de título para móviles
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 18, // Reducido de 20 a 18
          fontWeight: FontWeight.w600,
          color: textLight,
        ),
        // Asegurar que los iconos tengan tamaño apropiado para móvil
        iconTheme: const IconThemeData(size: 24),
        actionsIconTheme: const IconThemeData(size: 24),
      ),
      cardTheme: CardThemeData(
        color: cardLight,
        elevation: 2,
        // Bordes más pequeños para móvil
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ), // Reducido de 12 a 8
        shadowColor: Colors.black.withValues(alpha: 0.1),
        margin: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ), // Márgenes más pequeños
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          elevation: 2,
          // Padding más compacto para móvil
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ), // Reducido
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Reducido de 12 a 8
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 14, // Reducido de 16 a 14
            fontWeight: FontWeight.w600,
          ),
          // Altura mínima para elementos táctiles móviles
          minimumSize: const Size(0, 44),
        ),
      ),
      // Navegación inferior optimizada para móvil
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryBlue,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedLabelStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ), // Reducido
        unselectedLabelStyle: TextStyle(fontSize: 10), // Reducido
        selectedIconTheme: IconThemeData(size: 22), // Reducido de 24 a 22
        unselectedIconTheme: IconThemeData(size: 22),
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.poppins(
          fontSize: 28, // Reducido de 32 a 28
          fontWeight: FontWeight.bold,
          color: textLight,
        ),
        displayMedium: GoogleFonts.poppins(
          fontSize: 24, // Reducido de 28 a 24
          fontWeight: FontWeight.bold,
          color: textLight,
        ),
        displaySmall: GoogleFonts.poppins(
          fontSize: 20, // Reducido de 24 a 20
          fontWeight: FontWeight.w600,
          color: textLight,
        ),
        headlineLarge: GoogleFonts.poppins(
          fontSize: 18, // Reducido de 22 a 18
          fontWeight: FontWeight.w600,
          color: textLight,
        ),
        headlineMedium: GoogleFonts.poppins(
          fontSize: 16, // Reducido de 20 a 16
          fontWeight: FontWeight.w600,
          color: textLight,
        ),
        headlineSmall: GoogleFonts.poppins(
          fontSize: 14, // Reducido de 18 a 14
          fontWeight: FontWeight.w600,
          color: textLight,
        ),
        titleLarge: GoogleFonts.poppins(
          fontSize: 14, // Reducido de 16 a 14
          fontWeight: FontWeight.w600,
          color: textLight,
        ),
        titleMedium: GoogleFonts.poppins(
          fontSize: 12, // Reducido de 14 a 12
          fontWeight: FontWeight.w500,
          color: textLight,
        ),
        titleSmall: GoogleFonts.poppins(
          fontSize: 10, // Reducido de 12 a 10
          fontWeight: FontWeight.w500,
          color: textLight,
        ),
        bodyLarge: GoogleFonts.poppins(
          fontSize: 14, // Reducido de 16 a 14
          fontWeight: FontWeight.normal,
          color: textLight,
        ),
        bodyMedium: GoogleFonts.poppins(
          fontSize: 12, // Reducido de 14 a 12
          fontWeight: FontWeight.normal,
          color: textLight,
        ),
        bodySmall: GoogleFonts.poppins(
          fontSize: 10, // Reducido de 12 a 10
          fontWeight: FontWeight.normal,
          color: textLight,
        ),
        labelLarge: GoogleFonts.poppins(
          fontSize: 12, // Reducido de 14 a 12
          fontWeight: FontWeight.w500,
          color: textLight,
        ),
        labelMedium: GoogleFonts.poppins(
          fontSize: 10, // Reducido de 12 a 10
          fontWeight: FontWeight.w500,
          color: textLight,
        ),
        labelSmall: GoogleFonts.poppins(
          fontSize: 8, // Reducido de 10 a 8
          fontWeight: FontWeight.w500,
          color: textLight,
        ),
      ),
    );
  }

  // Tema oscuro
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryBlue,
        brightness: Brightness.dark,
        surface: cardDark,
        onSurface: textDark,
      ),
      scaffoldBackgroundColor: backgroundDark,
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundDark,
        foregroundColor: textDark,
        elevation: 0,
        centerTitle: true,
        // Reducir tamaño de título para móviles
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 18, // Reducido de 20 a 18
          fontWeight: FontWeight.w600,
          color: textDark,
        ),
        // Asegurar que los iconos tengan tamaño apropiado para móvil
        iconTheme: const IconThemeData(size: 24),
        actionsIconTheme: const IconThemeData(size: 24),
      ),
      cardTheme: CardThemeData(
        color: cardDark,
        elevation: 4,
        // Bordes más pequeños para móvil
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ), // Reducido de 12 a 8
        shadowColor: Colors.black.withValues(alpha: 0.3),
        margin: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ), // Márgenes más pequeños
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          elevation: 4,
          // Padding más compacto para móvil
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ), // Reducido
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Reducido de 12 a 8
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 14, // Reducido de 16 a 14
            fontWeight: FontWeight.w600,
          ),
          // Altura mínima para elementos táctiles móviles
          minimumSize: const Size(0, 44),
        ),
      ),
      // Navegación inferior optimizada para móvil
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryBlue,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedLabelStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ), // Reducido
        unselectedLabelStyle: TextStyle(fontSize: 10), // Reducido
        selectedIconTheme: IconThemeData(size: 22), // Reducido de 24 a 22
        unselectedIconTheme: IconThemeData(size: 22),
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.poppins(
          fontSize: 28, // Reducido de 32 a 28
          fontWeight: FontWeight.bold,
          color: textDark,
        ),
        displayMedium: GoogleFonts.poppins(
          fontSize: 24, // Reducido de 28 a 24
          fontWeight: FontWeight.bold,
          color: textDark,
        ),
        displaySmall: GoogleFonts.poppins(
          fontSize: 20, // Reducido de 24 a 20
          fontWeight: FontWeight.w600,
          color: textDark,
        ),
        headlineLarge: GoogleFonts.poppins(
          fontSize: 18, // Reducido de 22 a 18
          fontWeight: FontWeight.w600,
          color: textDark,
        ),
        headlineMedium: GoogleFonts.poppins(
          fontSize: 16, // Reducido de 20 a 16
          fontWeight: FontWeight.w600,
          color: textDark,
        ),
        headlineSmall: GoogleFonts.poppins(
          fontSize: 14, // Reducido de 18 a 14
          fontWeight: FontWeight.w600,
          color: textDark,
        ),
        titleLarge: GoogleFonts.poppins(
          fontSize: 14, // Reducido de 16 a 14
          fontWeight: FontWeight.w600,
          color: textDark,
        ),
        titleMedium: GoogleFonts.poppins(
          fontSize: 12, // Reducido de 14 a 12
          fontWeight: FontWeight.w500,
          color: textDark,
        ),
        titleSmall: GoogleFonts.poppins(
          fontSize: 10, // Reducido de 12 a 10
          fontWeight: FontWeight.w500,
          color: textDark,
        ),
        bodyLarge: GoogleFonts.poppins(
          fontSize: 14, // Reducido de 16 a 14
          fontWeight: FontWeight.normal,
          color: textDark,
        ),
        bodyMedium: GoogleFonts.poppins(
          fontSize: 12, // Reducido de 14 a 12
          fontWeight: FontWeight.normal,
          color: textDark,
        ),
        bodySmall: GoogleFonts.poppins(
          fontSize: 10, // Reducido de 12 a 10
          fontWeight: FontWeight.normal,
          color: textDark,
        ),
        labelLarge: GoogleFonts.poppins(
          fontSize: 12, // Reducido de 14 a 12
          fontWeight: FontWeight.w500,
          color: textDark,
        ),
        labelMedium: GoogleFonts.poppins(
          fontSize: 10, // Reducido de 12 a 10
          fontWeight: FontWeight.w500,
          color: textDark,
        ),
        labelSmall: GoogleFonts.poppins(
          fontSize: 8, // Reducido de 10 a 8
          fontWeight: FontWeight.w500,
          color: textDark,
        ),
      ),
    );
  }
}
