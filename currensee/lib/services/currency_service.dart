import 'package:http/http.dart' as http;
import 'dart:convert';

class CurrencyService {
  final String apiUrl = "https://api.exchangerate-api.com/v4/latest/";

  Future<Map<String, dynamic>> fetchExchangeRates(String baseCurrency) async {
    final response = await http.get(Uri.parse("$apiUrl$baseCurrency"));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load exchange rates');
    }
  }

  Future<Map<String, String>> fetchSupportedCurrencies() async {
    final response = await http.get(Uri.parse("https://openexchangerates.org/api/currencies.json"));

    if (response.statusCode == 200) {
      return Map<String, String>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load supported currencies');
    }
  }
}
