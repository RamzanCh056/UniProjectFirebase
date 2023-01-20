import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:uni_project/coustoumer/book_now/book_room.dart';

import '../../models/add_room_model.dart';

class Room_Booking extends StatefulWidget {
  const Room_Booking({Key? key}) : super(key: key);

  @override
  State<Room_Booking> createState() => _Room_BookingState();
}

class _Room_BookingState extends State<Room_Booking> {
  List<AddRoomModel> rooms = [];

  @override
  void initState() {
    getRooms();
    super.initState();
  }
  getRooms() {
    try {
      rooms.clear();
      setState(() {});
      FirebaseFirestore.instance.collection("Rooms").snapshots().listen((event) {
        rooms.clear();
        setState(() {});
        for (int i = 0; i < event.docs.length; i++) {
          AddRoomModel dataModel = AddRoomModel.fromJson(event.docs[i].data());
          rooms.add(dataModel);
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
        title: const Text("Room Booking"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
             ListView.builder(
               shrinkWrap: true,
               itemCount: rooms.length,
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
                               SizedBox(
                                   height: 125,
                                   width: 120,
                                   child: Image.network(
                                     rooms[index].picture.toString(),
                                     fit: BoxFit.cover,

                                   )),

                               const SizedBox(
                                 width: 10,
                               ),
                               Expanded(

                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                      Text(
                                 "${rooms[index].squreFit} Sq Fit",
                                       style: const TextStyle(
                                           fontSize: 20,
                                           fontWeight: FontWeight.w500, color: Colors.blue),
                                     ),
                                     const   SizedBox(height: 15,),

                                      ReadMoreText(
                                       rooms[index].description.toString(),
                                       trimLines: 2,
                                       colorClickableText: Colors.pink,
                                       trimMode: TrimMode.Line,
                                       trimCollapsedText: 'Show more',
                                       trimExpandedText: 'Show less',
                                       moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
                                       lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
                                     ),

                                     const SizedBox(
                                       height: 15,
                                     ),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Text(
                                     rooms[index].price.toString(),
                                           style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),


                                         GestureDetector(
                                           onTap: (){
                                             Navigator.push(context, MaterialPageRoute(builder: (context)=> BookRoom(
                                               rooms, index
                                             )));
                                           },
                                           child: Container(
                                             height: 30,
                                             width: 80,
                                             decoration: BoxDecoration(
                                                 color: Colors.blue,
                                                 borderRadius: BorderRadius.circular(10)),
                                             child: const Center(
                                                 child: Text(
                                                   "Book Now",
                                                   style: TextStyle(color: Colors.white),
                                                 )),
                                           ),
                                         ),
                                       ],
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
