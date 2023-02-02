import 'package:flutter/material.dart';
import 'package:flutter_architecture/src/logic/blocs/sign_in.dart';
import 'package:flutter_architecture/src/presentation/extensions/build_context.dart';
import 'package:flutter_architecture/src/presentation/navigation/auth.dart';
import 'package:flutter_architecture/src/presentation/pages/sign_up.dart';
import 'package:flutter_architecture/src/presentation/theme/theme.dart';
import 'package:flutter_architecture/src/presentation/widgets/auth_header.dart';
import 'package:flutter_architecture/src/presentation/widgets/text_form_field.dart';

class SignInPage extends StatelessWidget {
  static const routeName = '/signin';

  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppAuthHeader(
      title: 'Sign in',
      body: _SignIn(),
    );
  }
}

class _SignIn extends StatefulWidget {
  final _signInBloc = SignInBloc();

  _SignIn({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<_SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void _showErrorDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('An error occured'),
          actions: [
            TextButton(
              onPressed: () => context.navigator.pop(),
              child: const Text('dismiss'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget._signInBloc,
      builder: (context, value, _) {
        if (value == SignInStates.defaultError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showErrorDialog(context);
          });
        } else if (value == SignInStates.incorrectEmailOrPassword) {
          _passwordController.clear();
        }

        return Column(
          children: [
            if (value == SignInStates.incorrectEmailOrPassword)
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: SizedBox(
                  width: 350,
                  child: Card(
                    color: Colors.red[200],
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppTheme.kBorderRadius),
                      side: BorderSide(
                        color: Colors.red[400]!,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        context.intl.incorrectEmailOrPassword,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            SizedBox(
              width: 350,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
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
                          padding:
                              const EdgeInsets.only(bottom: 20.0, top: 10.0),
                          child: AppTextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(context.intl.password),
                            InkWell(
                              onTap: () {
                                /* context.navigator
                                    .pushNamed(ForgotPasswordPage.name);*/
                              },
                              child: Text(
                                'Forgot password ?',
                                style: TextStyle(fontSize: 13),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 40.0, top: 10.0),
                          child: AppTextFormField(
                            textInputAction: TextInputAction.done,
                            controller: _passwordController,
                            obscureText: true,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                widget._signInBloc.signIn(_emailController.text,
                                    _passwordController.text);
                              }
                            },
                            child: value == SignInStates.loading
                                ? const CircularProgressIndicator()
                                : Text(context.intl.signIn),
                          ),
                        ),
                        Wrap(
                          children: [
                            Text('${context.intl.noAccount} '),
                            InkWell(
                              onTap: () => context
                                  .spaNavigator<AuthSPANavigator>()
                                  .goTo(SignUpPage.routeName),
                              child: Text(
                                context.intl.signUp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
