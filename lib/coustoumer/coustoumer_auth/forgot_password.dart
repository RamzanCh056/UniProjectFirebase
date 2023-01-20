import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:uni_project/common_textfield/common_textfield.dart';


class ForgotPassword extends StatefulWidget {
  bool isFromBiometricPage;

  ForgotPassword({this.isFromBiometricPage = false});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();

}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool showPass = true;
  bool isLoading = false;


  @override
  void initState() {

    super.initState();
  }
  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
      // ScaffoldMessenger.of(context).
      Fluttertoast.showToast(msg: 'Password Reset Email has been sent !');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'No user found!');

      }
    }
  }
  @override
  Widget build(BuildContext context) {
    var _passwordVisible;
    return Scaffold(

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 80,),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Forget Password",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
                  const SizedBox(
                    height: 24,
                  ),
                  CommonTextFieldWithTitle(
                      'email', 'Enter Your email', email, (val) {
                    if (val!.isEmpty) {
                      return 'This is required field';
                    }
                  }),
                  const SizedBox(
                    height: 14,
                  ),


                  SizedBox(
                    height: 5,
                  ),
                  isLoading
                      ? Center(
                    child: SizedBox(
                        width: 80,
                        child: LoadingIndicator(
                            indicatorType: Indicator.ballBeat,
                            colors: [
                              Theme.of(context).primaryColor,
                            ],
                            strokeWidth: 2,
                            pathBackgroundColor:
                            Theme.of(context).primaryColor)),
                  ):
                  buttonWidget(),
                  SizedBox(
                    height: 10,
                  ),


                ],
              ),
            ),
          ),
        ));
  }

  Widget buttonWidget() {
    return ButtonTheme(
      height: 47,
      minWidth: MediaQuery.of(context).size.width,
      child: MaterialButton(
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            resetPassword();
          }
        },
        child: const Text(
          'Confirm',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),

      ),

    );

  }

}