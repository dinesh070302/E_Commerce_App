import 'package:e_commerce_website/Widgets/custom_button.dart';
import 'package:e_commerce_website/Widgets/custom_input.dart';
import 'package:e_commerce_website/constants.dart';
import 'package:e_commerce_website/screens/home_page.dart';
import 'package:e_commerce_website/screens/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text(error),
            ),
            actions: [
              TextButton(
                child: Text("Close Alert"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  //Create new user
  Future<String?> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _loginEmail, password: _loginPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exits for the mail';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitForm() async {
    //set the form to loading state
    setState(() {
      loadingForLogin = true;
    });

    //Create new account function call
    String? _logInFeedback = await _loginAccount();

    // if recieve some error
    if (_logInFeedback != null) {
      _alertDialogBuilder(_logInFeedback);
      //set the loading state to false because of thye dialog
      setState(() {
        loadingForLogin = false;
      });
    }
    //  else {
    //   //As the string is empty beacuse of no errors we close the login screens and head to homepage
    //   Navigator.pop(context);
    //   // Navigator.push(
    //   //   context,
    //   //   MaterialPageRoute(
    //   //     builder: (context) => HomePage(),
    //   //   ),
    //   // );
    // }
  }

  bool loadingForLogin = false;

  //Form Input Field variables
  String _loginEmail = "";
  String _loginPassword = "";

  //focusNodes for input fields
  late FocusNode _passwordFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 24.0),
              child: const Text(
                "Welcome User,\n Login to your account",
                textAlign: TextAlign.center,
                style: Constants.boldHeading,
              ),
            ),
            Column(
              children: [
                CustomInput(
                  isPasswordField: false,
                  hintText: "Email...",
                  onChanged: (value) {
                    _loginEmail = value;
                  },
                  onSubmitted: (value) {
                    _passwordFocusNode.requestFocus();
                  },
                  textInputAction: TextInputAction.next,
                ),
                CustomInput(
                  isPasswordField: true,
                  hintText: "Password...",
                  onChanged: (value) {
                    _loginPassword = value;
                  },
                  focusNode: _passwordFocusNode,
                  onSubmitted: (value) {
                    _submitForm();
                  },
                ),
                CustomButton(
                    text: "Login",
                    onPressed: () {
                      _submitForm();
                      // print("Login button Clicked");
                      // setState(() {
                      //   print("Enterd");
                      //   loadingForLogin = true;
                      // });
                      // _alertDialogBuilder();
                    },
                    isFormLoading: loadingForLogin,
                    outlineButton: false)
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: CustomButton(
                isFormLoading: false,
                text: "Create New Account",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                    ),
                  );
                },
                outlineButton: true,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
