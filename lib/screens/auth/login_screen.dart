// ignore_for_file: use_build_context_synchronously, avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:diabetic/screens/home/dashboardScreen.dart';
import 'package:diabetic/components/textfilled.dart';

import 'package:diabetic/services/networking.dart';
import 'package:diabetic/utils/constants.dart';
import 'package:diabetic/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.view});
  final Function view;
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   final emailController = TextEditingController();
  final passwordController = TextEditingController();
   String password="";
   String username = "";
  bool visible = true;
  @override
  void initState() {
    super.initState();
  }
  
   String err="";
  bool isLoading = false;
void setLoading(bool value) {
  setState(() {
 isLoading = value;   
  });
}
void setError(String newErr){
setState(() {
  err=newErr;
});
}
  _login() async {
    setLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    NetworkHelper networkHelper =
        NetworkHelper(url: logInUrl);
        print(networkHelper.url);
    try {
      dynamic data = await networkHelper
          .postData({"username": username, "password": password});
          print(data);
      if (data["status"] == "success") {
        if(data["data"]["userData"]["role"]=="patient"){
        await prefs.setString("token", data["token"]);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const DashboardScreen(title: "DashboardScreen")));
        }else{
          print("object");
          setError("user type ${data["data"]["userData"]["role"]} cant be a patient");
        }
        setLoading(false);
      }
    } catch (e) {
          setError(e.toString());
        setLoading(false);
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children:[ 
        Positioned(
          top: 30,
          child:  IconButton(
        icon: const Icon(Icons.arrow_back_ios,
        weight: 10,),
        onPressed: () {
         widget.view("welcome");
        },
      ),),
    Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).canvasColor,
                      backgroundImage: AssetImage("assets/images/logo.png"),
                      radius: 110,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Welcome to Diabetic",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,),
                ),
                SizedBox(
                  height: 50,
                ),
                TextField(
                  // controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  autofocus: false,
                  textInputAction: TextInputAction.next,
                  decoration: decorationTextfield.copyWith(
                      hintText: "Username", suffixIcon: Icon(Icons.email)),
                      onChanged: (value) => {username = value},
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  onChanged: (value) => password=value,
                  // controller: passwordController,
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
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(err,style: TextStyle(color: Colors.red),),
                  SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                   _login();
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 40, vertical: 10)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(18)))),
                      backgroundColor: MaterialStateProperty.all(kPrimaryColor)),
                
                  child: isLoading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[200]),
                        )
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account ?",
                      style: TextStyle(
                        fontSize: 19,
                      ),
                    ),
                    TextButton(
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        onPressed: () {
                        widget.view("signup");
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.blue,
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: 17,
                ),
                SizedBox(
                  width: 299,
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                        thickness: 0.6,
                      )),
                      Text(
                        "OR",
                        style: TextStyle(),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 0.6,
                      )),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 27),
                  child: GestureDetector(
                    onTap: () {
                      // googleSignInProvider.googlelogin();
                    },
                    child: Container(
                      padding: EdgeInsets.all(13),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              // color: Colors.purple,
                              color: Color.fromARGB(255, 200, 67, 79),
                              width: 2)),
                      child: SvgPicture.asset(
                        "assets/icons/google.svg",
                        // ignore: deprecated_member_use
                        color: Color.fromARGB(255, 200, 67, 79),
                        height: 27,
                      ),
                    ),
                  ),
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
