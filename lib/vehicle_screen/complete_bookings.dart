import 'dart:convert';
import 'dart:io';
import 'package:expandable/expandable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:meroapp/constants/api_constants.dart';

class CompleteBooking extends StatefulWidget {
  List list;
  int index;
  CompleteBooking({this.list, this.index});
  @override
  _CompleteBookingState createState() => _CompleteBookingState();
}

class _CompleteBookingState extends State<CompleteBooking> {
  LocalStorage storage = LocalStorage("storage-key");
  String value;
  List listItem = ["Completed", "Booked"];
  PickResult selectedPlace;
  var img;
  var address;
  var lats;
  var longs;
  final LatLng _center = const LatLng(27.717245, 85.323959);
  Future<List> fetchrequests() async {
    var token = storage.getItem("token");
    var url = Uri.parse(api_url + "/booking/book/");
    var response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Krisuv");
      print(response.body);
      return jsonDecode(response.body);
    } else {
      print("Krisuv");
      print(response.body);
      throw Exception("Error");
    }
  }

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

  Future update() async {
    var data = {
      "id": widget.list[widget.index]["id"],
      "category": widget.list[widget.index]["category"],
      "vehicle_no": widget.list[widget.index]["vehicle_no"],
      "vehicle_name": widget.list[widget.index]["vehicle_name"],
      "vehicle_model": widget.list[widget.index]["vehicle_model"],
      "vehicle_brand": widget.list[widget.index]["vehicle_brand"],
      "services": widget.list[widget.index]["services"],
      "problem_description": widget.list[widget.index]["problem_description"],
      "date": widget.list[widget.index]["date"],
      "status": widget.list[widget.index]["status"],
      "lats": lats,
      "longs": longs,
      "drop_off_address": address,
      "customer": widget.list[widget.index]["customer"],
      "workshop": widget.list[widget.index]["workshop"]
    };
    var token = storage.getItem("token");
    var url = Uri.parse(
        api_url + "/booking/request/${widget.list[widget.index]["id"]}/");
    var response = await http.patch(url, body: json.encode(data), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return new AlertDialog(
              title: Text("Delivery Address has been set"),
              actions: [
                FlatButton(
                    color: Colors.green,
                    onPressed: () async {
                      Navigator.of(context).pushNamed("v_dashboard");
                    },
                    child: Text(
                      "ok",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            );
          });
      print(response.statusCode);
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return new AlertDialog(
              title: Text("Request Error"),
              actions: [
                FlatButton(
                    color: Colors.green,
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "ok",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            );
          });
      print(response.body);
      print(response.statusCode);
    }
    print(data);
  }

  @override
  void initState() {
    fetchrequests();
    fetchprofile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("Set Delivery Adddress"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Vechicle Information",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 6,
                child: Column(
                  children: [
                    ListTile(
                      leading: Text("ID"),
                      title: Text(
                        widget.list[widget.index]["id"].toString(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Divider(
                      height: 0.6,
                      color: Colors.black87,
                    ),
                    ListTile(
                        leading: Text("Category"),
                        title: Text(
                          widget.list[widget.index]["category"],
                          textAlign: TextAlign.center,
                        )),
                    Divider(
                      height: 0.6,
                      color: Colors.black87,
                    ),
                    ListTile(
                        leading: Text("Name"),
                        title: Text(
                          widget.list[widget.index]["vehicle_name"],
                          textAlign: TextAlign.center,
                        )),
                    Divider(
                      height: 0.6,
                      color: Colors.black87,
                    ),
                    ListTile(
                      leading: Text("Vehicle No"),
                      title: Text(
                        widget.list[widget.index]["vehicle_no"],
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Divider(
                      height: 0.6,
                      color: Colors.black87,
                    ),
                    ListTile(
                      leading: Text("Services"),
                      title: Text(
                        widget.list[widget.index]["services"],
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Divider(
                      height: 0.6,
                      color: Colors.black87,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Customer Information",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Container(
              child: FutureBuilder(
                future: fetchprofile(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 6,
                        child: Column(
                          children: [
                            ListTile(
                              leading: Text("Customer"),
                              title: Text(
                                snapshot.data["user"]["name"],
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Divider(
                              height: 0.6,
                              color: Colors.black87,
                            ),
                            ListTile(
                              leading: Text("Address"),
                              title: Text(
                                snapshot.data["user"]["address"],
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Divider(
                              height: 0.6,
                              color: Colors.black87,
                            ),
                            ListTile(
                              leading: Text("Phone"),
                              title: Text(
                                snapshot.data["user"]["phone"],
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Divider(
                              height: 0.6,
                              color: Colors.black87,
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return ListTile(
                      leading: Text("Customer"),
                      title: Text(
                        "",
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Set Delivery Addres",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpandablePanel(
                    theme: ExpandableThemeData(
                      iconColor: Colors.green,
                      iconSize: 30,
                    ),
                    header: Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 12.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Select Address",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    collapsed: Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Text(
                        "Expand to Set Address",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                    expanded: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                          height: MediaQuery.of(context).size.height / 1.5,
                          width: MediaQuery.of(context).size.width,
                          child: PlacePicker(
                            region: "np",
                            autocompleteRadius: 24000,
                            strictbounds: true,
                            apiKey: gmaps_key,
                            initialPosition: _center,
                            useCurrentLocation: true,
                            selectInitialPosition: true,
                            onPlacePicked: (result) => setState(() {
                              selectedPlace = result;
                              address = selectedPlace.formattedAddress;
                              lats = selectedPlace.geometry.location.lat;
                              longs = selectedPlace.geometry.location.lng;
                              print(address);
                              print(lats);
                              print(longs);
                            }),
                          )),
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () =>
                    address == null || lats == null || longs == null
                        ? null
                        : update(),
                child: Text("Confirm Delivery Addres"))
          ],
        ),
      ),
    );
  }
}
