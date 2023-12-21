import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneLoginPage extends StatelessWidget {
  const PhoneLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneNumberController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: phoneNumberController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  icon: Icon(Icons.phone),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final phoneNumber = phoneNumberController.text;
                  if (phoneNumber.isNotEmpty) {
                    // Send a verification code to the provided phone number
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: phoneNumber,
                      verificationCompleted: (PhoneAuthCredential credential) {
                        // Auto-retrieve the SMS code on iOS and sign in
                        FirebaseAuth.instance.signInWithCredential(credential);
                      },
                      verificationFailed: (FirebaseAuthException e) {
                        print('Error: $e');
                      },
                      codeSent: (String verificationId, int? resendToken) {
                        // Navigate to a new screen to enter the verification code
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                VerifyCodePage(verificationId: verificationId),
                          ),
                        );
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {
                        // Auto-retrieval of SMS code timed out
                      },
                    );
                  }
                },
                child: const Text('Send Verification Code'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VerifyCodePage extends StatelessWidget {
  final String verificationId;

  VerifyCodePage({super.key, required this.verificationId});

  final TextEditingController verificationCodeController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Code'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: verificationCodeController,
                decoration: const InputDecoration(
                  labelText: 'Verification Code',
                  icon: Icon(Icons.security),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final verificationCode = verificationCodeController.text;
                  if (verificationCode.isNotEmpty) {
                    // Sign in with the verification code
                    final authCredential = PhoneAuthProvider.credential(
                      verificationId: verificationId,
                      smsCode: verificationCode,
                    );
                    await FirebaseAuth.instance
                        .signInWithCredential(authCredential);
                    // After successful login, navigate to the desired screen
                  }
                },
                child: const Text('Verify Code'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
