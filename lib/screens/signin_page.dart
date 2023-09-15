

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals/screens/tabs.dart';
import '../constants.dart';
import '../screens/screen.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import '../widgets/widget.dart';
  import 'package:firebase_auth/firebase_auth.dart';
class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {


// Initialize Firebase Authentication
final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isPasswordVisible = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

bool _isValidEmail(String email) {
  final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  return emailRegExp.hasMatch(email);
}

// Function to validate password (at least 6 characters)
bool _isValidPassword(String password) {
  return password.length >= 6;
}
Future<void> loginUser(String email, String password, BuildContext context) async {
  try {
    // Validate email format
    if (!_isValidEmail(email)) {
      _showAlertDialog(context, 'Invalid Email', 'Please enter a valid email address.');
      return; // Stop login if email is invalid
    }

    // Validate password
    if (!_isValidPassword(password)) {
      _showAlertDialog(context, 'Invalid Password', 'Password should be at least 6 characters long.');
      return; // Stop login if password is invalid
    }

    // Perform login
    UserCredential? authResult=await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    String useremail=authResult.user?.email ?? "User Not Found";
    print('User logged in successfully');
    Navigator.push(context, MaterialPageRoute(builder: (ctx)=>TabsScreen(useremail:useremail)));
    // You can add code here to navigate to a different screen after successful login
  } catch (e) {
       if (e is FirebaseAuthException) {
      if (e.code == 'user-not-found') {
        // User not found, display an alert
        _showAlertDialog(context, 'User Not Found', 'No user found with this email.');
      } else {
        // Other FirebaseAuth exceptions, display an appropriate error message
        _showAlertDialog(context, 'Error', 'Login failed: ${e.message}');
      }
    } else {
      // Other exceptions, display a general error message
      _showAlertDialog(context, 'Error', 'Login failed: $e');
    }
  

  }
}
void _showAlertDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
              backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image(
            width: 24,
            color: Colors.white,
            image: Svg('assets/images/back_arrow.svg'),
          ),
        ),
      ),
      body: SafeArea(
        //to make page scrollable
        child: CustomScrollView(
          reverse: true,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome back.",
                            style: kHeadline,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "You've been missed!",
                            style: kBodyText2,
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          MyTextField(
                             controller: _usernameController,
                            hintText: 'Phone, email or username',
                            inputType: TextInputType.text,
                          ),
                          MyPasswordField(
                            isPasswordVisible: isPasswordVisible,
                            controller: _passwordController,
                            onTap: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Dont't have an account? ",
                          style: kBodyText,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => RegisterPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Register',
                            style: kBodyText.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MyTextButton(
                      buttonName: 'Sign In',
                      onTap:(){loginUser(_usernameController.text,_passwordController.text,context);},
                      bgColor: Colors.white,
                      textColor: Colors.black87,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
