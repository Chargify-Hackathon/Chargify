import 'package:flutter/material.dart';

class BookChargers extends StatefulWidget {
  const BookChargers({Key? key}) : super(key: key);

  @override
  _BookChargersState createState() => _BookChargersState();
}

class _BookChargersState extends State<BookChargers> {
  String _setTime="";
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  TextEditingController _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.only(left: 25.0, top: 20.0,right: 25.0, bottom: 20.0),
              child: Column(
                children: [
                  SizedBox(height: 35.0,),
                  Stack(
                    children: [
                      GestureDetector(
                          onTap:(){
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back)),
                      Center(
                        child: Text("Book a Charging Station", style: TextStyle(fontSize:18.0, fontFamily: "Brand-Bold"),),
                      )
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  Divider(
                    height: 20,
                    thickness: 5,
                    indent: 20,
                    endIndent: 20,
                  ),
                  SizedBox(height: 30.0,),
                  Row(
                    children: [
                      Text("Start Time: "),
                      SizedBox(width: 10.0,),
                      Expanded(child: Container(
                        child: Padding(
                          padding: EdgeInsets.all(3.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "",
                              fillColor: Colors.grey[400],
                              filled:true,
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.only(left: 11.0,top: 8.0, bottom: 8.0,),
                            ),
                          ),
                        ),
                      )),
                      SizedBox(width: 30.0,),
                      Text(":",style: TextStyle(fontSize: 30),),
                      SizedBox(width: 10.0,),
                      Expanded(child: Container(
                        child: Padding(
                          padding: EdgeInsets.all(3.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "",
                              fillColor: Colors.grey[400],
                              filled:true,
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.only(left: 11.0,top: 8.0, bottom: 8.0,),
                            ),
                          ),
                        ),
                      )),
                      SizedBox(width: 30.0,),
                    ],
                  ),
                  SizedBox(height: 20.0,),
                  Row(
                    children: [
                      Text("Number of Hours :"),
                      Expanded(child: Container(
                        child: Padding(
                          padding: EdgeInsets.all(3.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "",
                              fillColor: Colors.grey[400],
                              filled:true,
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.only(left: 11.0,top: 8.0, bottom: 8.0,),
                            ),
                          ),
                        ),
                      )),
                      SizedBox(width: 27.0,),
                    ],
                  ),
                  SizedBox(height: 25.0,),
                  Row(
                    children: [
                      Text("Amount to Pay :  300 Rs"),
                      SizedBox(width: 27.0,),
                    ],
                  ),
                  SizedBox(height: 20.0,),
                  ElevatedButton(onPressed:(){}, child: Text("Pay Now"))

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
