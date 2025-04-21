// ignore_for_file: use_build_context_synchronously, avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:diabetic/screens/home/dashboardScreen.dart';
import 'package:diabetic/components/textfilled.dart';

import 'package:diabetic/services/networking.dart';
import 'package:diabetic/utils/constants.dart';
import 'package:diabetic/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.view});

  final Function(String viewName) view;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers (can be used if needed)
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // User input values
  String username = '';
  String password = '';

  // State variables
  bool isPasswordVisible = true;
  bool isLoading = false;
  String errorMsg = '';

  // Toggle loading state
  void setLoading(bool value) => setState(() => isLoading = value);

  // Set error message
  void setError(String message) => setState(() => errorMsg = message);

  /// Performs login API call
  Future<void> _login() async {
    setLoading(true);
    final prefs = await SharedPreferences.getInstance();
    final networkHelper = NetworkHelper(url: logInUrl);

    try {
      final response = await networkHelper.postData({
        "username": username,
        "password": password,
      });

      if (response["status"] == "success") {
        final role = response["data"]["userData"]["role"];
        if (role == "patient") {
          await prefs.setString("token", response["token"]);
          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const DashboardScreen(title: "DashboardScreen"),
            ),
          );
        } else {
          setError("User type '$role' is not allowed to log in as a patient.");
        }
      } else {
        setError("Login failed. Please check your credentials.");
      }
    } catch (e) {
      setError("An error occurred: $e");
    } finally {
      setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Back button
        Positioned(
          top: 30,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, weight: 10),
            onPressed: () => widget.view("welcome"),
          ),
        ),

        // Main form content
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App logo
                  CircleAvatar(
                    backgroundColor: Theme.of(context).canvasColor,
                    backgroundImage: const AssetImage("assets/images/logo.png"),
                    radius: 110,
                  ),
                  const SizedBox(height: 15),

                  // Welcome text
                  const Text(
                    "Welcome to Diabetic",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 50),

                  // Username input field
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: decorationTextfield.copyWith(
                      hintText: "Username",
                      suffixIcon: const Icon(Icons.account_circle),
                    ),
                    onChanged: (val) => username = val,
                  ),
                  const SizedBox(height: 30),

                  // Password input field
                  TextField(
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    obscureText: isPasswordVisible,
                    decoration: decorationTextfield.copyWith(
                      hintText: "Password",
                      suffixIcon: IconButton(
                        icon: Icon(isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () =>
                            setState(() => isPasswordVisible = !isPasswordVisible),
                      ),
                    ),
                    onChanged: (val) => password = val,
                  ),
                  const SizedBox(height: 20),

                  // Error message (if any)
                  if (errorMsg.isNotEmpty)
                    Text(
                      errorMsg,
                      style: const TextStyle(color: Colors.red),
                    ),
                  const SizedBox(height: 20),

                  // Login button
                  ElevatedButton(
                    onPressed: isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[200],
                            ),
                          ),
                  ),
                  const SizedBox(height: 30),

                  // Signup navigation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?", style: TextStyle(fontSize: 19)),
                      TextButton(
                        onPressed: () => widget.view("signup"),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.blue,
                          
                          textStyle: TextStyle(decoration: TextDecoration.none)
                        ),
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
