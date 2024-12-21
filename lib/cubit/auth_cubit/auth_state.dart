part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

// Login States
class LoginILoadingStete extends AuthState {}

class LoginSuscessStete extends AuthState {}

class LoginFailureStete extends AuthState {
  final String errorMessage;
  LoginFailureStete({required this.errorMessage});
}

// Register States
final class RegisterLoadingState extends AuthState {}

final class RegisterSuccessState extends AuthState {}

final class RegisterFailureState extends AuthState {
  final String messageError;
  RegisterFailureState({required this.messageError});
}
