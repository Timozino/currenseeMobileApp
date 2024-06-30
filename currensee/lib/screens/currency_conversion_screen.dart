import 'package:flutter/material.dart';
import 'package:currensee/services/currency_service.dart';
import 'package:currensee/services/preferences_service.dart';

class CurrencyConversionScreen extends StatefulWidget {
  @override
  _CurrencyConversionScreenState createState() => _CurrencyConversionScreenState();
}

class _CurrencyConversionScreenState extends State<CurrencyConversionScreen> {
  final CurrencyService _currencyService = CurrencyService();
  final PreferencesService _preferencesService = PreferencesService();
  final TextEditingController _amountController = TextEditingController();
  String _baseCurrency = 'USD';
  String _targetCurrency = 'EUR';
  double? _convertedAmount;
  Map<String, dynamic>? _exchangeRates;

  @override
  void initState() {
    super.initState();
    _fetchExchangeRates();
    _loadDefaultBaseCurrency();
  }

  void _fetchExchangeRates() async {
    try {
      Map<String, dynamic> rates = await _currencyService.fetchExchangeRates(_baseCurrency);
      setState(() {
        _exchangeRates = rates['rates'];
      });
    } catch (e) {
      print(e);
    }
  }

  void _convertCurrency() {
    if (_exchangeRates != null && _amountController.text.isNotEmpty) {
      double amount = double.parse(_amountController.text);
      setState(() {
        _convertedAmount = amount * _exchangeRates![_targetCurrency];
      });
    }
  }

  void _loadDefaultBaseCurrency() async {
    String defaultBaseCurrency = await _preferencesService.getDefaultBaseCurrency();
    setState(() {
      _baseCurrency = defaultBaseCurrency;
    });
  }

  void _setDefaultBaseCurrency() async {
    await _preferencesService.setDefaultBaseCurrency(_baseCurrency);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Conversion'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _setDefaultBaseCurrency,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            DropdownButton<String>(
              value: _baseCurrency,
              onChanged: (String? newValue) {
                setState(() {
                  _baseCurrency = newValue!;
                  _fetchExchangeRates();
                });
              },
              items: <String>['USD', 'EUR', 'GBP', 'INR']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: _targetCurrency,
              onChanged: (String? newValue) {
                setState(() {
                  _targetCurrency = newValue!;
                });
              },
              items: <String>['USD', 'EUR', 'GBP', 'INR']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: _convertCurrency,
              child: Text('Convert'),
            ),
            if (_convertedAmount != null)
              Text(
                'Converted Amount: $_convertedAmount $_targetCurrency',
                style: TextStyle(fontSize: 20),
              ),
          ],
        ),
      ),
    );
  }
}
