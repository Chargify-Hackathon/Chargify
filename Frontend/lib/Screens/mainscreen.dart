import 'dart:convert';

import 'package:chargify/Screens/searchScreen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'bookCharger.dart';
import 'walletScreen.dart';
import 'addNewCharger.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  static const String idScreen = "main";
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}
class User {
  final String id, location, status;
  User(this.id, this.location, this.status);
}
Future getUserData() async{
  var response= await http.get(Uri.https("https://chargify.eu-gb.cf.appdomain.cloud","api/charger/get"),headers: {
    "Content-type": "application/json", "Accept": "application/json", "token":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwY2M1NTYyODI3MmUzMGMyODQzNDkxMCIsInVzZXJuYW1lIjoiYWlzaHdhcnlhazk4IiwiZW1haWwiOiJhaXNod2FyeWFrMjk5OEBnbWFpbC5jb20iLCJpYXQiOjE2MjQwMTkyMzQsImV4cCI6MTY1NTU3NjE2MH0.e8aEywsv9vBnYfqvv7MFPSXVu2RMPaDQkSg5BBpJ8gE"
  });
  print(response.body);
  var jsonData = jsonDecode(response.body);
  List<User> users = [];

  for( var u in jsonData){
    User user = User(u['id'],u['location'],u['status'] );
    users.add(user);

  }
  print("api call");
  print(users.length);
  return users;
}

class _MainScreenState extends State<MainScreen> {
  //Marker details
  String ownerName = "";
  String rate = "";
  String chargerStatusWhileBooking = "";

  static const _initialCameraPosition = CameraPosition(
   target: LatLng(20.7711247,73.7287618),
  zoom: 5,
   );
  late GoogleMapController newGoogleMapController;

  GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();

  late Position currentPosition;
  var geoLocator = Geolocator();

  Set<Marker> _markers= {};
  static List<Map> list = [
    {"owner": "one", "id": "1", "lat": 37.4224085, "lon": -122.0854898 ,"rate":'10', "status": "available"},
    {"owner": "two", "id": "2", "lat": 37.4244085, "lon": -122.0857898, "rate":'10',"status": "busy"},
    {"owner": "three", "id": "3", "lat": 37.4223915, "lon": -122.0832153, "rate":'10',"status": "unavailable"},
    {"owner": "John ", "id": "4", "lat": 19.0463316, "lon": 73.0748172,"rate":'10', "status": "busy"},
    {"owner": "Doe", "id": "5", "lat": 19.0469807, "lon": 73.0622859,"rate":'10', "status": "unavailable"},
    {"owner": "Alex", "id": "6", "lat": 19.0456263, "lon": 73.076279,"rate":'10', "status": "available"},
    {"owner": "William", "id": "7", "lat": 19.0465953, "lon": 73.0673499,"rate":'10', "status": "available"},
  ];
  late BitmapDescriptor mapMarker, mapMarkerAvailable, mapMarkerBusy, mapMarkerUnavailable;


  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      print("hello");
      setCustomMarker();

    }

  void setCustomMarker() async{
    mapMarkerAvailable = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/2.png');
    mapMarkerBusy = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/1.png');
    mapMarkerUnavailable = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/3.png');
  }
  void putMarkers(){
    setState(() {
        print("works");
        for( var v in list){
          if(v['status']== "available"){
          mapMarker = mapMarkerAvailable;
          }
          if(v['status']== "unavailable"){
            mapMarker = mapMarkerUnavailable;
          }
          if(v['status']== "busy"){
            mapMarker = mapMarkerBusy;
          }
          _markers.add(Marker(markerId: MarkerId(v['id']),
            position: LatLng((v['lat']),(v['lon'])),
            icon: mapMarker,
            infoWindow: InfoWindow(
                title: v['owner'],
                snippet: "Click for more info..",
                onTap: (){
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
                  showDialogBox(context,v['owner'],v['rate'] ,v['status']);
                }
            ),
          ));
        }

    });
  }

  void locatePosition() async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latlngPosition = LatLng(position.latitude, position.longitude);
    LatLng Prateeksghar = LatLng(19.0463316,73.075933);

    CameraPosition cameraPosition = new CameraPosition(target: Prateeksghar, zoom: 14);
    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        key: scaffoldkey,
        drawer: Container(
          color: Colors.white,
          width: 255.0,
          child: Drawer(
            child: new ListView(
              padding: const EdgeInsets.all(0.0),
              children: <Widget>[
                new UserAccountsDrawerHeader(
                    accountName: new Text("Prateek "),
                    accountEmail: new Text("abcd@gmail.com"),
                    currentAccountPicture: new CircleAvatar(
                      child: Icon(Icons.account_circle_outlined),
                      backgroundColor:Colors.red,
                    )
                ),
                new ListTile(
                  title:new Text('Home'),
                  trailing: new Icon(Icons.home_rounded),
                ),
                new ListTile(
                  title:new Text('Wallet'),
                  trailing: new Icon(Icons.account_balance_wallet_rounded),
                ),
                new ListTile(
                  title:new Text('Profile'),
                  trailing: new Icon(Icons.supervised_user_circle_outlined),
                  onTap: ()=>Navigator.of(context).pop(),
                ),
                new ListTile(
                  title:new Text('Logout'),
                  trailing: new Icon(Icons.logout_rounded),
                  onTap: ()=>Navigator.of(context).pop(),
                )
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            GoogleMap(
              //mapType: MapType.normal,
              initialCameraPosition: _initialCameraPosition,
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              onMapCreated: (GoogleMapController controller){
                newGoogleMapController = controller;
                controller.setMapStyle(Utils.mapStyle1);
                locatePosition();
                putMarkers();
              },
              markers: _markers,
            ),

            Positioned(
                left: 8.0,
                right: 8.0,
                top: 45.0,
                child:Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 16.0,
                        spreadRadius: 0.5,
                        offset: Offset(0.7,0.7),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 10.0,),
                      GestureDetector(
                          onTap: ()
                          {
                            scaffoldkey.currentState!.openDrawer();
                          },
                          child: Icon(Icons.menu)),
                      SizedBox(width: 20.0,),
                      GestureDetector(
                        onTap: (){
                          //getUserData();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
                        },
                        child: Container(
                          child: Text("Search For A Location"),
                        ),
                      ),
                      SizedBox(width: 160.0,),
                      Icon(Icons.search)
                    ],
                  ),

                )
            ),

            Positioned(
              left: 8.0,
              right: 8.0,
              bottom:0.0,
              child: Visibility(
                visible: true,
                child: Container(
                  height: 90.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 16.0,
                        spreadRadius: 0.5,
                        offset: Offset(0.7,0.7),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5.0),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: (){locatePosition();},
                              child: Column(
                                children: [
                                  Icon(Icons.my_location_rounded, color: Colors.black54,),
                                  SizedBox(height: 2.0,),
                                  Text("Current Location"),
                                ],
                              ),
                            ),
                            SizedBox(width: 40.0,),
                            GestureDetector(
                              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>WalletScreen()));},
                              child: Column(
                                children: [
                                  Icon(Icons.account_balance_rounded, color: Colors.black54,),
                                  SizedBox(height: 2.0,),
                                  Text("Wallet"),
                                ],
                              ),
                            ),
                            SizedBox(width: 55.0,),
                            GestureDetector(
                              onTap: (){
                                showDialogCharger(context);
                              },
                              child: Column(
                                children: [
                                  Icon(Icons.charging_station_outlined, color: Colors.black54,),
                                  SizedBox(height: 2.0,),
                                  Text("My Charger"),
                                ],
                              ),
                            ),

                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}
showDialogCharger(context){
  return showDialog(
      context: context,
      builder: (context){
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
                padding: EdgeInsets.all(15),
                height: 255,
                width: MediaQuery.of(context).size.width * 0.7,
                child:Column(
                  children: [
                    Center(child: Text("My Charger",style: TextStyle(fontSize: 18.0),)),
                    Divider(height: 20,
                      thickness: 5,
                      indent: 20,
                      endIndent: 20,
                    ),
                    SizedBox(height: 5.0,),
                    Row(
                      children: [
                        SizedBox(width: 40.0,),
                        Text("Current Status - Available"),
                        SizedBox(width:5.0),
                        ]),
                    SizedBox(height: 30.0,),
                    Row(
                      children: [
                        SizedBox(width: 15.0,),
                        Column(
                          children: [Icon(Icons.my_library_books_outlined),Text("Bookings"),],
                        ),
                        SizedBox(width: 65.0,),
                        Column(
                          children: [Icon(Icons.toggle_on_outlined),Text("Change Status"),],
                        )
                      ],
                    ),
                    SizedBox(height: 20.0,),
                    GestureDetector(
                      onTap: (){
                        {Navigator.push(context, MaterialPageRoute(builder: (context)=>AddCharger()));}
                      },
                      child: Row(children: [
                        SizedBox(width:55.0),
                        Text("Add New Charger"),
                        Icon(Icons.add),],),
                    )
                  ],
                )
            ),
          ),
        );
      }
  );
}

showDialogBox(context,String owner, String rate, String status){
  return showDialog(
    context: context,
    builder:(context){
      return Center(
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
              padding: EdgeInsets.all(15),
              height: 255,
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 4.0,),
                Center(child: Text("Charger Details",style: TextStyle(fontSize: 21.0),)),
                Divider(height: 20,
                  thickness: 5,
                  indent: 20,
                  endIndent: 20,
                ),
                SizedBox(height: 5.0,),
                Row(
                  children: [
                    SizedBox(width: 25.0,),
                    Text("Owner -    "),
                    Text(owner)
                  ],
                ),
                SizedBox(height: 20.0,),
                Row(
                  children: [
                    SizedBox(width: 25.0,),
                    Text("Rate -   "),
                    Text(rate)
                  ],
                ),
                SizedBox(height: 20.0,),
                Row(
                  children: [
                    SizedBox(width: 25.0,),
                    Text("Status -   "),
                    Text(status)
                  ],
                ),
                SizedBox(height: 20.0,),
                ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>BookChargers()));} ,child: Text("Book Charger")),

              ]
          ),
        ),
      ));
    }
  );
}


class Utils{
  static String mapStyle1 = '''
  [
    {
        "featureType": "all",
        "elementType": "labels.text.fill",
        "stylers": [
            {
                "color": "#ffffff"
            }
        ]
    },
    {
        "featureType": "all",
        "elementType": "labels.text.stroke",
        "stylers": [
            {
                "visibility": "on"
            },
            {
                "color": "#3e606f"
            },
            {
                "weight": 2
            },
            {
                "gamma": 0.84
            }
        ]
    },
    {
        "featureType": "all",
        "elementType": "labels.icon",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "administrative",
        "elementType": "geometry",
        "stylers": [
            {
                "weight": 0.6
            },
            {
                "color": "#1a3541"
            }
        ]
    },
    {
        "featureType": "landscape",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#2c5a71"
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#406d80"
            }
        ]
    },
    {
        "featureType": "poi.park",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#2c5a71"
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#29768a"
            },
            {
                "lightness": -37
            }
        ]
    },
    {
        "featureType": "transit",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#406d80"
            }
        ]
    },
    {
        "featureType": "water",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#193341"
            }
        ]
    }
]
  ''';
  static String mapStyle2 = '''
  [
    {
        "featureType": "water",
        "elementType": "geometry",
        "stylers": [
            {
                "visibility": "on"
            },
            {
                "color": "#aee2e0"
            }
        ]
    },
    {
        "featureType": "landscape",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "color": "#abce83"
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "color": "#769E72"
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "labels.text.fill",
        "stylers": [
            {
                "color": "#7B8758"
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "labels.text.stroke",
        "stylers": [
            {
                "color": "#EBF4A4"
            }
        ]
    },
    {
        "featureType": "poi.park",
        "elementType": "geometry",
        "stylers": [
            {
                "visibility": "simplified"
            },
            {
                "color": "#8dab68"
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "visibility": "simplified"
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "labels.text.fill",
        "stylers": [
            {
                "color": "#5B5B3F"
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "labels.text.stroke",
        "stylers": [
            {
                "color": "#ABCE83"
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "labels.icon",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "road.local",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#A4C67D"
            }
        ]
    },
    {
        "featureType": "road.arterial",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#9BBF72"
            }
        ]
    },
    {
        "featureType": "road.highway",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#EBF4A4"
            }
        ]
    },
    {
        "featureType": "transit",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "administrative",
        "elementType": "geometry.stroke",
        "stylers": [
            {
                "visibility": "on"
            },
            {
                "color": "#87ae79"
            }
        ]
    },
    {
        "featureType": "administrative",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "color": "#7f2200"
            },
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "administrative",
        "elementType": "labels.text.stroke",
        "stylers": [
            {
                "color": "#ffffff"
            },
            {
                "visibility": "on"
            },
            {
                "weight": 4.1
            }
        ]
    },
    {
        "featureType": "administrative",
        "elementType": "labels.text.fill",
        "stylers": [
            {
                "color": "#495421"
            }
        ]
    },
    {
        "featureType": "administrative.neighborhood",
        "elementType": "labels",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    }
]
  ''';
}


