import 'package:flutter/material.dart';
import 'package:currensee/services/conversion_history_service.dart';
import 'package:currensee/models/conversion_history.dart';

class ConversionHistoryScreen extends StatefulWidget {
  @override
  _ConversionHistoryScreenState createState() => _ConversionHistoryScreenState();
}

class _ConversionHistoryScreenState extends State<ConversionHistoryScreen> {
  final ConversionHistoryService _historyService = ConversionHistoryService();
  List<ConversionHistory> _historyList = [];

  @override
  void initState() {
    super.initState();
    _fetchConversionHistory();
  }

  void _fetchConversionHistory() async {
    try {
      List<ConversionHistory> history = await _historyService.getConversionHistory();
      setState(() {
        _historyList = history;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversion History'),
      ),
      body: _historyList.isEmpty
          ? Center(child: Text('No conversion history found.'))
          : ListView.builder(
              itemCount: _historyList.length,
              itemBuilder: (context, index) {
                ConversionHistory history = _historyList[index];
                return ListTile(
                  title: Text('${history.amount} ${history.baseCurrency} = ${history.convertedAmount} ${history.targetCurrency}'),
                  subtitle: Text(history.date.toString()),
                );
              },
            ),
    );
  }
}