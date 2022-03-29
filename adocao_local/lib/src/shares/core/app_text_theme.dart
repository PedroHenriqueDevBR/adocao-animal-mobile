import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  TextStyle get titleStyle => GoogleFonts.openSans(
        fontSize: 20,
        height: 1.4,
        fontWeight: FontWeight.w600,
      );

  TextStyle get descriptionStyle => GoogleFonts.openSans(
        height: 1.2,
        color: Colors.grey.shade700,
      );

  TextStyle get cardDashboardNumber => GoogleFonts.openSans(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade700,
      );

  TextStyle get textButton => GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      );
}
