import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/assign_task.dart';
import '../../models/complete_order_model.dart';
import '../suplier_auth/loginpage.dart';

class Pendeing_Oder extends StatefulWidget {
  const Pendeing_Oder({Key? key}) : super(key: key);

  @override
  State<Pendeing_Oder> createState() => _Pendeing_OderState();
}

class _Pendeing_OderState extends State<Pendeing_Oder> {
  List<asignTaskModel> tasks = [];
  bool isLoading = false;

  @override
  void initState() {
    getOrders();
    super.initState();
  }

  getOrders() {
    try {
      tasks.clear();
      setState(() {});
      FirebaseFirestore.instance.collection("Tasks").snapshots().listen((event) {
        tasks.clear();
        setState(() {});
        for (int i = 0; i < event.docs.length; i++) {
          asignTaskModel dataModel = asignTaskModel.fromJson(event.docs[i].data());
          tasks.add(dataModel);
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
        title: const Text("Pending_oders"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return
                      tasks[index].email ==EmailCheck.toString()?

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
                                                  "${tasks[index].name}",
                                                  style: const TextStyle(
                                                      fontSize: 18, fontWeight: FontWeight.w500, color: Colors.blue),
                                                ),
                                              ),
                                              Text(
                                                "${tasks[index].email}",
                                                style: const TextStyle(
                                                    fontSize: 14, fontWeight: FontWeight.w500, color: Colors.red),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            "${tasks[index].task}",
                                            style: const TextStyle(
                                                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                                          ),

                                          const SizedBox(
                                            height: 15,
                                          ),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                onTap:() async{
                                                  isLoading = true;
                                                  setState(() {});
                                                  int id = DateTime.now().millisecondsSinceEpoch;
                                                  CompleteOrderModel dataModel = CompleteOrderModel(
                                                    name: tasks[index].name,
                                                    email: tasks[index].email,
                                                    request: "Delivered",
                                                    task: tasks[index].task,
                                                    doc: id.toString(),
                                                  );
                                                  try {
                                                    await FirebaseFirestore.instance.collection("complete").doc('$id').set(dataModel.toJson());
                                                    isLoading = false;
                                                    setState(() {});
                                                    Fluttertoast.showToast(msg: 'successfully Delivered');
                                                    FirebaseFirestore.instance.collection('Tasks').doc(tasks[index].doc.toString()).delete().then(
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
                                                      color: Colors.teal,
                                                      borderRadius: BorderRadius.circular(10)),
                                                  child: const Center(
                                                      child: Text(
                                                        "Deliver",
                                                        style: TextStyle(color: Colors.white),
                                                      )),
                                                ),
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
