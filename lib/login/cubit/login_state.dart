part of 'login_cubit.dart';

enum LoginStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == LoginStatus.initial;
  bool get isLoading => this == LoginStatus.loading;
  bool get isSuccess => this == LoginStatus.success;
  bool get isFailure => this == LoginStatus.failure;
}

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.initial,
    this.username = '',
    this.password = '',
    this.isPasswordVisible = false,
    this.formKey,
  });

  final LoginStatus status;
  final String username;
  final String password;
  final bool isPasswordVisible;
  final GlobalKey<FormState>? formKey;

  LoginState copyWith({
    LoginStatus? status,
    String? username,
    String? password,
    bool? isPasswordVisible,
    GlobalKey<FormState>? formKey,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      formKey: formKey ?? this.formKey,
    );
  }

  @override
  List<Object?> get props => [
    status,
    username,
    password,
    isPasswordVisible,
    formKey,
  ];
}
