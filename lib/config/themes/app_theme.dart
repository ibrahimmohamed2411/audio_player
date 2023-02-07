import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData appTheme() {
  return ThemeData(
    appBarTheme: AppBarTheme(
      color: Color(0xFF144771),
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      titleSpacing: 2,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 2,
      ),
    ),
    
  
  );
}
