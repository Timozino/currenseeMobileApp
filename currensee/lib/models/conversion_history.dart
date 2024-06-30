class ConversionHistory {
  final String baseCurrency;
  final String targetCurrency;
  final double amount;
  final double convertedAmount;
  final DateTime date;

  ConversionHistory({
    this.baseCurrency,
    this.targetCurrency,
    this.amount,
    this.convertedAmount,
    this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'baseCurrency': baseCurrency,
      'targetCurrency': targetCurrency,
      'amount': amount,
      'convertedAmount': convertedAmount,
      'date': date.toIso8601String(),
    };
  }

  static ConversionHistory fromMap(Map<String, dynamic> map) {
    return ConversionHistory(
      baseCurrency: map['baseCurrency'],
      targetCurrency: map['targetCurrency'],
      amount: map['amount'],
      convertedAmount: map['convertedAmount'],
      date: DateTime.parse(map['date']),
    );
  }
}