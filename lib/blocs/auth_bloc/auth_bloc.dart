import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(LoginILoadingStete());
      try {
        var auth = FirebaseAuth.instance;
        UserCredential user = await auth.signInWithEmailAndPassword(
            email: event.email, password: event.password);

        emit(LoginSuscessStete());
      } on FirebaseAuthException catch (ex) {
        if (ex.code == 'invalid-email') {
          emit(LoginFailureStete(errorMessage: 'Invalid Email'));
        } else if (ex.code == 'user-not-found') {
          emit(
              LoginFailureStete(errorMessage: 'No user found for that email.'));
        } else if (ex.code == 'wrong-password') {
          emit(LoginFailureStete(
              errorMessage: 'Wrong password . Please try again.'));
        }
      } catch (e) {
        emit(LoginFailureStete(
            errorMessage: 'There is an error, please try again'));
      }
    });

    on<RegisterEvent>((event, emit) async {
      emit(RegisterLoadingState());
      try {
        var auth = FirebaseAuth.instance;
        UserCredential user = await auth.createUserWithEmailAndPassword(
            email: event.email, password: event.password);
        emit(RegisterSuccessState());
      } on FirebaseAuthException catch (ex) {
        if (ex.code == 'invalid-email') {
          emit(RegisterFailureState(messageError: 'Invalid Email'));
        } else if (ex.code == 'weak-password') {
          emit(RegisterFailureState(
              messageError: 'The password provided is too weak.'));
        } else if (ex.code == 'email-already-in-use') {
          emit(RegisterFailureState(
              messageError: 'The account already exists for that email.'));
        }
      } catch (e) {
        emit(RegisterFailureState(
            messageError: 'There is an error, please try again'));
      }
    });
  }
}
