import 'package:bloc/bloc.dart';
import 'package:money_manager/common/enum/load_status.dart';
import 'package:money_manager/common/enum/screen_size.dart';
import 'package:money_manager/models/transaction.dart';
import 'package:money_manager/repositories/api.dart';

part 'list_item_state.dart';

class ListItemCubit extends Cubit<ListItemState> {
  Api api;

  ListItemCubit(this.api) : super(ListItemState.init());

  Future<void> loadData(int monthIndex) async {
    emit(state.copyWith(
        loadStatus: LoadStatus.Loading, selectedMonth: monthIndex));
    try {
      var months = await api.getMonths();
      emit(state.copyWith(months: months));
      var total = await api.getTotal();
      emit(state.copyWith(total: total));
      List<Transaction> trans = months.isEmpty
          ? []
          : await api.getTransactions(state.months[state.selectedMonth]);
      emit(state.copyWith(trans: trans, loadStatus: LoadStatus.Done));
    } catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.Error));
    }
  }

  Future<void> removeItem(String dateTime) async {
    emit(state.copyWith(loadStatus: LoadStatus.Loading));
    try {
      await api.deleteTransaction(dateTime);
      await loadData(state.selectedMonth);
    } catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.Error));
    }
  }

  void setScreenSize (ScreenSize screenSize){
    emit(state.copyWith(screenSize:  screenSize));
  }
}
