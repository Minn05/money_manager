// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Transaction {
  final String dateTime;
  final String title;
  final String content;
  final double amount;
  Transaction({
    required this.dateTime,
    required this.title,
    required this.content,
    required this.amount,
  });

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
    return <String, dynamic>{
      'dateTime': dateTime,
      'title': title,
      'content': content,
      'amount': amount,
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

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Transaction(dateTime: $dateTime, title: $title, content: $content, amount: $amount)';
  }

  @override
  bool operator ==(covariant Transaction other) {
    if (identical(this, other)) return true;

    return other.dateTime == dateTime &&
        other.title == title &&
        other.content == content &&
        other.amount == amount;
  }

  @override
  int get hashCode {
    return dateTime.hashCode ^
        title.hashCode ^
        content.hashCode ^
        amount.hashCode;
  }
}
