import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_example_with_bloc/core/stream/custom_stream_controller.dart';
import 'package:login_example_with_bloc/core/validators/form_validators.dart';
import 'login_state.dart';
export 'login_state.dart';

part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final emailController = CustomStreamController<String>(validateEmail);
  final passwordController = CustomStreamController<String>(validatePassword);

  LoginBloc() : super(LoginState.initial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is Login) {
      yield* mapLoginEvent();
    }
  }

  Stream<LoginState> mapLoginEvent() async* {
    yield LoginState.loading();

    /// mocking login behaviour with delay
    await Future.delayed(Duration(seconds: 2));
    if (emailController.dateValue == null ||
        passwordController.dateValue == null)
      yield LoginState.error("Invalid login credentials");
    else if (emailController.dateValue == "test@gmail.com" &&
        passwordController.dateValue == "12345678")
      yield LoginState.success();
    else
      yield LoginState.error("Invalid login credentials");
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
