import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals/screens/screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Image.asset('assets/images/boy.png'),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Order Your Food Now',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 35, right: 35),
              child: Text(
                "Order Food and get Delivery within few  minutes to your door ",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height:100,),
            GestureDetector(
              onTap: () {
             Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => WelcomePage(),
                              ));
              },
              child: Container(
                margin: EdgeInsets.only(top: 30),
               width:300.0, // Adjust the width as needed
        height:50.0,
                decoration: BoxDecoration(
                  color: Colors.white, // White background color
                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Get Started', // Black text
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.food_bank_sharp, // Food icon (you can change this)
                      color: Colors.black, // Black icon color
                      size: 24.0,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
