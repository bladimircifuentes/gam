import 'package:flutter/material.dart';

class AppTheme {
  
  static final theme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xffF2F2F2),
    cardTheme: CardTheme(
      margin: const EdgeInsets.all(10),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.antiAlias,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(
        color: Colors.black,
      ),
      prefixIconColor: Colors.blue,
      focusedBorder: InputBorder.none,
      border: InputBorder.none,
      enabledBorder:  OutlineInputBorder(
        borderSide: BorderSide.none
      ),
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    cardTheme: CardTheme(
      margin: const EdgeInsets.all(10),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.antiAlias,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(
        color: Colors.white,
      ),
      prefixIconColor: Colors.white,
      focusedBorder: InputBorder.none,
      border: InputBorder.none,
      enabledBorder:  OutlineInputBorder(
        borderSide: BorderSide.none
      ),
    ),
  );

  static Color textColor(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark ? Colors.white : Colors.black;
  }

  static BoxDecoration containerTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDarkTheme = theme.brightness == Brightness.dark;
    final Color color = isDarkTheme ? Colors.grey.shade700 : Colors.white60;

    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(30),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          offset: const Offset(0, 5),
          blurRadius: 5,
        ),
      ],
    );
  }

  static TextStyle notaTheme(context){
    final ThemeData theme = Theme.of(context);
    final bool isDarkTheme = theme.brightness == Brightness.dark;
    final Color color = isDarkTheme ? Colors.white: Colors.black;
    return TextStyle(
      color: color, 
      fontSize: 15,
      fontWeight: FontWeight.bold,
    );
  }

}