import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void init() {
    emit(state.copyWith(formKey: GlobalKey<FormState>()));
  }

  void onUsernameChanged(String username) {
    emit(state.copyWith(username: username));
  }

  void onPasswordChanged(String password) {
    emit(state.copyWith(password: password));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  Future<void> login() async {
    if (state.formKey?.currentState?.validate() ?? false) {
      emit(state.copyWith(status: LoginStatus.loading));

      // Simular llamada al API
      await Future<void>.delayed(const Duration(seconds: 1));

      // Simulación de login exitoso o fallido aleatoriamente
      if (Random().nextBool()) {
        emit(state.copyWith(status: LoginStatus.success));
      } else {
        emit(state.copyWith(status: LoginStatus.failure));
      }
    }
  }
}
