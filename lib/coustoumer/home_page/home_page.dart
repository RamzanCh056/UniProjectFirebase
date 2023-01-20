import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_project/coustoumer/coustoumer_auth/login_page.dart';
import 'package:uni_project/coustoumer/home_page/oder_food.dart';
import 'package:uni_project/coustoumer/home_page/rent_car.dart';
import 'package:uni_project/coustoumer/home_page/room_booking.dart';
import 'package:uni_project/navigator_page/user_owner_seller.dart';

import 'notifications.dart';


class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  SharedPreferences? preferences;
  final stroage = FlutterSecureStorage();

  void tapped(int index){
    if(index == 0){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const Room_Booking()));
    }

    if(index == 1){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const Rent_Car()));
    }
    if(index == 2){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const Oder_Food()));
    }
    if(index == 3){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const Notifications()));
    }

  }
  List <String> images=[
    'images/room.png',
    'images/car.png',
    'images/food.png',
    'images/car.png',

  ];
  List <Text> Text1=[
    Text( 'Room Booking',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
    Text(  'Rent Car',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
    Text(  'Oder Food',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
    Text(  'Notification',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),


  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

     // drawer: drawer(),
      appBar: AppBar(

        automaticallyImplyLeading: false,
        title: const Text("Home "),
        centerTitle: true,
        backgroundColor: const Color(0xff00008b),

      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GridView.builder(
              controller: new ScrollController(keepScrollOffset: false),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4),itemCount:4,itemBuilder: (context,index)=>
                GestureDetector(
                  onTap: () => tapped(index),
                  child: Container(
                    margin: new EdgeInsets.all(2.0),
                    decoration: const BoxDecoration(
                        color: Colors.black12
                    ),
                    child: Column(
                      children: [
                        Image.asset(images[index],height: 100,width: 60,),
                        const SizedBox(
                          height: 10,
                        ),
                        Text1[index],
                      ],
                    ),
                  ),
                ),
            ),
            Expanded(child: SizedBox()),
            buttonLogoutWidget(),

          ],
        ),
      ),

    );
  }



  Widget buttonLogoutWidget() {
    return ButtonTheme(
      height: 47,
      minWidth: MediaQuery.of(context).size.width,
      child: MaterialButton(
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        onPressed: () async {
          await stroage.delete(key: "uid");
          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (context) => Page_Navigator()), (route) => false);
        },
        child: const Text(
          'LogOut',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
    );
  }

  Drawer drawer() {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              accountName: Text(
                preferences?.getString('user') ?? '',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              accountEmail: const Text(
                '',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: Column(
                children: [],
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: buttonLogoutWidget(),
          ),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
