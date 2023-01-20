import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/supliers_models.dart';
class Employe extends StatefulWidget {
  const Employe({Key? key}) : super(key: key);

  @override
  State<Employe> createState() => _EmployeState();
}

class _EmployeState extends State<Employe> {
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
      FirebaseFirestore.instance.collection("Employe").snapshots().listen((event) {
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
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

            ListView.builder(
                shrinkWrap: true,
                itemCount: seller.length,
                itemBuilder: (context, index){

                  return

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
                                              Text(
                                                "${seller[index].salery}",
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500, color: Colors.teal),
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
                    ) ;
                })




          ],
        ),
      ),
    );
  }
}
