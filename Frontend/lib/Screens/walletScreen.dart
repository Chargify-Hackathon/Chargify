import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 245.0,
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
                  SizedBox(height: 25.0,),
                  Stack(
                    children: [
                      GestureDetector(
                          onTap:(){
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back)),
                      Center(
                        //child: Text("Wallet", style: TextStyle(fontSize:18.0, fontFamily: "Brand-Bold"),),
                      )
                    ],
                  ),
                  SizedBox(height: 16.0,),
                  Center(child: Text("My Balance", style: TextStyle(fontSize:21.0, fontFamily: "Brand-Bold")),),
                  SizedBox(height: 20.0,),
                  Center(child: Text("1500 ₹", style: TextStyle(fontSize:60.0, fontFamily: "Brand-Bold")),),

                ],
              ),
            ),
          ),
          Container(
            child: Column(
              children: [
                SizedBox(height: 70.0,),
                Container(
                  height: 40.0,
                  width: 220.0,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 20.0,),
                      Text("Add Money",style: TextStyle(color: Colors.white),),
                      SizedBox(width: 70.0,),
                      Icon(Icons.add, color: Colors.white,),
                    ],
                  ),
                ),
                SizedBox(height: 40.0,),
                Container(
                  height: 40.0,
                  width: 220.0,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 20.0,),
                      Text("Pay for Order",style: TextStyle(color: Colors.white),),
                      SizedBox(width: 60.0,),
                      Icon(Icons.attach_money_rounded, color: Colors.white,),
                    ],
                  ),
                ),
                SizedBox(height: 40.0,),
                Container(
                  height: 40.0,
                  width: 220.0,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 20.0,),
                      Text("Transactions",style: TextStyle(color: Colors.white),),
                      SizedBox(width: 60.0,),
                      Icon(Icons.history, color: Colors.white,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
