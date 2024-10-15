import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/common/enum/drawer_item.dart';
import 'package:money_manager/common/utils.dart';
import 'package:money_manager/main_cubit.dart';
import 'package:money_manager/repositories/api.dart';
import 'package:money_manager/widgets/screens/detail/detail_screen.dart';
import 'package:money_manager/widgets/screens/list_item/bloc/list_item_cubit.dart';
import 'package:money_manager/widgets/screens/menu/menu_screen.dart';
import 'package:money_manager/widgets/screens/setting/setting_screen.dart';

import '../../../common/enum/load_status.dart';
import '../../../common/enum/screen_size.dart';
import '../../common_widget/notification_bar.dart';
import '../add_edit/add_edit_screen.dart';

class ListItemScreen extends StatelessWidget {
  static const String route = "ListItemScreen";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListItemCubit(context.read<Api>())..loadData(0),
      child: Page(),
    );
  }
}

class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListItemCubit, ListItemState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Money Manager"),
          ),
          body: Body(),
          drawer: state.screenSize == ScreenSize.Large
              ? null
              : Drawer(
                  child: MenuScreen(),
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              var cubit = context.read<ListItemCubit>();
              Navigator.of(context).pushNamed(AddEditScreen.route,
                  arguments: {'cubit': cubit, 'isAddMode': true});
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (contextMain, stateMain) {
        return BlocConsumer<ListItemCubit, ListItemState>(
          listener: (context, state) {
            if (state.loadStatus == LoadStatus.Error) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(notificationBar("List item error", true));
            }
          },
          builder: (context, state) {
            var screenSize =
                calculateScreenSize(MediaQuery.sizeOf(context).width);
            context.read<ListItemCubit>().setScreenSize(screenSize);
            return state.loadStatus == LoadStatus.Loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : stateMain.selected == DrawerItem.Setting &&
                        state.screenSize != ScreenSize.Large
                    ? SettingScreen()
                    : switch (state.screenSize) {
                        ScreenSize.Small => ListItemPage(),
                        ScreenSize.Medium => ListItemEditPage(),
                        _ => ListItemEditMenuPage()
                      };
          },
        );
      },
    );
  }
}

class ListItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListItemCubit, ListItemState>(
      builder: (context, state) {
        var cubit = context.read<ListItemCubit>();
        return Container(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16)
                    .copyWith(top: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text("${state.total}"),
                    ),

                    //last month
                    (state.months.length > 0) &&
                            (state.selectedMonth >= 0) &&
                            (state.selectedMonth == state.months.length - 1)
                        ? Container()
                        : IconButton(
                            onPressed: () {
                              cubit.loadData(state.selectedMonth + 1);
                            },
                            icon: const Icon(
                              Icons.navigate_before_outlined,
                              color: Colors.grey,
                            ),
                          ),

                    //current month
                    ((state.months.length > 0) &&
                            (state.selectedMonth >= 0) &&
                            (state.selectedMonth < state.months.length))
                        ? Text(
                            state.months[state.selectedMonth].substring(0, 7),
                          )
                        : Container(),

                    //next month
                    (state.months.length > 0 &&
                            state.selectedMonth == 0 &&
                            state.selectedMonth < state.months.length)
                        ? Container()
                        : IconButton(
                            onPressed: () {
                              cubit.loadData(state.selectedMonth - 1);
                            },
                            icon: const Icon(
                              Icons.navigate_next_outlined,
                              color: Colors.grey,
                            ),
                          ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    var item = state.trans[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16)
                          .copyWith(top: 16),
                      child: ListTile(
                        leading: item.amount >= 0
                            ? const Icon(
                                Icons.keyboard_double_arrow_up,
                                color: Colors.blueAccent,
                              )
                            : const Icon(
                                Icons.keyboard_double_arrow_down,
                                color: Colors.redAccent,
                              ),
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(item.title),
                            ),
                            Text("${item.amount}")
                          ],
                        ),
                        subtitle: Text(item.content),
                        trailing: IconButton(
                          onPressed: () {
                            cubit.removeItem(item.dateTime);
                          },
                          icon: const Icon(
                            Icons.highlight_remove_outlined,
                            color: Colors.grey,
                          ),
                        ),
                        onTap: () {
                          cubit.setSelectedIndex(index);
                          if (state.screenSize == ScreenSize.Small) {
                            Navigator.of(context).pushNamed(DetailScreen.route,
                                arguments: {'cubit': cubit});
                          }
                        },
                      ),
                    );
                  },
                  itemCount: state.trans.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ListItemEditPage extends StatelessWidget {
  const ListItemEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: ListItemPage()),
        Expanded(child: DetailScreen()),
      ],
    );
  }
}

class ListItemEditMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return state.selected == DrawerItem.Home
            ? Row(
                children: [
                  Expanded(child: MenuScreen()),
                  Expanded(child: ListItemPage()),
                  Expanded(child: DetailScreen()),
                ],
              )
            : Row(
                children: [
                  Expanded(child: MenuScreen()),
                  Expanded(
                    flex: 2,
                    child: SettingScreen(),
                  ),
                ],
              );
      },
    );
  }
}
