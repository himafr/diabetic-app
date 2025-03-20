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
  final Function view;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool hasUppercase = false;
  bool hasDigits = false;
  bool hasLowercase = false;
  bool hasSpecialCharacters = false;
  bool hasMin8Characters = false;
  bool visible = true;
  String username = "";
  String password = "";
  String firstName = "";
  DateTime? selectedDate;

  String err = "";
  bool isLoading = false;
  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  void setError(String newErr) {
    setState(() {
      err = newErr;
    });
  }

  signup() async {
    setLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    NetworkHelper networkHelper = NetworkHelper(url: signupUrl);
    try {
      dynamic data = await networkHelper.postData({
        "username": username,
        "password": password,
        "first_name": firstName,
        "date_of_birth": selectedDate.toString()
      });
      if (data["status"] == "success") {
        await prefs.setString("token", data["token"]);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const DashboardScreen(title: "DashboardScreen")));

        setLoading(false);
      }
    } catch (e) {
      setError(e.toString());
      setLoading(false);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  onChangePassword(String password) {
    this.password = password;
    setState(() {
      password.contains(RegExp(r'[A-Z]'))
          ? hasUppercase = true
          : hasUppercase = false;
      password.contains(RegExp(r'[0-9]'))
          ? hasDigits = true
          : hasDigits = false;
      password.contains(RegExp(r'[a-z]'))
          ? hasLowercase = true
          : hasLowercase = false;
      password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))
          ? hasSpecialCharacters = true
          : hasSpecialCharacters = false;
      password.contains(RegExp(r'.{8,}'))
          ? hasMin8Characters = true
          : hasMin8Characters = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 30,
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              weight: 10,
            ),
            onPressed: () {
              widget.view("welcome");
            },
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: SingleChildScrollView(
              child: Form(
                // key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage("assets/images/logo.png"),
                      radius: 110,
                    ),
                    const Text(
                      "Green: Where Nature Thrives.",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      autofocus: false,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) => firstName = value,
                      decoration: decorationTextfield.copyWith(
                        hintText: "First name",
                        suffixIcon: const Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      keyboardType: TextInputType.name,
                      obscureText: false,
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) => username = value,
                      decoration: decorationTextfield.copyWith(
                        hintText: "Username",
                        suffixIcon: const Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          ElevatedButton(
                            style: const ButtonStyle().copyWith(
                                backgroundColor: const MaterialStatePropertyAll(
                                    Colors.white70)),
                            onPressed: () => _selectDate(context),
                            child: const Text('Select date'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(DateFormat.yMMMEd()
                              .format(selectedDate != null
                                  ? selectedDate!
                                  : DateTime.now())
                              .toString())
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged: (password) {
                        onChangePassword(password);
                      },
                      validator: (password) {
                        return password!.contains(RegExp(r'[A-Z]')) &&
                                password.contains(RegExp(r'[0-9]')) &&
                                password.contains(RegExp(r'[a-z]')) &&
                                password.contains(
                                    RegExp(r'[!@#$%^&*(),.?":{}|<>]')) &&
                                password.contains(RegExp(r'.{8,}'))
                            ? null
                            : "Your password is weak";
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: visible,
                      autofocus: false,
                      textInputAction: TextInputAction.done,
                      decoration: decorationTextfield.copyWith(
                        hintText: "Password",
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                visible = !visible;
                              });
                            },
                            icon: visible
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility)),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 15),
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                  color: hasUppercase
                                      ? Colors.green
                                      : Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(width: 0.7)),
                              child: const Icon(
                                Icons.check,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                            const Text("Has Uppercase")
                          ],
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 15),
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                  color: hasLowercase
                                      ? Colors.green
                                      : Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(width: 0.7)),
                              child: const Icon(
                                Icons.check,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                            const Text("Has Lowercase")
                          ],
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 15),
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                  color:
                                      hasDigits ? Colors.green : Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(width: 0.7)),
                              child: const Icon(
                                Icons.check,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                            const Text("Has Digits ")
                          ],
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 15),
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                  color: hasSpecialCharacters
                                      ? Colors.green
                                      : Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(width: 0.7)),
                              child: const Icon(
                                Icons.check,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                            const Text("Has Special Characters")
                          ],
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 15),
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                  color: hasMin8Characters
                                      ? Colors.green
                                      : Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(width: 0.7)),
                              child: const Icon(
                                Icons.check,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                            const Text("Has (min. 8) Characters")
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                        style: const ButtonStyle(
                            padding: MaterialStatePropertyAll(
                                EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 10)),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)))),
                            backgroundColor:
                                MaterialStatePropertyAll(kPrimaryColor)),
                        onPressed: () async {
                          signup();
                          // if (_formKey.currentState!.validate()) {
                          //   await register();
                          //   if (!mounted) return;
                          //   Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const Login()),
                          //   );
                          //   showSnackBar(context, "Done");
                          // } else {
                          //   showSnackBar(context,
                          //       "Something is wrong Please check your password or email");
                          // }
                        },
                        child:
                            // isloading
                            //     ? const CircularProgressIndicator(
                            //         color: Colors.white,
                            //       )
                            //     :
                            Text(
                          "Register",
                          style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Have an account ?",
                          style: TextStyle(
                            fontSize: 19,
                          ),
                        ),
                        TextButton(
                            style: const ButtonStyle(
                              overlayColor:
                                  MaterialStatePropertyAll(Colors.transparent),
                            ),
                            onPressed: () {
                              widget.view("login");
                            },
                            child: const Text(
                              "Sign in",
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue,
                              ),
                            ))
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
