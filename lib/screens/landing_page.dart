import 'package:e_commerce_website/constants.dart';
import 'package:e_commerce_website/screens/home_page.dart';
import 'package:e_commerce_website/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);

  final Future<FirebaseApp> _intialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _intialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error ${snapshot.error}"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          //Stream Builder can check the login state

          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamSnapshot) {
              if (streamSnapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error ${streamSnapshot.error}"),
                  ),
                );
              }

              //Connection State Active - Do the user login
              if (streamSnapshot.connectionState == ConnectionState.active) {
                //get the user from the stream
                User? _user = streamSnapshot.data as User?;

                //if the user is null we are not logged in
                if (_user == null) {
                  //login unsuccesful so so to loginpage
                  return LoginPage();
                } else {
                  return HomePage();
                }
              }

              //checking the authentication state - Loading...
              return const Scaffold(
                body: Center(
                    child: Text(
                  "Checking Authentication..",
                  style: Constants.regularHeading,
                )),
              );
            },
          );
        }
        return const Scaffold(
          body: Center(
              child: Text(
            "Intialization App...",
            style: Constants.regularHeading,
          )),
        );
      },
    );
  }
}
