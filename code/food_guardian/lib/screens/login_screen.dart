import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_guardian/widgets/arrow_back.dart';

import '../styles/font.dart';
import '../styles/spacings.dart';
import '../utils/validations.dart';
import '../widgets/main_button.dart';
import '../widgets/text_input.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/login";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
    });

    if (_loginFormKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: _emailController.text,
              password: _passwordController.text,
            )
            .then((value) => {
              setState(() {
              _isLoading = false;
              }),
              Navigator.pushNamedAndRemoveUntil(context, "/home", (r) => false)
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          setState(() {
            _isLoading = false;
          });

          _showSnackBar('No user found for that email');
        } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
          setState(() {
            _isLoading = false;
          });

          _showSnackBar('Wrong password provided for that user');
        } else {
          setState(() {
            _isLoading = false;
          });

          _showSnackBar("Something terrible happened, please try again later");

        }
      }
    } else {
      setState(() {
        _isLoading = false;
      });

      _showSnackBar("Please fill in all required fields.");
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            child: IntrinsicHeight(
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    const Padding(
                        padding: EdgeInsets.all(8.0), child: ArrowBack()),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage("assets/img/food.png"),
                          height: kProfileSize,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                    const SizedBox(height: kVerticalPaddingXL),
                    const Text(
                      "Welcome back",
                      style: kSectionTitle,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kHorizontalPadding),
                      child: Form(
                        key: _loginFormKey,
                        child: Column(
                          children: <Widget>[
                            TextInput(
                                controller: _emailController,
                                // Add this line
                                prefixIcon: Icons.email_outlined,
                                hintText: "andrea@gmail.com",
                                labelText: "Adresse mail",
                                validator: validateEmail),
                            TextInput(
                              controller: _passwordController,
                              // Add this line
                              prefixIcon: Icons.password,
                              hintText: "*********",
                              labelText: "Mot de passe",
                              validator: validatePassword,
                              obscureText: !_isPasswordVisible,
                              suffixIcon: GestureDetector(
                                child: _isPasswordVisible
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                                onTap: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(context, "/"),
                              child: const Text("Mot de passe oublié ?",
                                  style: kHintStyle),
                            ),
                            const SizedBox(height: kVerticalPadding),
                            Align(
                                alignment: Alignment.centerRight,
                                child: MainButton(
                                    label: "Je me connecte", onTap: _submit)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: kVerticalPadding,
                    ),
                    Center(
                      child: Column(
                        children: [
                          const Text(
                            "Je n'ai pas encore de compte.",
                            style: kItalicText,
                          ),
                          const SizedBox(
                            height: kVerticalPaddingXS,
                          ),
                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, "/register"),
                            child: const Text(
                              "Créer mon compte !",
                              style: kButtonTextStyle,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (_isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ]),
    );
  }
}
