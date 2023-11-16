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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  void _submit() {
    if (_loginFormKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Connecting')),
      );
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/img/back1.png"),
                        fit: BoxFit.cover)),
                child: SafeArea(
                  child: Column(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ArrowBack()
                      ),
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
                      const Text("Welcome back", style: kSectionTitle,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
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
                                child: const Text("Mot de passe oublié ?", style: kHintStyle),
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
                      const SizedBox(height: kVerticalPadding,),
                      Center(
                        child: Column(
                          children: [
                            const Text("Je n'ai pas encore de compte.", style: kItalicText,),
                            const SizedBox(height: kVerticalPaddingXS,),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(context, "/register"),
                              child: const Text("Créer mon compte !", style: kButtonTextStyle,),
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
        ));
  }
}
