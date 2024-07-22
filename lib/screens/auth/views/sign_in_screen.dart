import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/auth/components/my_form_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool requireSignIn = false;
  IconData iconPassword = Icons.remove_red_eye;
  bool obscurePassword = true;
  String? _errorMsg;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
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
                  return null;
                },
                prefixIcon: const Icon(CupertinoIcons.mail)),
            MyCustomForm(
              hintText: 'Password',
              obscureText: obscurePassword,
              textEditingController: passwordController,
              errorText: _errorMsg,
              keyboardType: TextInputType.visiblePassword,
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Please fill in this field.';
                }
                return null;
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
            !requireSignIn
                ? SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Implements the form here
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
                        child: Text('Sign IN',
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onPrimary)),
                      ),
                    ),
                  )
                : const CircularProgressIndicator(),
          ],
        ));
  }
}
