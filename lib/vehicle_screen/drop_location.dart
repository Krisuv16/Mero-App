import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:meroapp/constants/api_constants.dart';

class Maped extends StatefulWidget {
  List list;
  int index;
  Maped({this.list, this.index});
  @override
  _MapedState createState() => _MapedState();
}

class _MapedState extends State<Maped> {
  PickResult selectedPlace;
  var img;
  var marker = Set<Marker>();
  final LatLng _center = const LatLng(27.717245, 85.323959);

  GoogleMapController _controller;

  Future<void> fetchprofile() async {
    var response = await http.get(
        api_url + "/auth/customer/${widget.list[widget.index]["customer"]}/");
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      return jsonDecode(response.body);
    } else {
      throw Exception("Error");
    }
  }

  @override
  void initState() {
    marker.add(Marker(
        markerId: MarkerId("id-1"),
        draggable: false,
        position: LatLng(double.parse(widget.list[widget.index]["lats"]),
            double.parse(widget.list[widget.index]["longs"])),
        icon: BitmapDescriptor.defaultMarker));

    fetchprofile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Drop Location")),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 50.0,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 15.0,
              ),
              markers: Set.from(marker),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              height: 150.0,
              child: Stack(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: Text(
                                "Dropping Address:  " +
                                    widget.list[widget.index]
                                        ["drop_off_address"],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              width: 170.0,
                              child: Text(
                                "Vehicle Name:  " +
                                    widget.list[widget.index]["vehicle_name"],
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              width: 170.0,
                              child: Text(
                                "Vehicle Number:  " +
                                    widget.list[widget.index]["vehicle_no"],
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            FutureBuilder(
                              future: fetchprofile(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Vehicle Owner:  " +
                                              snapshot.data["user"]["name"],
                                          style: TextStyle(
                                              fontSize: 18.5,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "Owner Number:  " +
                                              snapshot.data["user"]["phone"],
                                          style: TextStyle(
                                              fontSize: 17.5,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Column(
                                    children: [
                                      Container(
                                        child: Text(
                                          "x",
                                          style: TextStyle(
                                              fontSize: 12.5,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        width: 120.0,
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          "xx",
                                          style: TextStyle(
                                              fontSize: 12.5,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                          ]),
                    ),
                  ),
                  // child: Container(
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(10.0),
                  //         color: Colors.white),
                  //     child: Column(
                  //       children: [
                  //         Row(children: [
                  //           SizedBox(width: 5.0),

                  //           //
                  //         ]),
                  //       ],
                  //     ))
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }
}
