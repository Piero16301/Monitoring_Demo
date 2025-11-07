import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monitoring_demo/home/home.dart';
import 'package:monitoring_demo/login/login.dart';
import 'package:monitoring_demo/monitoring/monitoring.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final analytics = AnalyticsFacade();

    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status.isSuccess) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('¡Inicio de sesión exitoso!'),
                backgroundColor: Colors.green,
              ),
            );
            unawaited(
              Navigator.of(context).pushReplacementNamed(HomePage.routeName),
            );
          } else if (state.status.isFailure) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Error al iniciar sesión'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 600,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Form(
                    key: state.formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 60),
                        const LoginHeader(),
                        const SizedBox(height: 48),
                        const Text(
                          'Iniciar sesión',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 40),
                        CustomTextField(
                          labelText: 'Usuario',
                          hintText: 'Ingresa tu usuario',
                          prefixIcon: Icons.person_outline,
                          onChanged: (value) {
                            context.read<LoginCubit>().onUsernameChanged(
                              value,
                            );
                          },
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'El usuario es requerido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        CustomTextField(
                          labelText: 'Contraseña',
                          hintText: 'Ingresa tu contraseña',
                          prefixIcon: Icons.lock_outline,
                          obscureText: !state.isPasswordVisible,
                          suffixIcon: IconButton(
                            icon: Icon(
                              state.isPasswordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                            onPressed: () {
                              context
                                  .read<LoginCubit>()
                                  .togglePasswordVisibility();
                            },
                          ),
                          onChanged: (value) {
                            context.read<LoginCubit>().onPasswordChanged(
                              value,
                            );
                          },
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'La contraseña es requerida';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 40),
                        PrimaryButton(
                          text: 'Iniciar Sesión',
                          isLoading: state.status.isLoading,
                          onPressed: () {
                            unawaited(analytics.trackLoginEvent());
                            unawaited(context.read<LoginCubit>().login());
                          },
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
