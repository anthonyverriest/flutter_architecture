import 'package:flutter/material.dart';
import 'package:flutter_architecture/src/logic/blocs/sign_in.dart';
import 'package:flutter_architecture/src/presentation/extensions/build_context.dart';
import 'package:flutter_architecture/src/presentation/navigation/auth.dart';
import 'package:flutter_architecture/src/presentation/pages/sign_up.dart';

class SignInPage extends StatefulWidget {
  static const routeName = '/signin';

  const SignInPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _signInBloc = SignInBloc();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _signInBloc,
      builder: (context, value, child) {
        if (value == SignInStates.defaultError) {
          //default error
        } else if (value == SignInStates.incorrectEmailOrPassword) {
          _passwordController.clear();
        }

        return Column(
          children: [
            if (value == SignInStates.incorrectEmailOrPassword)
              Text(
                context.intl.incorrectEmailOrPassword,
                textAlign: TextAlign.center,
              ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(context.intl.email),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0, top: 10.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(context.intl.password),
                      /*InkWell(
                        onTap: () => context.navigator
                            .pushNamed(ForgotPasswordPage.name),
                        child: Text(context.intl.forgotPassword),
                      ),*/
                    ],
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _signInBloc.signIn(
                            _emailController.text, _passwordController.text);
                      }
                    },
                    child: value == SignInStates.loading
                        ? const CircularProgressIndicator()
                        : Text(context.intl.signIn),
                  ),
                  Wrap(
                    children: [
                      Text('${context.intl.noAccount} '),
                      InkWell(
                        onTap: () => context
                            .spaNavigator<AuthSPANavigator>()
                            .goTo(SignUpPage.routeName),
                        child: Text(context.intl.signUp),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
