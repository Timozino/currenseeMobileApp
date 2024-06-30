import 'package:flutter/material.dart';
import 'package:currensee/services/notification_service.dart';

class RateAlertScreen extends StatefulWidget {
  @override
  _RateAlertScreenState createState() => _RateAlertScreenState();
}

class _RateAlertScreenState extends State<RateAlertScreen> {
  final NotificationService _notificationService = NotificationService();
  final TextEditingController _currencyPairController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _notificationService.initialize();
  }

  void _setRateAlert() {
    String currencyPair = _currencyPairController.text;
    if (currencyPair.isNotEmpty) {
      _notificationService.subscribeToRateAlert(currencyPair);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Subscribed to rate alerts for $currencyPair')));
    }
  }

  void _removeRateAlert() {
    String currencyPair = _currencyPairController.text;
    if (currencyPair.isNotEmpty) {
      _notificationService.unsubscribeFromRateAlert(currencyPair);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Unsubscribed from rate alerts for $currencyPair')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rate Alerts'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _currencyPairController,
              decoration: InputDecoration(labelText: 'Currency Pair (e.g., USD_EUR)'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _setRateAlert,
                  child: Text('Set Alert'),
                ),
                ElevatedButton(
                  onPressed: _removeRateAlert,
                  child: Text('Remove Alert'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}