import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../common_textfield/common_textfield.dart';
import '../../../models/add_room_model.dart';
import '../../models/book_room_model.dart';
import '../../models/supliers_models.dart';

class AddSuplier extends StatefulWidget {
  AddSuplier( {Key? key}) : super(key: key);


  @override
  State<AddSuplier> createState() => _AddSuplierState();
}

class _AddSuplierState extends State<AddSuplier> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  AddSupplier() async {
    isLoading = true;
    setState(() {});
    int id = DateTime.now().millisecondsSinceEpoch;
    SuplierModel dataModel = SuplierModel(
      name: name.text,
      email: email.text,
      password: password.text,
      doc: id.toString(),
    );
    try {
      await FirebaseFirestore.instance.collection("seller").doc('$id').set(dataModel.toJson());
      isLoading = false;
      setState(() {});
      Fluttertoast.showToast(msg: 'Supplier added successfully');
    } catch (e) {
      isLoading = false;
      setState(() {});
      Fluttertoast.showToast(msg: 'Some error occurred');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Supplier"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [

                const SizedBox(
                  height: 20,
                ),
                CommonTextFieldWithTitle('Name', 'Enter Supplier Name', name, (val) {
                  if (val!.isEmpty) {
                    return 'This is required field';
                  }
                }),
                const SizedBox(
                  height: 15,
                ),
                CommonTextFieldWithTitle('Email', 'Enter Supplier Email', email, (val) {
                  if (val!.isEmpty) {
                    return 'This is required field';
                  }
                }),
                const SizedBox(
                  height: 15,
                ),
                CommonTextFieldWithTitle('password', 'Enter Supplier password', password, (val) {
                  if (val!.isEmpty) {
                    return 'This is required field';
                  }
                }),
                const SizedBox(
                  height: 15,
                ),
                isLoading
                    ? const CircularProgressIndicator()
                    : GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      AddSupplier();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue,
                      ),
                      height: 50,
                      width: double.infinity,
                      child: const Center(
                        child: Text(
                          "Add Supplier",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
