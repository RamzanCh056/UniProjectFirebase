import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_project/admin/admin_home/Expences/accept.dart';
import 'package:uni_project/admin/admin_home/Expences/reject.dart';


class HomeExpences extends StatefulWidget {
  const HomeExpences({Key? key}) : super(key: key);

  @override
  State<HomeExpences> createState() => _HomeExpencesState();
}

class _HomeExpencesState extends State<HomeExpences> {
  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      preferences = value;
      setState(() {});
    });
    super.initState();

  }

  TextEditingController search = TextEditingController();
  int tabIndex = 1;
  SharedPreferences? preferences;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          "Expenses",
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          tabIndex = 1;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 85,
                        decoration: BoxDecoration(
                          borderRadius: (BorderRadius.circular(20)),
                          color: tabIndex == 1 ? Colors.purple : kTabOffColor,
                        ),
                        child: Center(
                          child: Text(
                            "Accepted",
                            style: TextStyle(color: tabIndex == 1 ? Colors.white : Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          tabIndex = 2;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 85,
                        decoration: BoxDecoration(
                          borderRadius: (BorderRadius.circular(20)),
                          color: tabIndex == 2 ? Colors.purple : kTabOffColor,
                        ),
                        child: Center(
                          child: Text(
                            "Rejected",
                            style: TextStyle(color: tabIndex == 2 ? Colors.white : Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 7,
                  ),

                ],
              ),
              tabIndex == 1 ?  Expanded(child: Accepted()) : Container(),
              tabIndex == 2 ?  Expanded(child: Rejected()) : Container(),

            ],
          ),
        ),
      ),
    );
  }
   Color kGreyColor = Colors.grey;
   Color kTabOffColor = Color(0xff97999B);
   Color kSkipColor = Color(0xff989898);Color kFillColor = Color(0xFFF8F8F8);

}