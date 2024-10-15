import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/widgets/screens/add_edit/add_edit_screen.dart';
import 'package:money_manager/widgets/screens/list_item/bloc/list_item_cubit.dart';

class DetailScreen extends StatelessWidget {
  static const String route = "DetailScreen";

  // const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Page();
  }
}

class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListItemCubit, ListItemState>(
      builder: (context, state) {
        return state.selectedIndex < 0 ||
                state.trans.length == 0 ||
                state.selectedIndex >= state.trans.length
            ? Container()
            : Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "DateTime: ${state.trans[state.selectedIndex].dateTime}"),
                    const SizedBox(height: 16),
                    Text("Title: ${state.trans[state.selectedIndex].title}"),
                    const SizedBox(height: 16),
                    Text(
                        "Content: ${state.trans[state.selectedIndex].content}"),
                    const SizedBox(height: 16),
                    Text("Amount: ${state.trans[state.selectedIndex].amount}"),
                    const SizedBox(height: 16),
                    ElevatedButton(
                        onPressed: () {
                          var cubit = context.read<ListItemCubit>();
                          Navigator.of(context).pushNamed(AddEditScreen.route,
                              arguments: {'cubit': cubit, 'isAddMode': false});
                        },
                        child: const Text("Edit")),
                  ],
                ),
              );
      },
    );
  }
}
