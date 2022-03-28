import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  TextStyle get titleStyle => GoogleFonts.openSans(
    fontSize: 18,
    height: 1.4,
    fontWeight: FontWeight.w600,
  );

  TextStyle get descriptionStyle => GoogleFonts.openSans(
    height: 1.4,
  );

  TextStyle get subtitleStyle => GoogleFonts.openSans(
    fontSize: 12,
    color: Colors.grey.shade700,
  );
}