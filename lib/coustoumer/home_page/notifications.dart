import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/notification_model.dart';
class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<NotificationModel> notification = [];
  bool isLoading = false;


  @override
  void initState() {
    getRequst();
    super.initState();
  }




  getRequst() {
    try {
      notification.clear();
      setState(() {});
      FirebaseFirestore.instance.collection("notificationreq").snapshots().listen((event) {
        notification.clear();
        setState(() {});
        for (int i = 0; i < event.docs.length; i++) {
          NotificationModel dataModel = NotificationModel.fromJson(event.docs[i].data());
          notification.add(dataModel);
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
        title: Text("Notification"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: notification.length,
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
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundImage:NetworkImage(

                                        notification[index].picture.toString(),
                                       // fit: BoxFit.cover,

                                      ) ,
                                    ),
                                    // SizedBox(
                                    //     height: 100,
                                    //     width: 100,
                                    //     child: ClipRRect(
                                    //       borderRadius: BorderRadius.circular(100),
                                    //       child: Image.network(
                                    //         notification[index].picture.toString(),
                                    //         fit: BoxFit.cover,
                                    //
                                    //       ),
                                    //     )),

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
                                                  "${notification[index].name}",
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w500, color: Colors.blue),
                                                ),
                                              ),

                                             Text(
                                                "${notification[index].request}",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500, color:
                                                notification[index].request.toString() =="Accepted"?

                                                Colors.green: Colors.red
                                                ),
                                              ),
                                            ],
                                          ),
                                          const   SizedBox(height: 5,),
                                          Text(
                                            "${notification[index].email}",
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
                    );
                  })




            ],
          ),
        ),
      ),
    );
  }
}
