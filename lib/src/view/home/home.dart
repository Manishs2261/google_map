import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Completer<GoogleMapController> _controller = Completer();


  static final CameraPosition _kGooglePlex =const CameraPosition(
      target: LatLng(31.3380959, 76.7611631),zoom: 15);

  List<Marker>_marker =[];
  List<Marker> list = const[
    Marker(markerId: MarkerId('1'),

    position:LatLng(31.3380959, 76.7611631),
      infoWindow: InfoWindow(
          title: 'my postion'
      ),),

  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(list);
  }


  Future<Position> getUserCurrentLOcation() async{
    await Geolocator.requestPermission().then((value){

    }).onError((error, stackTrace) {
      print("error"+error.toString());

    });

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
          markers: Set<Marker>.of(_marker),
        compassEnabled: true,
        myLocationEnabled: true,

        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // GoogleMapController controller = await _controller.future;
          // controller.animateCamera(CameraUpdate.newCameraPosition(
          //   CameraPosition(target:LatLng(36.2048, 138.2529),zoom: 10 )
          // ));

          getUserCurrentLOcation().then((value) async {
            print(value.latitude.toString() +" "+value.longitude.toString());

            _marker.add(
              Marker(markerId:MarkerId('2'),
              position: LatLng(value.latitude,value.longitude))
            );

            CameraPosition cameraPosition = CameraPosition(zoom: 14,target:LatLng(value.latitude,value.longitude));

            final GoogleMapController controller2 = await _controller.future;
            controller2.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

            setState(() {

            });

          });



          setState(() {

          });
        },
      ),
    );
  }
}
