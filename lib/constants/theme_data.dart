import 'package:algitsin/core/extensions/size_extention.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final algitsinThemeData = ThemeData(
    shadowColor: const Color(0xff21302F),
    primaryColor: const Color(0xff25C0B7),
    cardColor: const Color(0xffF8B34B),
    focusColor: const Color(0xffDFE4E3),
    dividerColor: const Color(0xff9098B1),
    dialogBackgroundColor: const Color(0xff55f7b9),
    hoverColor: const Color(0xff40BFFF),
    canvasColor:const Color(0xffFFFFFF),
    selectedRowColor: const Color(0xff000000),
    scaffoldBackgroundColor: const Color(0xffFFFFFF),
    textTheme: TextTheme(
        headline5: GoogleFonts.poppins(
            fontSize: 14.0.spByWidth,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            color: const Color(0xffFFFFFF)),
        subtitle2: GoogleFonts.poppins(
            fontSize: 12.0.spByWidth,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.normal,
            color: const Color(0xff9098B1)),
        headline4: GoogleFonts.poppins(
            fontSize: 16.0.spByWidth,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
            color: const Color(0xff000000)),
        headline3: GoogleFonts.poppins(
            fontSize: 14.0.spByWidth,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.normal,
            color: const Color(0xff000000)),
        headline2: GoogleFonts.poppins(
            fontSize: 17.0.spByWidth,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            color: const Color(0xff000000)),
        headline1: GoogleFonts.poppins(
          fontSize: 18.0.spByWidth,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w800,
          color: const Color(0xff9098B1),
        ),
        caption: GoogleFonts.poppins(
            fontSize: 16.0.spByWidth,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
            color: const Color(0xff21302F)),
        bodyText1: GoogleFonts.poppins(
            fontSize: 15.0.spByWidth,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            color: const Color(0xffFFFFFF)),
        bodyText2: GoogleFonts.poppins(
            fontSize: 15.0.spByWidth,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            color: const Color(0xff000000)),
        subtitle1: GoogleFonts.poppins(
            fontSize: 14.0.spByWidth,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            color: const Color(0xff000000).withOpacity(0.75)),
        overline: GoogleFonts.poppins(
            fontSize: 12.0.spByWidth,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            color: const Color(0xff9098B1)),
        button: GoogleFonts.poppins(
            fontSize: 14.0.spByWidth,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700,
            color: const Color(0xff000000))));
