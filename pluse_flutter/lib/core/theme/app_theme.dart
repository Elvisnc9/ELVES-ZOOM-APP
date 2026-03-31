import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

class AppTheme {
  static final Theme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
     progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Colors.black,
      strokeWidth: 5
     ),
    hintColor: Colors.black,
    dividerColor: Colors.black,
    cardColor: AppColors.wine.withOpacity(0.9),
    canvasColor: Colors.grey.withOpacity(0.1),
    shadowColor: Colors.black,
     splashColor: Colors.black,
     focusColor: Colors.grey,
      secondaryHeaderColor: AppColors.wine,
      buttonTheme: ButtonThemeData(),
      iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStatePropertyAll(Colors.black),
        iconSize: WidgetStatePropertyAll(30)
      )
    ),
     textTheme: TextTheme(
    displayLarge: GoogleFonts.spaceGrotesk(
      fontSize: 24.sp,
      height: 1.5,
      fontWeight: FontWeight.bold,
    ),

    
     displayMedium: GoogleFonts.spaceGrotesk(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      height: 1.4,
     color: AppColors.wine
    ),
    displaySmall: GoogleFonts.spaceGrotesk(
      fontSize: 17.sp,
      fontWeight: FontWeight.bold,
     color: AppColors.wine
    ),

    labelMedium: GoogleFonts.spaceGrotesk(
      fontSize: 14.sp,
      fontWeight: FontWeight.bold,
     color: AppColors.wine.withOpacity(0.8)
    
    ),

     

    labelSmall: GoogleFonts.spaceGrotesk(
      fontSize: 14.sp,
      fontWeight: FontWeight.bold,
     color: AppColors.wine
    
    ),
      labelLarge: GoogleFonts.spaceGrotesk(
      fontSize: 17.sp,
      fontWeight: FontWeight.w500,
     color: AppColors.wine.withOpacity(0.95)
    
    ),

    bodySmall: GoogleFonts.spaceGrotesk(
      fontSize: 15.sp,
      fontWeight: FontWeight.w500,
     color: AppColors.light.withOpacity(0.95)
    
    ),

  ),

    
  );


}



class AppColors {
  static const Color primary = Color(0xFF9D1F15);
  static const Color light = Color.fromARGB(255, 249, 250, 217);
  static const Color wine = Color(0xFF722f37);
  static const Color accent = Color(0xFFA0430A);
}




    //  Color(0xFF8E2DE2),
    //           Color(0xFF4A00E0),


