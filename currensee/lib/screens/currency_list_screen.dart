// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:currensee/services/currency_service.dart';

class CurrencyListScreen extends StatefulWidget {
  @override
  _CurrencyListScreenState createState() => _CurrencyListScreenState();
}

class _CurrencyListScreenState extends State<CurrencyListScreen> {
  final CurrencyService _currencyService = CurrencyService();
  Map<String, String> _currencies;

  @override
  void initState() {
    super.initState();
    _fetchSupportedCurrencies();
  }

  void _fetchSupportedCurrencies() async {
    try {
      Map<String, String> currencies = await _currencyService.fetchSupportedCurrencies();
      setState(() {
        _currencies = currencies;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supported Currencies'),
      ),
      body: _currencies == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _currencies.length,
              itemBuilder: (context, index) {
                String code = _currencies.keys.elementAt(index);
                String name = _currencies[code];
                return ListTile(
                  title: Text('$code - $name'),
                );
              },
            ),
    );
  }
}