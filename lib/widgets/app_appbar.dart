import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar(String title, BuildContext context) {
  return AppBar(
    title: Text(title),
    backgroundColor: Theme.of(context).primaryColor,
  );
}
