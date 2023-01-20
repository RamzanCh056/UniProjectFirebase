import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/complete_order_model.dart';
import '../suplier_auth/loginpage.dart';
class Complete_Oder extends StatefulWidget {
  const Complete_Oder({Key? key}) : super(key: key);

  @override
  State<Complete_Oder> createState() => _Complete_OderState();
}

class _Complete_OderState extends State<Complete_Oder> {
  List<CompleteOrderModel> Complete = [];
  bool isLoading = false;

  @override
  void initState() {
    getOrders();
    super.initState();
  }

  getOrders() {
    try {
      Complete.clear();
      setState(() {});
      FirebaseFirestore.instance.collection("complete").snapshots().listen((event) {
        Complete.clear();
        setState(() {});
        for (int i = 0; i < event.docs.length; i++) {
          CompleteOrderModel dataModel = CompleteOrderModel.fromJson(event.docs[i].data());
          Complete.add(dataModel);
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
        title: Text("Completed Oder"),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: Complete.length,
                  itemBuilder: (context, index) {
                    return
                      Complete[index].email ==EmailCheck.toString()?

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
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    "${Complete[index].name}",
                                                    style: const TextStyle(
                                                        fontSize: 18, fontWeight: FontWeight.w500, color: Colors.blue),
                                                  ),
                                                ),
                                                Text(
                                                  "${Complete[index].email}",
                                                  style: const TextStyle(
                                                      fontSize: 14, fontWeight: FontWeight.w500, color: Colors.red),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              "${Complete[index].task}",
                                              style: const TextStyle(
                                                  fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                                            ),

                                            const SizedBox(
                                              height: 15,
                                            ),

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "${Complete[index].request}",
                                                  style: const TextStyle(
                                                      fontSize: 18, fontWeight: FontWeight.w500, color: Colors.green),
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: 10,)
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            )),
                      ) : Container();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
