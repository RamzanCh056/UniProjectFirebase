import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:uni_project/models/add_food_model.dart';

import '../book_now/book_food.dart';
class Oder_Food extends StatefulWidget {
  const Oder_Food({Key? key}) : super(key: key);

  @override
  State<Oder_Food> createState() => _Oder_FoodState();
}

class _Oder_FoodState extends State<Oder_Food> {
  List<AddFoodModel> food = [];

  @override
  void initState() {
    getRooms();
    super.initState();
  }
  getRooms() {
    try {
      food.clear();
      setState(() {});
      FirebaseFirestore.instance.collection("food").snapshots().listen((event) {
        food.clear();
        setState(() {});
        for (int i = 0; i < event.docs.length; i++) {
          AddFoodModel dataModel = AddFoodModel.fromJson(event.docs[i].data());
          food.add(dataModel);
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
        title: Text("Oder Food"),
      ),
body: Padding(
  padding: const EdgeInsets.all(20),
  child: SingleChildScrollView(
    child: Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: food.length,
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
                                    food[index].picture.toString(),
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
                                      "${food[index].name}",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500, color: Colors.blue),
                                    ),
                                    const   SizedBox(height: 15,),

                                    ReadMoreText(
                                      food[index].description.toString(),
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
                                          food[index].price.toString(),
                                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),


                                        GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=> BookFood(
                                                food, index
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
