import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geocoding/geocoding.dart';

class ConvertLatLongitute extends StatefulWidget {
  const ConvertLatLongitute({super.key});

  @override
  State<ConvertLatLongitute> createState() => _ConvertLatLongituteState();
}

class _ConvertLatLongituteState extends State<ConvertLatLongitute> {


  var address = '',city = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Text(address),
          Text(city),

          ElevatedButton(onPressed: () async {

            List<Location> location = await locationFromAddress("bilaspur");






            print(address);

            setState(() {

              address = location.last.longitude.toString() +" , "+location.last.latitude.toString();

            });



          }, child: Text('convert'))
        ],
      ),
    );
  }
}
