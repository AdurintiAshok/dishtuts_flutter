

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:meals/screens/signin_page.dart';
import 'package:meals/widgets/widget.dart';
import '../constants.dart';
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool passwordVisibility = true;
   TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
void registerUser(String email, String password,String number, BuildContext context) async {
  try {
    // Validate email format
    if (!_isValidEmail(email)) {
      _showAlertDialog(context, 'Invalid Email', 'Please enter a valid email address.');
      return; // Stop registration if email is invalid
    }

    // Validate password
    if (!_isValidPassword(password)) {
      _showAlertDialog(context, 'Invalid Password', 'Password should be at least 6 characters long.');
      return; // Stop registration if password is invalid
    }
    if (!_isValidPhoneNumber(number)) {
      _showAlertDialog(context, 'Invalid Phone Number', 'Please enter a valid phone number.');
      return; // Stop registration if phone number is invalid
    }
     UserCredential authResult  =await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? user = authResult.user;
    if (user != null) {
      await saveUserDataToDatabase(user.uid, _emailController.text, _nameController.text);
      print('User registered successfully and data saved to database');
    }
    Navigator.push(context, MaterialPageRoute(builder: (ctx)=>SignInPage()));
  } catch (e) {
    // Registration failed
    print('Error registering user: $e');
  }
}
Future<void> saveUserDataToDatabase(
    String userId, String email, String displayName) async {
  final userRef = FirebaseDatabase.instance.ref().child('users');
  await userRef.child(userId).set({
    'email': _emailController.text,
    'displayName': _nameController.text,
    'password':_passwordController.text
    // Add more user data fields as needed
  });
}
// Validate email format
bool _isValidEmail(String email) {
  final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  return emailRegExp.hasMatch(email);
}

// Validate password (at least 6 characters)
bool _isValidPassword(String password) {
  return password.length >= 6;
}
bool _isValidPhoneNumber(String phoneNumber) {
  final phoneRegExp = RegExp(r'^\d{10}$'); // Assumes a 10-digit phone number
  return phoneRegExp.hasMatch(phoneNumber);
}


// Function to show an alert dialog
void _showAlertDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
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
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Register",
                            style: kHeadline,
                          ),
                          Text(
                            "Create new account to get started.",
                            style: kBodyText2,
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          MyTextField(
                            controller: _nameController,
                            hintText: 'Name',
                            inputType: TextInputType.name,
                          ),
                          MyTextField(
                            controller: _emailController,
                            hintText: 'Email',
                            inputType: TextInputType.emailAddress,
                          ),
                          MyTextField(
                            controller: _phoneController,
                            hintText: 'Phone',
                            inputType: TextInputType.phone,
                          ),
                          MyPasswordField(
                            controller:_passwordController ,
                            isPasswordVisible: passwordVisibility,
                            onTap: () {
                              setState(() {
                                passwordVisibility = !passwordVisibility;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: kBodyText,
                        ),
                          GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => SignInPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Sign-in',
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
                      
                      buttonName: 'Register',
                      onTap:(){registerUser(_emailController.text, _passwordController.text, _phoneController.text,context);},
                      bgColor: Colors.white,
                      textColor: Colors.black87,
                      
                    )
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
