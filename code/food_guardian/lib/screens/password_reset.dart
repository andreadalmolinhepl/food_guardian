import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:food_guardian/styles/spacings.dart';
import 'package:food_guardian/widgets/main_button.dart';

import '../styles/font.dart';
import '../utils/validations.dart';
import '../widgets/arrow_back.dart';
import '../widgets/text_input.dart';

class PasswordResetScreen extends StatefulWidget {
  static const String routeName = "/passwordReset";

  const PasswordResetScreen({super.key});

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final _emailController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> resetPassword() async {
    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text.trim());
      if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password reset email sent!')),
        );
      }
    } on FirebaseAuthException catch (e) {
      if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.message}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              child: IntrinsicHeight(
                child: SafeArea(
                  child: Column(
                    children: [
                      const Padding(padding: EdgeInsets.all(kHorizontalPaddingS), child: ArrowBack()),
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
                      const SizedBox(height: kVerticalPaddingL),
                      Text(
                        AppLocalizations.of(context)!.forgottenPassword,
                        style: kSectionTitle,
                      ),
                      const SizedBox(height: kVerticalPaddingL),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                        child: TextInput(
                            controller: _emailController,
                            // Add this line
                            prefixIcon: Icons.email_outlined,
                            hintText: "andrea@gmail.com",
                            labelText: AppLocalizations.of(context)!.emailAddress,
                            validator: validateEmail),
                      ),
                      const SizedBox(height: kVerticalPadding),
                      MainButton(label: "Reset password", onTap: resetPassword),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
