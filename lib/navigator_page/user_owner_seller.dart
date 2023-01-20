import 'package:flutter/material.dart';
import 'package:uni_project/admin/admin_auth/login_page.dart';
import 'package:uni_project/coustoumer/coustoumer_auth/login_page.dart';
import 'package:uni_project/suplier/suplier_auth/loginpage.dart';


class Page_Navigator extends StatefulWidget {
  const Page_Navigator({Key? key}) : super(key: key);

  @override
  State<Page_Navigator> createState() => _Page_NavigatorState();
}

class _Page_NavigatorState extends State<Page_Navigator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset("images/logo.jpeg"),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
              },
              child: Container(
                height: 40,
                width: 300,
                decoration: BoxDecoration(
                  color: Color(0xff00008b),
                ),
                child: Center(
                    child: Text(
                  "User",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Login_Page()));
              },
              child: Container(
                height: 40,
                width: 300,
                decoration: BoxDecoration(
                  color: Color(0xff00008b),
                ),
                child: Center(
                    child: Text(
                      "Admin",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Login_Page1()));
              },
              child: Container(
                height: 40,
                width: 300,
                decoration: BoxDecoration(
                  color: Color(0xff00008b),
                ),
                child: Center(
                    child: Text(
                      "suplier",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
