import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:money_manager/common/enum/drawer_item.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainState.init());

  void setSelected (DrawerItem selected){
    emit(state.copyWith(selected: selected));
  }

  void setTheme(bool isLightTheme) {
    emit(state.copyWith(isLightTheme: isLightTheme));
  }
}
