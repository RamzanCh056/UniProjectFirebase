import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_project/common_textfield/common_textfield.dart';
import 'package:uni_project/coustoumer/coustoumer_auth/forgot_password.dart';
import 'package:uni_project/coustoumer/coustoumer_auth/register_page.dart';

import '../home_page/home_page.dart';



class LoginScreen extends StatefulWidget {
  bool isFromBiometricPage;

  LoginScreen({this.isFromBiometricPage = false});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();



  final storage = FlutterSecureStorage();
  final formKey = GlobalKey<FormState>();

  bool showPass = true;
  bool isLoading = false;


  @override
  void initState() {

    super.initState();
  }
  userLogin() async {
    isLoading = true;
    setState(() {});
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      UserCredential userCredential=await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.text, password: password.text);

      print(userCredential.user?.uid);
      await storage.write(key: "uid", value: userCredential.user?.uid);
      isLoading = false;
      setState(() {});
      await preferences.setString('user', email.text.trim());

      Fluttertoast.showToast(msg: 'Successfully logged in');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home_Page(),
        ),
      );


    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("No User Found for that Email");
        isLoading = false;
        setState(() {});
        Fluttertoast.showToast(msg: 'No User Found for that Email');

      } else if (e.code == 'wrong-password') {
        print("Wrong Password Provided by User");
        isLoading = false;
        setState(() {});
        Fluttertoast.showToast(msg: 'Wrong Password Provided by User');

      }
    }
  }

  @override

  Widget build(BuildContext context) {
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
                  Text("Sign In",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
                  const SizedBox(
                    height: 24,
                  ),
                  CommonTextFieldWithTitle(
                      'email', 'Enter Yor email', email, (val) {
                    if (val!.isEmpty) {
                      return 'This is required field';
                    }
                  }),
                  const SizedBox(
                    height: 14,
                  ),
                  CommonTextFieldWithTitle('Password', 'Enter Password', password,
                      suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              showPass = !showPass;

                            });
                          },

                          child: const Icon(Icons.remove_red_eye)),

                      obscure: showPass,
                          (val) {
                        if (val!.isEmpty) {
                          return 'This is required field';
                        }
                      }),
                  const SizedBox(
                    height: 22,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword()));
                          },
                          child: const Text("Forgot Password",style: TextStyle(color: Colors.blue),))
                    ],
                  ),
                  const SizedBox(
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
                  const  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const  Text(
                        "Don't have account?",
                        style: TextStyle(
                            color: Colors.grey, fontSize: 15, letterSpacing: 0.8),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                        },
                        child:const  Text(
                          "SignUp",
                          style: TextStyle(
                              color: Colors.blue, fontSize: 16, letterSpacing: 0.8),
                        ),
                      ),

                    ],
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


            userLogin();
          }
        },
        child: const Text(
          'Login',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),

      ),

    );

  }

}