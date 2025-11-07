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
    final validErrors = <String>[
      'Credenciales inválidas',
      'Usuario no encontrado',
      'Error de red',
      'Cuenta bloqueada',
      'Tiempo de espera agotado',
    ];

    if (state.formKey?.currentState?.validate() ?? false) {
      emit(state.copyWith(status: LoginStatus.loading));

      // Simular llamada al API
      await Future<void>.delayed(const Duration(seconds: 1));

      // Simulación de login exitoso o fallido aleatoriamente
      if (Random().nextBool()) {
        emit(state.copyWith(status: LoginStatus.success));
      } else {
        emit(
          state.copyWith(
            status: LoginStatus.failure,
            errorMessage: validErrors[Random().nextInt(validErrors.length)],
          ),
        );
      }
    }
  }
}
