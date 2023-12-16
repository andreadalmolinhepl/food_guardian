import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_guardian/widgets/arrow_back.dart';

import '../styles/font.dart';
import '../styles/spacings.dart';
import '../utils/validations.dart';
import '../widgets/main_button.dart';
import '../widgets/text_input.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "/register";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _registerFormKey = GlobalKey<FormState>();
  bool _isLoading = false;

  bool _isPasswordVisible = false;
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _submit() async {
    setState(() {
      _isLoading = true; // Set loading state to true when submitting
    });

    if (_registerFormKey.currentState!.validate()) {
      final FirebaseAuth auth = FirebaseAuth.instance;
      try {
        UserCredential result = await auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        final User? newUser = result.user;

        if (newUser != null) {
          var usersRef = FirebaseFirestore.instance.collection("users");

          Map<String, dynamic> userData = {
            'uid': newUser.uid,
            'email': newUser.email,
            'displayName': _firstnameController.text,
            'emailVerified': newUser.emailVerified,
          };

          await usersRef.add(userData);

          setState(() {
            _isLoading = false; // Set loading state to false in case of exception
          });

          _showSnackBar("User registered successfully!");
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          _showSnackBar('This email is already in use');
          setState(() {
            _isLoading = false; // Set loading state to false if validation fails
          });
        } else {
          _showSnackBar("An error occurred during registration. Please try again later");
          setState(() {
            _isLoading = false; // Set loading state to false if validation fails
          });
        }
      }
    } else {
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
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: kVerticalPaddingXL),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kHorizontalPadding),
                          child: Form(
                            key: _registerFormKey,
                            child: Column(
                              children: <Widget>[
                                TextInput(
                                    controller: _firstnameController,
                                    // Add this line
                                    prefixIcon: Icons.person,
                                    hintText: "Andrea",
                                    labelText: "Prénom",
                                    validator: validateName),
                                TextInput(
                                    controller: _lastnameController,
                                    // Add this line
                                    prefixIcon: Icons.person,
                                    hintText: "Dal Molin",
                                    labelText: "Nom",
                                    validator: validateName),
                                TextInput(
                                    controller: _emailController,
                                    // Add this line
                                    prefixIcon: Icons.email,
                                    hintText: "andrea@gmail.com",
                                    labelText: "Adresse Mail",
                                    validator: validateEmail),
                                TextInput(
                                  controller: _passwordController,
                                  // Add this line
                                  prefixIcon: Icons.password,
                                  hintText: "*********",
                                  labelText: "Password",
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
                                const SizedBox(height: kVerticalPaddingL),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: MainButton(
                                        label: "Créer mon compte",
                                        onTap: _submit)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: kVerticalPaddingXL),
                      ],
                    ),
                  ),
                ),
              ),
              const Positioned(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ArrowBack()
                ),
              ),
              if (_isLoading) // Show loading indicator conditionally
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        ));
  }
}
