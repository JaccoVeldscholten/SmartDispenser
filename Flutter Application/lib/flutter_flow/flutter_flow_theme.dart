import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: avoid_classes_with_only_static_members
class FlutterFlowTheme {
  static const Color primaryColor = Color(0xFF0E132C);
  static const Color secondaryColor = Color(0xFF6C6F7F);
  static const Color tertiaryColor = Color(0xFFF3FAF9);

  static const Color highlight = Color(0xFF70C7AC);
  static const Color buttonSeethrough = Color(0xFF292941);

  String primaryFontFamily = 'Poppins';
  String secondaryFontFamily = 'Roboto';
  static TextStyle get title1 => GoogleFonts.getFont(
        'Raleway',
        color: primaryColor,
        fontWeight: FontWeight.w800,
        fontSize: 24,
      );
  static TextStyle get title2 => GoogleFonts.getFont(
        'Raleway',
        color: highlight,
        fontWeight: FontWeight.w800,
        fontSize: 22,
      );
  static TextStyle get title3 => GoogleFonts.getFont(
        'Raleway',
        color: tertiaryColor,
        fontWeight: FontWeight.w800,
        fontSize: 20,
      );
  static TextStyle get subtitle1 => GoogleFonts.getFont(
        'Mulish',
        color: primaryColor,
        fontWeight: FontWeight.normal,
        fontSize: 18,
      );
  static TextStyle get subtitle2 => GoogleFonts.getFont(
        'Mulish',
        color: secondaryColor,
        fontWeight: FontWeight.normal,
        fontSize: 16,
      );
  static TextStyle get bodyText1 => GoogleFonts.getFont(
        'Mulish',
        color: tertiaryColor,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
  static TextStyle get bodyText2 => GoogleFonts.getFont(
        'Mulish',
        color: highlight,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String fontFamily,
    Color color,
    double fontSize,
    FontWeight fontWeight,
    FontStyle fontStyle,
    bool useGoogleFonts = true,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
            );
}
