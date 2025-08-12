import 'package:clevertap_plugin/clevertap_plugin.dart';
import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'dart:math';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String error = '';

  void login() {
    if (emailController.text != '' && isValidEmail(emailController.text) && passwordController.text != '') {
      onUserLogin(emailController.text);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardPage()));
    } else {
      setState(() {
        error = 'Invalid credentials';
      });
    }
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }


  void onUserLogin(String userEmail) {
    var stuff = ["bags", "shoes", "Perfumes"];
    var profile = {
      'Name': 'Captain_$userEmail',
      'Identity': generateHash(userEmail),
      'Email': userEmail,
      'Phone': generateRandomPhoneNumber(),
      'stuff': stuff
    };
    CleverTapPlugin.onUserLogin(profile);
  }

  String generateRandomPhoneNumber() {
    final rand = Random();
    final firstDigit = rand.nextInt(4) + 6; // 6, 7, 8, or 9
    final buffer = StringBuffer()..write(firstDigit);
    for (int i = 0; i < 9; i++) {
      buffer.write(rand.nextInt(10)); // 0–9
    }
    final mob = '+91${buffer.toString()}';
    print("Phone: $mob");
    return mob;
  }


  int generateHash(String input) {
    int hash = 0;
    for (int i = 0; i < input.length; i++) {
      hash = 31 * hash + input.codeUnitAt(i);
      hash &= 0x7FFFFFFF; // Ensure 32-bit positive int
    }
    return hash;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: passwordController, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: login, child: const Text('Login')),
            Text(error, style: const TextStyle(color: Colors.red))
          ]),
        ),
      ),
    );
  }
}
