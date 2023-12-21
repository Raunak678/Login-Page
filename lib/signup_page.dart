import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'services/firebase_auth_methods.dart';

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class SignUpPage extends StatelessWidget {
  final BuildContext context;

  const SignUpPage({Key? key, required this.context}) : super(key: key);

  Future<void> signUpUser() async {
    try {
      await FirebaseAuthMethods(
        FirebaseAuth.instance,
        (BuildContext context, String message) {
          // Handle error messages here if needed.
          print("Error: $message");
          // Show an error message to the user using a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
            ),
          );
        },
      ).signUpWithEmail(
          email: emailController.text,
          password: passwordController.text,
          context: context);

      // The sign-up was successful, navigate to the next screen.
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const YourHomeScreen()));
    } catch (e) {
      // Handle other errors as needed.
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SignUpForm(signUpUser: signUpUser),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final bool obscureText;
  final TextEditingController controller;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.icon,
    this.obscureText = false,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        icon: Icon(icon),
      ),
      obscureText: obscureText,
    );
  }
}

class SignUpForm extends StatelessWidget {
  final void Function() signUpUser;

  const SignUpForm({Key? key, required this.signUpUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CustomTextField(
          controller: emailController,
          labelText: 'Email',
          icon: Icons.email,
        ),
        CustomTextField(
          controller: passwordController,
          labelText: 'Password',
          icon: Icons.lock,
          obscureText: true,
        ),
        const SizedBox(height: 20),
        InkWell(
          onTap: signUpUser,
          child: const Text('Sign Up'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Back to Login'),
        ),
      ],
    );
  }
}

class YourHomeScreen extends StatelessWidget {
  const YourHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Your home screen implementation goes here.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: const Center(
        child: Text('Welcome to the Home Screen!'),
      ),
    );
  }
}
