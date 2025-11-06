import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monitoring_demo/shopping/shopping.dart';

class ShoppingPage extends StatelessWidget {
  const ShoppingPage({super.key});

  static const String routeName = '/shopping';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ShoppingCubit(),
      child: const ShoppingView(),
    );
  }
}
