import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

import '../../../common_textfield/common_textfield.dart';
import '../../../models/add_room_model.dart';

class UploadRoom extends StatefulWidget {
  const UploadRoom({Key? key}) : super(key: key);

  @override
  State<UploadRoom> createState() => _UploadRoomState();
}

class _UploadRoomState extends State<UploadRoom> {
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController squre = TextEditingController();

  UploadTask? task;
  bool isLoadFile = false;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  String? FireUrlForImage;
  File? imageFile;

  getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        uploadFile();
      });
    }
  }

  uploadLecture() async {
    isLoading = true;
    setState(() {});
    int id = DateTime.now().millisecondsSinceEpoch;
    AddRoomModel dataModel = AddRoomModel(
      picture: FireUrlForImage,
      price: price.text,
      squreFit: squre.text,
      description: description.text,
      doc: id.toString(),
    );
    try {
      await FirebaseFirestore.instance.collection("Rooms").doc('$id').set(dataModel.toJson());
      isLoading = false;
      setState(() {});
      Fluttertoast.showToast(msg: 'Room added successfully');
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
        title: Text("Upload Rooms"),
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
                GestureDetector(
                  onTap: () {
                    getFromCamera();
                  },
                  child: Container(
                      height: 150,
                      width: 300,
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                          ),
                          color: Colors.black12),
                      child: isLoadFile
                          ? Center(child: CircularProgressIndicator())
                          : imageFile != null
                              ? Image.file(
                                  imageFile!,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4e2w7sqLN7wNvah3rnc3RbSILIsG7Bfdwa7haC-mEzRmj8bqeseg0241dzcF1W4yGkoU&usqp=CAU",
                                  fit: BoxFit.cover,
                                )),
                ),
                SizedBox(
                  height: 20,
                ),
                CommonTextFieldWithTitle('price', 'Enter Price of room', price, (val) {
                  if (val!.isEmpty) {
                    return 'This is required field';
                  }
                }),
                const SizedBox(
                  height: 15,
                ),
                CommonTextFieldWithTitle('squre', 'Enter sequre Fit', squre, (val) {
                  if (val!.isEmpty) {
                    return 'This is required field';
                  }
                }),
                const SizedBox(
                  height: 15,
                ),
                CommonTextFieldWithTitle('Description', 'Enter Description', description, maxLine: 4, (val) {
                  if (val!.isEmpty) {
                    return 'This is required field';
                  }
                }),
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
                                "Add Room",
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

  Future uploadFile() async {
    setState(() {
      isLoadFile = true;
    });
    if (imageFile! == null) return;
    final fileName = Path.basename(imageFile!.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, imageFile!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
    FireUrlForImage = urlDownload;
    setState(() {
      isLoadFile = false;
    });
  }

  showDialogForSuccess() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          content: Container(
            height: 213,
            child: Column(
              children: [
                Icon(Icons.gpp_good,size: 40,),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "Room Added",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                const SizedBox(
                  height: 13,
                ),
                Container(
                  child: const Text(
                    "Room Added Click on close and add another room",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
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
               price.text =="";
               squre.text =="";
               description.text =="";
               FireUrlForImage =="";
               Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}

class FirebaseApi {
  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  static UploadTask? uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data);
    } on FirebaseException catch (e) {
      return null;
    }
  }
}
