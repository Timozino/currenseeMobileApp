import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  Future<void> setDefaultBaseCurrency(String currency) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('default_base_currency', currency);
  }

  Future<String> getDefaultBaseCurrency() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('default_base_currency') ?? 'USD';
  }
}