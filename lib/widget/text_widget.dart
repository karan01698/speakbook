import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/apptextconst.dart';

class BalooSubtitleText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final List<Shadow>? shadows;
  final bool enableBackdropBlur;
  final double blurSigmaX;
  final double blurSigmaY;

  const BalooSubtitleText({
    Key? key,
    required this.text,
    this.textAlign,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.shadows,
    this.enableBackdropBlur = false,
    this.blurSigmaX = 5.0,
    this.blurSigmaY = 5.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final styledText = Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.poppins(
        textStyle: AppTextStyles.subtitle.copyWith(
          color: color ?? AppTextStyles.subtitle.color,
          fontSize: fontSize ?? AppTextStyles.subtitle.fontSize,
          fontWeight: fontWeight ?? AppTextStyles.subtitle.fontWeight,
          shadows: shadows,
        ),
      ),
    );

    if (!enableBackdropBlur) {
      return styledText;
    }

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigmaX, sigmaY: blurSigmaY),
        child: styledText,
      ),
    );
  }
}
