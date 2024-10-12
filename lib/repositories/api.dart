import 'package:money_manager/models/login.dart';
import 'package:money_manager/models/transaction.dart';

abstract class Api {
  Future<bool> checkLogin(Login login);

  Future<double> getTotals();

  Future<List<String>> getMonths();

  Future<List<Transaction>> getTransactions(String month);

  Future<void> addTransaction(Transaction transaction);

  Future<void> editTransaction(Transaction transaction);

  Future<void> deleteTransaction(String dateTime);
}
