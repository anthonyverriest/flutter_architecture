import 'package:flutter/material.dart';
import 'package:flutter_architecture/src/logic/blocs/sign_up.dart';
import 'package:flutter_architecture/src/logic/utils/utils.dart';
import 'package:flutter_architecture/src/presentation/extensions/build_context.dart';
import 'package:flutter_architecture/src/presentation/navigation/router.dart';
import 'package:flutter_architecture/src/presentation/pages/sign_in.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = '/signup';

  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _signUpBloc = SignUpBloc();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _signUpBloc,
        builder: (context, value, child) {
          if (value == SignUpStates.defaultError) {
            //default error
          }

          return Form(
            key: _formKey,
            child: Column(
              children: [
                if (value == SignUpStates.success)
                  const Text(
                    'success',
                    textAlign: TextAlign.center,
                  ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(context.intl.email),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0, top: 10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) {
                      if (Utils.isEmptyOrNull(email)) {
                        return context.intl.requiredTextField;
                      }

                      _emailController.text = _emailController.text.trim();

                      if (!Utils.isValidEmail(_emailController.text)) {
                        return context.intl.invalidEmailOrAlreadyTaken;
                      }

                      return null;
                    },
                    controller: _emailController,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(context.intl.password),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0, top: 10.0),
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    controller: _passwordController,
                    validator: (password) {
                      if (Utils.isEmptyOrNull(password)) {
                        return context.intl.requiredTextField;
                      }
                      if (!Utils.isAtLeastSixCharactersLong(password!)) {
                        return context.intl.weakPassword;
                      }

                      return null;
                    },
                    obscureText: true,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(context.intl.confirmPassword),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0, top: 10.0),
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    validator: (confirm) {
                      if (Utils.isEmptyOrNull(confirm)) {
                        return context.intl.requiredTextField;
                      }
                      if (confirm != _passwordController.text) {
                        return context.intl.confirmPasswordNotMatching;
                      }

                      return null;
                    },
                    controller: _confirmController,
                    obscureText: true,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _signUpBloc.signUp(
                            _emailController.text, _passwordController.text);
                      }
                    },
                    child: value == SignUpStates.loading
                        ? const CircularProgressIndicator()
                        : Text(context.intl.signUp),
                  ),
                ),
                Wrap(
                  children: [
                    Text('${context.intl.alreadyHaveAccount} '),
                    InkWell(
                      onTap: () =>
                          AppRouter.authSPANavigator.goTo(SignInPage.routeName),
                      child: Text(context.intl.signIn),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
