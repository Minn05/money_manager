import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:money_manager/widgets/screens/add_edit/add_edit_screen.dart';
import 'package:money_manager/widgets/screens/detail/detail_screen.dart';
import 'package:money_manager/widgets/screens/list_item/list_item_screen.dart';
import 'package:money_manager/widgets/screens/login/login_screen.dart';

Route<dynamic>? mainRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.route:
      return MaterialPageRoute(builder: (context) => LoginScreen());
    case ListItemScreen.route:
      return MaterialPageRoute(builder: (context) => ListItemScreen());
    case DetailScreen.route:
      return MaterialPageRoute(builder: (context) => DetailScreen());
    case AddEditScreen.route:
      return MaterialPageRoute(builder: (context) => AddEditScreen());
    default:
      return MaterialPageRoute(builder: (context) => LoginScreen());
  }
}
