import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../coustoumer/home_page/home_page.dart';
import '../navigator_page/user_owner_seller.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState(){
    Timer(Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FutureBuilder(
          future: checkLoginStatus(),
          builder: (BuildContext context, AsyncSnapshot<bool>
          snapshot){
            if(snapshot.data==false){
              return Page_Navigator();
            }
            if(snapshot.connectionState==ConnectionState.waiting){
              return Container(
                  color: Colors.white,
                  child: Center(child: CircularProgressIndicator()));
            }
            return Home_Page();
          })));

      // Navigator.push(context, MaterialPageRoute(builder:(context)=>Page1()));
    });
    super.initState();
  }


  final stroage =FlutterSecureStorage();

  Future<bool> checkLoginStatus() async{
    String? value = await stroage.read(key: "uid");
    if(value== null){
      return false;
    }
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: FittedBox(
                    fit: BoxFit.contain,
                    child: Image.asset("images/logo.jpeg"),
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Version: 1.0.0',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }



  String intTo8bitString(int number, {bool prefix = false}) => prefix
      ? '0x${number.toRadixString(2).padLeft(19, '0')}'
      : '${number.toRadixString(2).padLeft(19, '0')}';
}

