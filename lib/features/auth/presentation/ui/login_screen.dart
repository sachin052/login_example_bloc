import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_example_with_bloc/core/widgets/CustomInputField.dart';
import 'package:login_example_with_bloc/features/auth/presentation/bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();
    loginBloc = LoginBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: BlocConsumer<LoginBloc, LoginState>(
        bloc: loginBloc,
        listener: (context, state) {
            state.maybeWhen(orElse: () {},
                error: (errorMessage) => showAlertDialog(errorMessage),
                success: () => showAlertDialog("Login Successfully"));
        },
        builder: (context, state) {
          return state.maybeWhen(orElse: () => _buildHome(),
              loading: () => Center(child: CircularProgressIndicator()),
              success: () => _buildHome());
        },
      ),
    );
  }

  Widget _buildHome() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomInputField(
            hintText: "Email",
            stream: loginBloc.emailController.data,
            onTextChange: loginBloc.emailController.changeData,
          ),
          CustomInputField(
            hintText: "Password",
            stream: loginBloc.passwordController.data,
            onTextChange: loginBloc.passwordController.changeData,
          ),
          SizedBox(height: 30,),
          Row(
            children: [
              Expanded(child: ElevatedButton(onPressed: () {
                loginBloc.add(Login());
              }, child: Text("Login"))),
            ],
          )
        ],
      ),
    );
  }

  showAlertDialog(String? message) {
    if (message == null) return;
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation!"),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
