import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../common_textfield/common_textfield.dart';
import 'login_page.dart';


class RegisterScreen extends StatefulWidget {
  bool isFromBiometricPage;

  RegisterScreen({this.isFromBiometricPage = false});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController email = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool showPass = true;
  bool isLoading = false;


  @override
  void initState() {
    super.initState();
  }
  registration() async {
    isLoading = true;
    setState(() {});
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email:email.text, password: password.text);
      print(userCredential);
      isLoading = false;
      setState(() {});
      Fluttertoast.showToast(msg: 'Registered Successfully. Please Login');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print("Password Provided is too Weak");
        isLoading = false;
        setState(() {});
        Fluttertoast.showToast(msg: 'Password Provided is too Weak');

      } else if (e.code == 'email-already-in-use') {
        print("Account Already exists");
        isLoading = false;
        setState(() {});
        Fluttertoast.showToast(msg: 'Account Already exists');
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
                  Text("Sign Up",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
                  const SizedBox(
                    height: 14,
                  ),
                  CommonTextFieldWithTitle(
                      'User Name', 'Enter User Name', userName, (val) {
                    if (val!.isEmpty) {
                      return 'This is required field';
                    }
                  }),
                  const SizedBox(
                    height: 14,
                  ),
                  CommonTextFieldWithTitle(
                      'Email', 'Enter Your Email', email, (val) {
                    if (val!.isEmpty) {
                      return 'This is required field';
                    }
                  }),

                  SizedBox(
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
                  SizedBox(
                    height: 14,
                  ),
                  CommonTextFieldWithTitle('Confirm Password', 'Enter Password', confirmPassword,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Do you have account?",
                        style: TextStyle(
                            color: Colors.grey, fontSize: 15, letterSpacing: 0.8),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.blue, fontSize: 16, letterSpacing: 0.8),
                        ),
                      )
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
            registration();

          }
        },
        child: const Text(
          'Signup',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),

      ),

    );

  }

}