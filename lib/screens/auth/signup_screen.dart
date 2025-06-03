// ignore_for_file: use_build_context_synchronously

import 'package:diabetic/screens/home/dashboardScreen.dart';
import 'package:diabetic/services/networking.dart';
import 'package:diabetic/utils/constants.dart';
import 'package:diabetic/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diabetic/components/textfilled.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key, required this.view});
  final Function(String viewName) view;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool hasUppercase = false;
  bool hasDigits = false;
  bool hasLowercase = false;
  bool hasSpecialChars = false;
  bool hasMinLength = false;
  bool isPasswordVisible = true;

  String username = '';
  String password = '';
  String firstName = '';
  DateTime? selectedDate;

  String errorMsg = '';
  bool isLoading = false;

  void setLoading(bool value) {
    setState(() => isLoading = value);
  }

  void setError(String message) {
    setState(() => errorMsg = message);
  }

  void updatePasswordStrength(String pwd) {
    password = pwd;
    setState(() {
      hasUppercase = RegExp(r'[A-Z]').hasMatch(pwd);
      hasDigits = RegExp(r'[0-9]').hasMatch(pwd);
      hasLowercase = RegExp(r'[a-z]').hasMatch(pwd);
      hasSpecialChars = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(pwd);
      hasMinLength = pwd.length >= 8;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() => selectedDate = pickedDate);
    }
  }

  Future<void> _register() async {
    setLoading(true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final networkHelper = NetworkHelper(url: signupUrl);
      final response = await networkHelper.postData({
        'username': username,
        'password': password,
        'first_name': firstName,
        'date_of_birth': selectedDate.toString(),
      });
      if (response['status'] == 'success') {
        await prefs.setString('token', response['token']);
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const DashboardScreen(title: 
            'DashboardScreen'),
          ), );
      } else {
        setError(response['message'] ?? 'Registration failed.');
      }
    } catch (e) {
      setError('An error occurred: $e');
    } finally {
      setLoading(false);
    }
  }

  Widget _buildPasswordCriteria(String label, bool condition) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: condition ? Colors.green : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(width: 0.7),
            ),
            child: const Icon(Icons.check, size: 15, color: Colors.white),
          ),
          Text(label),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 30,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, weight: 10),
            onPressed: () => widget.view('welcome'),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: SingleChildScrollView(
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage("assets/images/logo.png"),
                      radius: 110,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Welcome to Diabetic",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 40),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      onChanged: (val) => firstName = val,
                      decoration: decorationTextfield.copyWith(
                        hintText: "First name",
                        suffixIcon: const Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onChanged: (val) => username = val,
                      decoration: decorationTextfield.copyWith(
                        hintText: "Username",
                        suffixIcon: const Icon(Icons.account_circle),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.white70),
                          onPressed: () => _selectDate(context),
                          child: const Text("Select Date"),
                        ),
                        const SizedBox(width: 10),
                        Text(DateFormat.yMMMEd().format(selectedDate ?? DateTime.now())),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      obscureText: isPasswordVisible,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: updatePasswordStrength,
                      validator: (pwd) {
                        if (pwd == null ||
                            !hasUppercase ||
                            !hasLowercase ||
                            !hasDigits ||
                            !hasSpecialChars ||
                            !hasMinLength) {
                          return "Your password is weak";
                        }
                        return null;
                      },
                      decoration: decorationTextfield.copyWith(
                        hintText: "Password",
                        suffixIcon: IconButton(
                          icon: Icon(isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() => isPasswordVisible = !isPasswordVisible);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Column(
                      children: [
                        _buildPasswordCriteria("Has Uppercase", hasUppercase),
                        _buildPasswordCriteria("Has Lowercase", hasLowercase),
                        _buildPasswordCriteria("Has Digits", hasDigits),
                        _buildPasswordCriteria("Has Special Characters", hasSpecialChars),
                        _buildPasswordCriteria("Has (min. 8) Characters", hasMinLength),
                      ],
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: isLoading ? null : _register,
                      child: const Text(
                        "Register",
                        style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Have an account?", style: TextStyle(fontSize: 19)),
                        TextButton(
                          onPressed: () => widget.view("login"),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.blue,
                          ),
                          child: const Text(
                            "Sign in",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
