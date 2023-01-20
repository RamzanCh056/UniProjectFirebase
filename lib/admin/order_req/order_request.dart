import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:readmore/readmore.dart';
import 'package:uni_project/coustoumer/book_now/book_room.dart';

import '../../models/add_room_model.dart';
import '../../models/book_room_model.dart';
import '../../models/notification_model.dart';

class OrderRequest extends StatefulWidget {
  const OrderRequest({Key? key}) : super(key: key);

  @override
  State<OrderRequest> createState() => _OrderRequestState();
}

class _OrderRequestState extends State<OrderRequest> {
  List<BookRoomModel> orders = [];
  bool isLoading = false;


  @override
  void initState() {
    getOrders();
    super.initState();
  }




  getOrders() {
    try {
      orders.clear();
      setState(() {});
      FirebaseFirestore.instance.collection("orders").snapshots().listen((event) {
        orders.clear();
        setState(() {});
        for (int i = 0; i < event.docs.length; i++) {
          BookRoomModel dataModel = BookRoomModel.fromJson(event.docs[i].data());
          orders.add(dataModel);
        }
        setState(() {});
      });
      setState(() {});
    } catch (e) {}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: orders.length,
                  itemBuilder: (context, index){
                    return  Container(
                      width: double.infinity,
                      child: Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        height: 125,
                                        width: 120,
                                        child: Image.network(
                                          orders[index].picture.toString(),
                                          fit: BoxFit.cover,

                                        )),

                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(

                                            children: [
                                              Expanded(

                                                child: Text(
                                                  "${orders[index].name}",
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w500, color: Colors.blue),
                                                ),
                                              ),

                                              Text(
                                                "${orders[index].paidPrice}",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500, color: Colors.red),
                                              ),
                                            ],
                                          ),
                                          const   SizedBox(height: 15,),
                                          Text(
                                            "${orders[index].email}",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500, color: Colors.black),
                                          ),



                                          const SizedBox(
                                            height: 15,
                                          ),

                                          Row(children: [
                                            Expanded(
                                              
                                              child:
                                          GestureDetector(
                                                onTap:() async{
                                                  isLoading = true;
                                                  setState(() {});
                                                  int id = DateTime.now().millisecondsSinceEpoch;
                                                  NotificationModel dataModel = NotificationModel(
                                                      picture: orders[index].picture,
                                                      name: orders[index].name,
                                                      email: orders[index].email,
                                                      request: "Accepted",
                                                      price:orders[index].paidPrice,
                                                      doc: id.toString(),
                                                  );
                                                  try {
                                                  await FirebaseFirestore.instance.collection("notificationreq").doc('$id').set(dataModel.toJson());
                                                  isLoading = false;
                                                  setState(() {});
                                                  Fluttertoast.showToast(msg: 'successfully Accepted');
                                                  FirebaseFirestore.instance.collection('orders').doc(orders[index].doc.toString()).delete().then(
                                                        (doc) => print("Document deleted"),
                                                    onError: (e) => print("Error updating document $e"),);
                                                  } catch (e) {
                                                  isLoading = false;
                                                  setState(() {});
                                                  //  Fluttertoast.showToast(msg: 'Some error occurred');
                                                  }
                                                },
                                                child: Container(
                                                  height: 30,
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius: BorderRadius.circular(10)),
                                                  child: const Center(
                                                      child: Text(
                                                        "Accept",
                                                        style: TextStyle(color: Colors.white),
                                                      )),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            Expanded(
                                              child:
                                              GestureDetector(
                                                onTap:() async{
                                                  isLoading = true;
                                                  setState(() {});
                                                  int id = DateTime.now().millisecondsSinceEpoch;
                                                  NotificationModel dataModel = NotificationModel(
                                                    picture: orders[index].picture,
                                                    name: orders[index].name,
                                                    email: orders[index].email,
                                                    price:orders[index].paidPrice,
                                                    request: "Rejected",
                                                    doc: id.toString(),
                                                  );
                                                  try {
                                                    await FirebaseFirestore.instance.collection("notificationreq").doc('$id').set(dataModel.toJson());
                                                    isLoading = false;
                                                    setState(() {});
                                                    Fluttertoast.showToast(msg: 'Request Rejected');
                                                    FirebaseFirestore.instance.collection('orders').doc(orders[index].doc.toString()).delete().then(
                                                          (doc) => print("Document deleted"),
                                                      onError: (e) => print("Error updating document $e"),);
                                                  } catch (e) {
                                                    isLoading = false;
                                                    setState(() {});
                                                    //  Fluttertoast.showToast(msg: 'Some error occurred');
                                                  }
                                                },
                                                child: Container(
                                                  height: 30,
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius: BorderRadius.circular(10)),
                                                  child: const Center(
                                                      child: Text(
                                                        "reject",
                                                        style: TextStyle(color: Colors.white),
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ],)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const    SizedBox(height: 5,),
                              ],
                            ),
                          )),
                    );
                  })




            ],
          ),
        ),
      ),
    );
  }
}
