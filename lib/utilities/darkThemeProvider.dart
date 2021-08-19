import 'package:flutter/foundation.dart';
import 'package:poopingapp/utilities/dark_theme_preference.dart';

class DarkThemeProvider with ChangeNotifier {
  DarkThemePreference providerPreferences = DarkThemePreference();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    providerPreferences.setDarkTheme(value);
    notifyListeners();
  }
}