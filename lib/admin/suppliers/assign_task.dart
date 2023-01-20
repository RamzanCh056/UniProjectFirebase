import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uni_project/models/assign_task.dart';
import '../../common_textfield/common_textfield.dart';
import '../../models/supliers_models.dart';
class AssignTask extends StatefulWidget {
   AssignTask(this.seller, this.curentIndex,{Key? key}) : super(key: key);
  List<SuplierModel> seller ;
  int curentIndex = 0;

  @override
  State<AssignTask> createState() => _AssignTaskState();
}

class _AssignTaskState extends State<AssignTask> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController task = TextEditingController();
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  AddTask() async {
    isLoading = true;
    setState(() {});
    int id = DateTime.now().millisecondsSinceEpoch;
    asignTaskModel dataModel = asignTaskModel(
      name: widget.seller[widget.curentIndex].name,
      email: widget.seller[widget.curentIndex].email,
      task: task.text,
      doc: id.toString(),
    );
    try {
      await FirebaseFirestore.instance.collection("Tasks").doc('$id').set(dataModel.toJson());
      isLoading = false;
      setState(() {});
      Fluttertoast.showToast(msg: 'Task added successfully');
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
        title: const Text("Assign Task"),
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
                CommonTextFieldWithTitle('Name', '${widget.seller[widget.curentIndex].name}', name,
                        enabled: false,
                        (val) {

                }
                ),
                const SizedBox(
                  height: 15,
                ),
                CommonTextFieldWithTitle('Email', '${widget.seller[widget.curentIndex].email}', email,
                    enabled: false,(val) {

                }),
                const SizedBox(
                  height: 15,
                ),
                CommonTextFieldWithTitle('task', 'Enter task assign', task,
                        maxLine: 5,
                        (val) {
                  if (val!.isEmpty) {
                    return 'This is required field';
                  }
                }),
                const SizedBox(
                  height: 15,
                ),

                const SizedBox(
                  height: 15,
                ),
                isLoading
                    ? const CircularProgressIndicator()
                    : GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      AddTask();
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
                          "Assign Task",
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
