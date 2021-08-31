import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

final kTitleStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'Bebas_Neue',
  fontSize: 36.0,
  height: 1.5,
);

final kSubtitleStyle = TextStyle(
  fontFamily: 'Bebas_Neue',
  color: Colors.white,
  fontWeight: FontWeight.w500,
  fontSize: 14.0,
  height: 1.2,
);

abstract class Styles {
  //colors
  static const Color whiteColor = Color(0xffffffff);
  static const Color blackColor = Color(0xff0000000);
  static const Color orangeColor = Colors.orange;
  static const Color redColor = Colors.red;
  static const Color darkRedColor = Color(0xFFB71C1C);

  static const Color purpleColor = Color(0xff5E498A);

  static const Color darkThemeColor = Color(0xff33333E);

  static const Color grayColor = Color(0xff797979);

  static const Color greyColorLight = Color(0xffd7d7d7);

  static const Color settingsBackground = Color(0xffefeff4);

  static const Color settingsGroupSubtitle = Color(0xff777777);

  static const Color iconBlue = Color(0xff0000ff);
  static const Color transparent = Colors.transparent;
  static const Color iconGold = Color(0xffdba800);
  static const Color bottomBarSelectedColor = Color(0xff5e4989);

  //Strings
  static const TextStyle defaultTextStyle = TextStyle(
    color: Styles.purpleColor,
    fontFamily: 'Bebas_Neue',
    fontSize: 20.0,
  );
  static const TextStyle defaultTextStyleBlack = TextStyle(
    color: Styles.blackColor,
    fontFamily: 'Bebas_Neue',
    fontSize: 20.0,
  );
  static const TextStyle defaultTextStyleGRey = TextStyle(
    color: Styles.grayColor,
    fontFamily: 'Bebas_Neue',
    fontSize: 20.0,
  );
  static const TextStyle smallTextStyleGRey = TextStyle(
    color: Styles.grayColor,
    fontFamily: 'Bebas_Neue',
    fontSize: 16.0,
  );
  static const TextStyle smallTextStyle = TextStyle(
    color: Styles.purpleColor,
    fontFamily: 'Bebas_Neue',
    fontSize: 16.0,
  );
  static const TextStyle smallTextStyleWhite = TextStyle(
    color: Styles.whiteColor,
    fontFamily: 'Bebas_Neue',
    fontSize: 16.0,
  );
  static const TextStyle smallTextStyleBlack = TextStyle(
    color: Styles.blackColor,
    fontFamily: 'Bebas_Neue',
    fontSize: 16.0,
  );
  static const TextStyle defaultButtonTextStyle = TextStyle(
      color: Styles.whiteColor, fontFamily: 'Bebas_Neue', fontSize: 20);

  static const TextStyle profileTextStyleBlack = TextStyle(
    color: Styles.blackColor,
    fontFamily: 'Bebas_Neue',
    fontSize: 20.0,
  );

  static const TextStyle defaultTextStyleWhite = TextStyle(
    color: Styles.whiteColor,
    fontFamily: 'Bebas_Neue',
    fontSize: 20.0,
  );
  static const TextStyle messageRecipientTextStyle = TextStyle(
    color: Styles.blackColor,
    fontSize: 16.0,
    fontFamily: 'Bebas_Neue',
  );

  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    isDarkTheme =
        SchedulerBinding.instance?.window.platformBrightness == Brightness.dark;
    return ThemeData(
      //* Custom Google Font
      //  fontFamily: Devfest.google_sans_family,
      primarySwatch: Colors.brown,
      primaryColor: isDarkTheme ? Colors.black : Colors.white,

      backgroundColor: isDarkTheme ? Colors.black : Color(0xffF1F5FB),

      indicatorColor: isDarkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
      buttonColor: isDarkTheme ? Color(0xFF2b1605) : Color(0xFF2b1605),

      hintColor: isDarkTheme ? Color(0xff280C0B) : Color(0xffEECED3),

      highlightColor: isDarkTheme ? Color(0xFF2b1605) : Color(0xFF2b1605),
      hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xff4285F4),

      focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: isDarkTheme ? Colors.white : Colors.black,
        cursorColor: Color(0xffBA379B).withOpacity(.6),
        selectionHandleColor: Color(0xffBA379B).withOpacity(1),
      ),
      cardColor: isDarkTheme ? Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme
              ? ColorScheme.dark(
                  primary: Color(0xFF2b1605),
                  background: Color(0xFF2b1605),
                )
              : ColorScheme.light(
                  primary: Color(0xFF2b1605),
                )),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
      ),
    );
  }
}
