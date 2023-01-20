import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../common_textfield/common_textfield.dart';
import '../../../models/add_room_model.dart';
import '../../models/add_food_model.dart';
import '../../models/book_car_model.dart';
import '../../models/book_room_model.dart';

class BookFood extends StatefulWidget {
  BookFood(this.food, this.curentIndex, {Key? key}) : super(key: key);
  List<AddFoodModel> food;

  int curentIndex;

  @override
  State<BookFood> createState() => _BookFoodState();
}

class _BookFoodState extends State<BookFood> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pay = TextEditingController();
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  uploadLecture() async {
    isLoading = true;
    setState(() {});
    int id = DateTime.now().millisecondsSinceEpoch;
    BookRoomModel dataModel = BookRoomModel(
      picture: widget.food[widget.curentIndex].picture.toString(),
      name: name.text,
      email: email.text,
      paidPrice: widget.food[widget.curentIndex].price.toString(),
      doc: id.toString(),
    );
    try {
      await FirebaseFirestore.instance.collection("orders").doc('$id').set(dataModel.toJson());
      isLoading = false;
      setState(() {});
      Fluttertoast.showToast(msg: 'car added successfully');
      showDialogForSuccess();
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
        title: Text("Book Rooms"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 150,
                  width: 300,
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                      ),
                      color: Colors.black12),
                  child: Image.network(
                    widget.food[widget.curentIndex].picture.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CommonTextFieldWithTitle('Name', 'Enter Your Name', name, (val) {
                  if (val!.isEmpty) {
                    return 'This is required field';
                  }
                }),
                const SizedBox(
                  height: 15,
                ),
                CommonTextFieldWithTitle('Email', 'Enter Your Email', email, (val) {
                  if (val!.isEmpty) {
                    return 'This is required field';
                  }
                }),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: (){
                    Fluttertoast.showToast(msg: "You Already Paid click Book For booking");
                  },
                  child: CommonTextFieldWithTitle('You Paid for this', '${widget.food[widget.curentIndex].price}', pay,
                      enabled: false,
                          (val) {

                      }),
                ),
                const SizedBox(
                  height: 15,
                ),
                isLoading
                    ? CircularProgressIndicator()
                    : GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      uploadLecture();
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
                          "order food",
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

  showDialogForSuccess() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          content: Container(
            height: 213,
            child: Column(
              children: const [
                Icon(
                  Icons.gpp_good,
                  size: 40,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Book Successfully",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                SizedBox(
                  height: 13,
                ),
                Text(
                  "food order successful after review admin will accept",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                "Close",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
