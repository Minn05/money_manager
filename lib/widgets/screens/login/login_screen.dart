import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/common/enum/load_status.dart';
import 'package:money_manager/models/login.dart';
import 'package:money_manager/repositories/api.dart';
import 'package:money_manager/widgets/screens/list_item/list_item_screen.dart';
import 'package:money_manager/widgets/screens/login/bloc/login_cubit.dart';

import '../../common_widget/notification_bar.dart';

class LoginScreen extends StatelessWidget {
  static const String route = "LoginScreen";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(context.read<Api>()),
      child: Page(),
    );
  }
}

class Page extends StatelessWidget {
  String _username = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.loadStatus == LoadStatus.Error) {
            ScaffoldMessenger.of(context)
                .showSnackBar(notificationBar("Login error", true));
          } else if (state.loadStatus == LoadStatus.Done) {
            Navigator.of(context).pushNamed(ListItemScreen.route);
          }
        },
        builder: (context, state) {
          return state.loadStatus == LoadStatus.Loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  padding: const EdgeInsets.all(32),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        decoration: const InputDecoration(labelText: "Username"),
                        onChanged: (value) => _username = value,
                      ),
                      TextField(
                        decoration: const InputDecoration(labelText: "Password"),
                        onChanged: (value) => _password = value,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.read<LoginCubit>().checkLogin(
                              Login(username: _username, password: _password));
                        },
                        child: const Text("Login"),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
