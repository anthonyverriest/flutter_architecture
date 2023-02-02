import 'package:flutter/material.dart';
import 'package:flutter_architecture/src/logic/blocs/sign_up.dart';
import 'package:flutter_architecture/src/logic/services/text_field_validator.dart';
import 'package:flutter_architecture/src/presentation/extensions/build_context.dart';
import 'package:flutter_architecture/src/presentation/navigation/auth.dart';
import 'package:flutter_architecture/src/presentation/pages/sign_in.dart';
import 'package:flutter_architecture/src/presentation/theme/theme.dart';
import 'package:flutter_architecture/src/presentation/widgets/auth_header.dart';
import 'package:flutter_architecture/src/presentation/widgets/text_form_field.dart';

class SignUpPage extends StatelessWidget {
  static const routeName = '/signUp';

  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppAuthHeader(
      title: 'Sign up',
      body: _SignUp(),
    );
  }
}

class _SignUp extends StatefulWidget {
  final _signUpBloc = SignUpBloc();

  _SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<_SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

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
      valueListenable: widget._signUpBloc,
      builder: (context, value, _) {
        if (value == SignUpStates.defaultError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showErrorDialog(context);
          });
        } else if (value == SignUpStates.success) {
          _emailController.clear();
          _confirmController.clear();
          _passwordController.clear();
        }

        return Column(
          children: [
            if (value == SignUpStates.success)
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: SizedBox(
                  width: 350,
                  child: Card(
                    color: Colors.green[200],
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppTheme.kBorderRadius),
                      side: BorderSide(
                        color: Colors.green[400]!,
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'You have been signed up successfuly, please sign in',
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
                            errorText:
                                value == SignUpStates.invalidEmailOrAlreadyTaken
                                    ? context.intl.invalidEmailOrAlreadyTaken
                                    : null,
                            validator: (email) {
                              if (TextFieldValidator.isEmptyOrNull(email)) {
                                return context.intl.requiredTextField;
                              }

                              _emailController.text =
                                  _emailController.text.trim();

                              if (!TextFieldValidator.isValidEmail(
                                  _emailController.text)) {
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
                          padding:
                              const EdgeInsets.only(bottom: 20.0, top: 10.0),
                          child: AppTextFormField(
                            textInputAction: TextInputAction.done,
                            controller: _passwordController,
                            errorText: value == SignUpStates.weakPassword
                                ? context.intl.weakPassword
                                : null,
                            validator: (password) {
                              if (TextFieldValidator.isEmptyOrNull(password)) {
                                return context.intl.requiredTextField;
                              }
                              if (!TextFieldValidator
                                  .isAtLeastSixCharactersLong(password!)) {
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
                          padding:
                              const EdgeInsets.only(bottom: 40.0, top: 10.0),
                          child: AppTextFormField(
                            textInputAction: TextInputAction.done,
                            validator: (confirm) {
                              if (TextFieldValidator.isEmptyOrNull(confirm)) {
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
                                widget._signUpBloc.signUp(_emailController.text,
                                    _passwordController.text);
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
                              onTap: () => context
                                  .spaNavigator<AuthSPANavigator>()
                                  .goTo(SignInPage.routeName),
                              child: Text(context.intl.signIn),
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
