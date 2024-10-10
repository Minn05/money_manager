import 'package:money_manager/models/login.dart';
import 'package:money_manager/models/transaction.dart';
import 'package:money_manager/repositories/api.dart';

class ApiImpl implements Api {
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
        amount: 1000),
    Transaction(
        dateTime: "2024-10-09 14:00:00",
        title: "Abb",
        content: "Bed",
        amount: 1000),
    Transaction(
        dateTime: "2024-10-10 20:00:00",
        title: "Acc",
        content: "Bxd",
        amount: 1000),
  ];
  Future<void> delay() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> checkLogin(Login login) {
    delay();
    if (login.username == "1" && login.password == "1") {
      return Future(() => true);
    }
    return Future(() => false);
  }

  @override
  Future<void> addTransaction(Transaction transaction) {
    // TODO: implement addTransaction
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTransaction(String dateTime) {
    // TODO: implement deleteTransaction
    throw UnimplementedError();
  }

  @override
  Future<void> editTransaction(Transaction transaction) {
    // TODO: implement editTransaction
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getMonths() {
    // TODO: implement getMonths
    throw UnimplementedError();
  }

  @override
  Future<double> getTotals() {
    // TODO: implement getTotals
    throw UnimplementedError();
  }

  @override
  Future<List<Transaction>> getTransactions(String month) {
    // TODO: implement getTransactions
    throw UnimplementedError();
  }
}
