class Transaction {
  final String dateTime;
  final String title;
  final String content;
  final double amount;

//<editor-fold desc="Data Methods">
  const Transaction({
    required this.dateTime,
    required this.title,
    required this.content,
    required this.amount,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaction &&
          runtimeType == other.runtimeType &&
          dateTime == other.dateTime &&
          title == other.title &&
          content == other.content &&
          amount == other.amount);

  @override
  int get hashCode =>
      dateTime.hashCode ^ title.hashCode ^ content.hashCode ^ amount.hashCode;


  Transaction copyWith({
    String? dateTime,
    String? title,
    String? content,
    double? amount,
  }) {
    return Transaction(
      dateTime: dateTime ?? this.dateTime,
      title: title ?? this.title,
      content: content ?? this.content,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dateTime': this.dateTime,
      'title': this.title,
      'content': this.content,
      'amount': this.amount,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      dateTime: map['dateTime'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      amount: map['amount'] as double,
    );
  }

//</editor-fold>
}
