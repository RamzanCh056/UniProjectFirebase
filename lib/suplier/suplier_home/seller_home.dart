import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_project/navigator_page/user_owner_seller.dart';
import 'package:uni_project/suplier/suplier_home/complete_oder.dart';
import 'package:uni_project/suplier/suplier_home/pending_oder.dart';

import '../suplier_auth/loginpage.dart';
class Seller_Home extends StatefulWidget {
  const Seller_Home({Key? key}) : super(key: key);

  @override
  State<Seller_Home> createState() => _Seller_HomeState();
}

class _Seller_HomeState extends State<Seller_Home> {

  SharedPreferences? preferences;
  final stroage = FlutterSecureStorage();

  void tapped(int index){
    if(index == 0){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const Pendeing_Oder()));
    }
    if(index == 1){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const Complete_Oder()));
    }
  }
  List <String> images=[
    'images/pending.png',
    'images/completed.png',
  ];
  List <Text> Text1=[
    Text( 'Pending',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
    Text(  'Complete oder',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),



  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // drawer: drawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Supplier Home"),
        centerTitle: true,
      ),
      body: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              GridView.builder(
                controller: new ScrollController(keepScrollOffset: false),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                    crossAxisCount: 2,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1),itemCount:2,itemBuilder: (context,index)=>
                  GestureDetector(
                    onTap: () => tapped(index),
                    child: Container(
                      height: 300,

                      margin: new EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                          color: Colors.black12
                      ),
                      child: Column(
                        children: [
                          Image.asset(images[index],height: 70,width: 50,),
                          SizedBox(
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
          )
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
                '${EmailCheck.toString()}',
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
