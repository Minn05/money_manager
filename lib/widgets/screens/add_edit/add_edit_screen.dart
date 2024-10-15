import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/common/enum/screen_size.dart';
import 'package:money_manager/common/utils.dart';
import 'package:money_manager/models/transaction.dart';
import 'package:money_manager/widgets/screens/list_item/bloc/list_item_cubit.dart';
import 'package:money_manager/widgets/screens/list_item/list_item_screen.dart';

class AddEditScreen extends StatelessWidget {
  static const String route = "AddEditScreen";
  final bool isAddMode;
  final ScreenSize oldScreenSize;
  ScreenSize newScreenSize = ScreenSize.Small;

  AddEditScreen(this.isAddMode, this.oldScreenSize);

  // const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isAddMode ? "Add" : "Edit"),
      ),
      body: BlocBuilder<ListItemCubit, ListItemState>(
        builder: (context, state) {
          var _title = TextEditingController(text: "");
          var _content = TextEditingController(text: "");
          var _amount = TextEditingController(text: "");
          var _cubit = context.read<ListItemCubit>();

          if (!isAddMode) {
            _title.text = state.trans[state.selectedIndex].title;
            _content.text = state.trans[state.selectedIndex].content;
            _amount.text = state.trans[state.selectedIndex].amount.toString();
          }
          newScreenSize = calculateScreenSize(MediaQuery.sizeOf(context).width);
          return Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(controller: _title),
                SizedBox(height: 16),
                TextField(controller: _content),
                SizedBox(height: 16),
                TextField(controller: _amount),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (!isAddMode) {
                      _cubit.editeItem(
                        Transaction(
                          dateTime: state.trans[state.selectedIndex].dateTime,
                          title: _title.text,
                          content: _title.text,
                          amount: double.parse(_amount.text),
                        ),
                      );
                      Navigator.of(context)
                          .popUntil(ModalRoute.withName(ListItemScreen.route));
                    } else {
                      _cubit.addItem(
                        Transaction(
                          dateTime: DateTime.now().toString().substring(0, 19),
                          title: _title.text,
                          content: _title.text,
                          amount: double.parse(_amount.text),
                        ),
                      );
                      pop(context);
                    }
                  },
                  child: Text("Save"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void pop(BuildContext context) {
    if (oldScreenSize == newScreenSize) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).popUntil(ModalRoute.withName(ListItemScreen.route));
    }
  }
}
