import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/auth/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:flutter_application_1/screens/auth/components/my_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool requireSignUp = false;
  IconData iconPassword = Icons.remove_red_eye;
  bool obscurePassword = true;
  String? _errorMsg;

  bool containUpperCase = false;
  bool containLowerCase = false;
  bool containDigit = false;
  bool containSpecialChar = false;
  bool contain8Length = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          setState(() {
            requireSignUp = false;
          });
          return;
        }
        if (state is SignUpLoading) {
          setState(() {
            requireSignUp = true;
          });
          return;
        }
      },
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              MyCustomForm(
                  hintText: 'User Name',
                  textEditingController: userController,
                  errorText: _errorMsg,
                  keyboardType: TextInputType.name,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Please fill in this field.';
                    }
                    return null;
                  },
                  prefixIcon: const Icon(CupertinoIcons.person)),
              MyCustomForm(
                  hintText: 'Email',
                  textEditingController: emailController,
                  errorText: _errorMsg,
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Please fill in this field.';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(val)) {
                      return 'Please enter an valid email.';
                    }
                  },
                  prefixIcon: const Icon(CupertinoIcons.mail)),
              MyCustomForm(
                hintText: 'Password',
                obscureText: obscurePassword,
                textEditingController: passwordController,
                errorText: _errorMsg,
                keyboardType: TextInputType.visiblePassword,
                onchanged: (val) {
                  setState(() {
                    containUpperCase = RegExp(r'[A-Z]').hasMatch(val!);
                    containLowerCase = RegExp(r'[a-z]').hasMatch(val);
                    containDigit = RegExp(r'[0-9]').hasMatch(val);
                    containSpecialChar = RegExp(r'\W').hasMatch(val);
                    contain8Length = val.length >= 8;
                  });
                },
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please fill in this field.';
                  }
                  return containUpperCase &&
                          containLowerCase &&
                          containDigit &&
                          containSpecialChar &&
                          contain8Length
                      ? null
                      : 'Invalid password.';
                },
                prefixIcon: const Icon(CupertinoIcons.lock),
                suffixIcon: IconButton(
                  icon: obscurePassword
                      ? const Icon(
                          CupertinoIcons.eye_fill,
                          fill: 0.8,
                        )
                      : const Icon(
                          CupertinoIcons.eye_slash_fill,
                          fill: 0.8,
                        ),
                  onPressed: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                ),
              ),
              const SizedBox(height: 30),
              // After settle the sign in.
              !requireSignUp
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            MyUser myUser = MyUser.empty;
                            myUser.email = emailController.text;
                            myUser.name = userController.text;

                            setState(() {
                              context.read<SignUpBloc>().add(SignUpRequired(
                                  myUser, passwordController.text));
                            });
                          }
                        },
                        style: TextButton.styleFrom(
                            elevation: 3.0,
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            shadowColor: Theme.of(context).colorScheme.shadow),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 5),
                          child: Text('Sign Up',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary)),
                        ),
                      ),
                    )
                  : const CircularProgressIndicator(),
            ],
          )),
    );
  }
}
