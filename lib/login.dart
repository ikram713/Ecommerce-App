import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_app/homePage.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_app/signup.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

void _handleLogin() async {
  final email = _fullNameController.text.trim();
  final password = _passwordController.text.trim();

  final url = Uri.parse('http://10.44.197.181:5000/api/auth/login');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];

      // Save the token to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', token);

      // Example: show success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
      content: Text('Login successful!'),
      backgroundColor: Colors.green, 
    ),
  );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homepage()),
      );

    } else {
      final data = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: ${data['message']}')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}


  @override
  void dispose() {
    _fullNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Illustration image
                Center(
                  child: Image.asset(
                    'images/login.png', 
                    height: 250,
                  ),
                ),

                const SizedBox(height: 30),

                // Welcome text
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(text: 'Welcome Back to '),
                        TextSpan(
                          text: 'ShopEase',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFFC727),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    'Login To Your Account',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),

                const SizedBox(height: 30),

                // Full Name field
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _fullNameController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      border: InputBorder.none,
                      hintText: 'Email',
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Password field
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock),
                      border: InputBorder.none,
                      hintText: 'Password',
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Login button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFC727),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Signup link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account ?"),
                    TextButton(
                      onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const SignupPage()),
                            );
                      },
                      child: const Text(
                        'Signup',
                        style: TextStyle(color: Color(0xFFFFC727)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}