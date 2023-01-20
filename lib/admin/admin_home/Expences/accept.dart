import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/notification_model.dart';
class Accepted extends StatefulWidget {
  const Accepted({Key? key}) : super(key: key);

  @override
  State<Accepted> createState() => _AcceptedState();
}

class _AcceptedState extends State<Accepted> {
  List<NotificationModel> accepted = [];
  bool isLoading = false;


  @override
  void initState() {
    getAcceptedOrders();
    super.initState();
  }




  getAcceptedOrders() {
    try {
      accepted.clear();
      setState(() {});
      FirebaseFirestore.instance.collection("notificationreq").snapshots().listen((event) {
        accepted.clear();
        setState(() {});
        for (int i = 0; i < event.docs.length; i++) {
          NotificationModel dataModel = NotificationModel.fromJson(event.docs[i].data());
          accepted.add(dataModel);
        }
        setState(() {});
      });
      setState(() {});
    } catch (e) {}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

            ListView.builder(
                shrinkWrap: true,
                itemCount: accepted.length,
                itemBuilder: (context, index){

                  return
                    accepted[index].request =="Accepted"?
                    Container(
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
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage:NetworkImage(

                                      accepted[index].picture.toString(),
                                      // fit: BoxFit.cover,

                                    ) ,
                                  ),

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
                                                "${accepted[index].name}",
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500, color: Colors.green),
                                              ),
                                            ),

                                            Text(
                                              accepted[index].price ==""? "200":
                                              "${accepted[index].price}",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500, color:

                                              Colors.green,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const   SizedBox(height: 5,),
                                        Text(
                                          "${accepted[index].email}",
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500, color: Colors.black),
                                        ),


                                        const SizedBox(
                                          height: 15,
                                        ),


                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const    SizedBox(height: 5,),
                            ],
                          ),
                        )),
                  ) : Container();
                })




          ],
        ),
      ),
    );
  }
}
