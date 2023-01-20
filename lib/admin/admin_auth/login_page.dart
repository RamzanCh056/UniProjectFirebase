import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_project/admin/admin_home/admin_home.dart';
import 'package:uni_project/common_textfield/common_textfield.dart';


class Login_Page extends StatefulWidget {
  const Login_Page({Key? key}) : super(key: key);

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool showPass = true;
  bool isLoading = false;

  userLogin() async {
    isLoading = true;
    setState(() {});
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool userNameExists;
    bool passwordExists;
    try {
      var authResult = await FirebaseFirestore.instance
          .collection("owner")
          .where('email', isEqualTo: email.text)
          .get();
      userNameExists = authResult.docs.isNotEmpty;
      if (userNameExists) {
        var authResult = await FirebaseFirestore.instance
            .collection("owner")
            .where('password', isEqualTo: password.text.toLowerCase())
            .get();
        passwordExists = authResult.docs.isNotEmpty;
        if (passwordExists) {
          await preferences.setBool('isLoggedIn', true);
          await preferences.setString('id', email.text.trim());
          await preferences.setString('password', password.text.trim());
          isLoading = false;
          setState(() {});
          Fluttertoast.showToast(msg: 'Successfully logged in');
          //NavigateToHome
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Owner_Home()),
          );
        } else {
          isLoading = false;
          setState(() {});
          Fluttertoast.showToast(msg: 'Incorrect username or password');
        }
      } else {
        isLoading = false;
        setState(() {});
        Fluttertoast.showToast(msg: 'Incorrect username or password');
      }
    } catch (e) {
      isLoading = false;
      setState(() {});
      Fluttertoast.showToast(msg: 'Some error occurred');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 70,
                ),
                Text("SINGIN Admin",style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold,color: Colors.blue),),
                SizedBox(
                  height: 25,
                ),
                CommonTextFieldWithTitle(
                    'email', 'email', email, (val) {
                  if (val!.isEmpty) {
                    return 'This is required field';
                  }
                }),
                SizedBox(
                  height: 5,
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
                  height: 30,
                ),

                isLoading? const Center(child: CircularProgressIndicator()):
                buttonWidget(),
                const  SizedBox(
                  height: 10,
                ),

              ]
          ),
        ),
      ),
    );
  }
  Widget buttonWidget() {
    return ButtonTheme(
      height: 47,
      minWidth: MediaQuery.of(context).size.width,
      child: MaterialButton(
        color: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            userLogin();

          }
        },
        child: const Text(
          'LogIn',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),

      ),

    );

  }
}
