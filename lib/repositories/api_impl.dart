import 'package:money_manager/models/login.dart';
import 'package:money_manager/models/transaction.dart';
import 'package:money_manager/repositories/api.dart';
import 'package:money_manager/repositories/log.dart';

class ApiImpl implements Api {
  Log log;

  final List<Transaction> _data = [
    Transaction(
        dateTime: "2024-10-07 15:00:00",
        title: "Abc",
        content: "Bcd",
        amount: 1000),
    Transaction(
        dateTime: "2024-10-08 13:00:00",
        title: "Acb",
        content: "Bdd",
        amount: -200),
    Transaction(
        dateTime: "2024-10-09 14:00:00",
        title: "Abb",
        content: "Bed",
        amount: 100),
    Transaction(
        dateTime: "2024-10-10 20:00:00",
        title: "Acc",
        content: "Bxd",
        amount: -100),
  ];

  Future<void> delay() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  ApiImpl(this.log) {
    _data.sort((a, b) => b.dateTime.compareTo(a.dateTime));
  }

  @override
  Future<bool> checkLogin(Login login) {
    delay();
    if (login.username == "1" && login.password == "1") {
      return Future(() => true);
    }
    return Future(() => false);
  }

  @override
  Future<void> addTransaction(Transaction transaction) async {
    await delay();
    for (int i = 0; i < _data.length; i++) {
      if (_data[i].dateTime == transaction.dateTime)
        throw Exception("Duplicate data");
    }
    _data.add(transaction);
    _data.sort((a, b) => b.dateTime.compareTo(a.dateTime));
  }

  @override
  Future<void> deleteTransaction(String dateTime) async {
    await delay();
    for (int i = 0; i < _data.length; i++) {
      if (_data[i].dateTime == dateTime) {
        _data.removeAt(i);
        return;
      }
    }
    throw Exception("Can not found data");
  }

  @override
  Future<void> editTransaction(Transaction transaction) async {
    await delay();
    for (int i = 0; i < _data.length; i++) {
      if (_data[i].dateTime == transaction.dateTime) {
        _data[i] = transaction;
        return;
      }
    }
    throw Exception("Can not found data");
  }

  @override
  Future<List<String>> getMonths() async {
    await delay();
    Set<String> r = {};
    for (int i = 0; i < _data.length; i++) {
      var tmp = _data[i].dateTime.substring(0, 7) + "-01 00:00:00";
      r.add(tmp);
    }
    return r.toList();
  }

  @override
  Future<double> getTotals() async {
    await delay();
    double total = 0;
    for (int i = 0; i < _data.length; i++) {
      total += _data[i].amount;
    }
    return total;
  }

  @override
  Future<List<Transaction>> getTransactions(String month) async {
    await delay();
    Set<Transaction> r = {};
    for (int i = 0; i < _data.length; i++) {
      var tmp = _data[i].dateTime.substring(0, 7);
      if (month.startsWith(tmp)) r.add(_data[i]);
    }
    return r.toList();
  }
}
