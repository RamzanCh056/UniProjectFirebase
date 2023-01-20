import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../models/book_car_model.dart';
import '../../models/book_room_model.dart';
import '../book_now/book_cars.dart';
class Rent_Car extends StatefulWidget {
  const Rent_Car({Key? key}) : super(key: key);

  @override
  State<Rent_Car> createState() => _Rent_CarState();
}

class _Rent_CarState extends State<Rent_Car> {
  List<AddCarModel> cars = [];

  @override
  void initState() {
    getRooms();
    super.initState();
  }
  getRooms() {
    try {
      cars.clear();
      setState(() {});
      FirebaseFirestore.instance.collection("cars").snapshots().listen((event) {
        cars.clear();
        setState(() {});
        for (int i = 0; i < event.docs.length; i++) {
          AddCarModel dataModel = AddCarModel.fromJson(event.docs[i].data());
          cars.add(dataModel);
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
  title: Text("Book Car"),
),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: cars.length,
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
                                          cars[index].picture.toString(),
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
                                            "${cars[index].name}",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500, color: Colors.blue),
                                          ),
                                          const   SizedBox(height: 15,),

                                          ReadMoreText(
                                            cars[index].description.toString(),
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
                                                cars[index].price.toString(),
                                                style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),


                                              GestureDetector(
                                                onTap: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> BookCar(
                                                      cars, index
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
