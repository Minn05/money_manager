import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/common/enum/drawer_item.dart';
import 'package:money_manager/main_cubit.dart';

class MenuScreen extends StatelessWidget {
  static const String route = "MenuScreen";

  @override
  Widget build(BuildContext context) {
    return Page();
  }
}

class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return Container(
          child: Column(
            children: [
              ListTile(
                title: Text("Home"),
                trailing: state.selected != DrawerItem.Home
                    ? Icon(Icons.navigate_next)
                    : null,
                onTap: () {
                  context.read<MainCubit>().setSelected(DrawerItem.Home);
                },
              ),
              ListTile(
                title: Text("Setting"),
                trailing: state.selected != DrawerItem.Setting
                    ? Icon(Icons.navigate_next)
                    : null,
                onTap: () {
                  context.read<MainCubit>().setSelected(DrawerItem.Setting);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
