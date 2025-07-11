import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_app/login.dart';
import 'package:ecommerce_app/homePage.dart';
import 'dart:convert';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

 void _handleSignup() async {
  final username = _usernameController.text.trim();
  final email = _emailController.text.trim();
  final password = _passwordController.text.trim();

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All fields are required'),
        backgroundColor: Colors.red,
      ),
    );
    return; // Stop the function if validation fails
  }

  final url = Uri.parse('http://10.44.197.181:5000/api/auth/signup'); // Adjust route

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      // Success
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Signup successful! Please login.'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homepage()),
      );
    } else if (response.statusCode == 400) {
      // User already exists
      final data = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup failed: ${data['message']}')),
      );
    } else {
      final data = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup failed: ${data['message']}')),
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
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top:100.0),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
        
        
                  const SizedBox(height: 30),
        
                  // Signup text
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
                          TextSpan(text: 'Register to '),
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
                      'Create Your Account Here',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
        
                  const SizedBox(height: 30),
        
                  // Username field
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        border: InputBorder.none,
                        hintText: 'Full Name',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
        
                  // Email field
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _emailController,
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
        
                  // Signup button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _handleSignup,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFC727),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Signup',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
        
                  // Login link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account ?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );
                        },
                        child: const Text(
                          'Login',
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
      ),
    );
  }
}




// Add your existing LoginScreen class here
