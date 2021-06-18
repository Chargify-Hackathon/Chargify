import 'package:flutter/material.dart';
import 'mainscreen.dart';

class SearchScreen extends StatefulWidget {
  static const String idScreen = "search";
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 250.0,
            decoration: BoxDecoration(
              color:  Colors.white,
              boxShadow: [
                BoxShadow
                (
                color: Colors.black,
                blurRadius: 6.0,
                spreadRadius: 0.5,
                offset: Offset(0.7,0.7),
              ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 25.0, top: 20.0,right: 25.0, bottom: 20.0),
              child: Column(
                children: [
                  SizedBox(height: 30.0,),
                  Stack(
                    children: [
                      GestureDetector(
                          onTap:(){
                            Navigator.pop(context);
                      },
                          child: Icon(Icons.arrow_back)),
                      Center(
                        child: Text("Search For Charging Stations", style: TextStyle(fontSize:18.0, fontFamily: "Brand-Bold"),),
                      )
                    ],
                  ),
                  SizedBox(height: 16.0,),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined),
                      SizedBox(width: 18.0,),
                      Expanded(child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(3.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Choose Location",
                              fillColor: Colors.grey[400],
                              filled:true,
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.only(left: 11.0,top: 8.0, bottom: 8.0,),
                            ),
                          ),
                        ),
                      ))
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  Text("Saved Locations:"),
                  SizedBox(height: 15.0,),
                  Row(
                    children: [
                      SizedBox(width: 70.0,),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Column(
                          children: [
                            Icon(Icons.home_work_outlined),
                            SizedBox(height: 4.0,),
                            Text("Home"),
                          ],
                        ),
                      ),
                      SizedBox(width: 50.0,),
                      Column(
                        children: [
                          Icon(Icons.work_outline_rounded),
                          SizedBox(height: 4.0,),
                          Text("Work"),
                        ],
                      ),
                      SizedBox(width: 50.0,),
                      Column(
                        children: [
                          Icon(Icons.my_location_outlined),
                          SizedBox(height: 4.0,),
                          Text("Other"),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
