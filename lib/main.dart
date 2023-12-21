import 'package:firebase_3/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'phone_login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const TextField(
          decoration: InputDecoration(
            labelText: 'Email',
            icon: Icon(Icons.email),
          ),
        ),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Password',
            icon: Icon(Icons.lock),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Implement login logic here
            // Navigate to the next screen if login is successful
          },
          child: const Text('Login'),
        ),
        TextButton(
          onPressed: () {
            // Navigate to the phone login page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PhoneLoginPage()),
            );
          },
          child: const Text('Phone Login'),
        ),
        TextButton(
          onPressed: () {
            // Navigate to the sign-up page
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SignUpPage(
                        context: context,
                      )),
            );
          },
          child: const Text('Create an account'),
        ),
      ],
    );
  }
}
