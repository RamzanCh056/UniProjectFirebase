import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uni_project/admin/suppliers/assign_task.dart';
import '../../models/supliers_models.dart';
class Suppliers extends StatefulWidget {
  const Suppliers({Key? key}) : super(key: key);

  @override
  State<Suppliers> createState() => _SuppliersState();
}

class _SuppliersState extends State<Suppliers> {
  List<SuplierModel> seller = [];
  bool isLoading = false;


  @override
  void initState() {
    getSuppliers();
    super.initState();
  }




  getSuppliers() {
    try {
      seller.clear();
      setState(() {});
      FirebaseFirestore.instance.collection("seller").snapshots().listen((event) {
        seller.clear();
        setState(() {});
        for (int i = 0; i < event.docs.length; i++) {
          SuplierModel dataModel = SuplierModel.fromJson(event.docs[i].data());
          seller.add(dataModel);
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
        title: Text("Suppliers"),
        centerTitle: true,
      ),
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

            ListView.builder(
                shrinkWrap: true,
                itemCount: seller.length,
                itemBuilder: (context, index){

                  return

                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>AssignTask(seller , index)));
                      },
                      child: Container(
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
                                                    "${seller[index].name}",
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w500, color: Colors.green),
                                                  ),
                                                ),
                                                Container(
                                                  height: 30,
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius: BorderRadius.circular(10)),
                                                  child: const Center(
                                                      child: Text(
                                                        "Assign",
                                                        style: TextStyle(color: Colors.white),
                                                      )),
                                                ),
                                              ],
                                            ),
                                            const   SizedBox(height: 5,),
                                            Text(
                                              "${seller[index].email}",
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
                      ),
                    ) ;
                })




          ],
        ),
      ),
    );
  }
}
