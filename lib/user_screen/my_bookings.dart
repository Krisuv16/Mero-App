import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:meroapp/constants/api_constants.dart';
import 'package:meroapp/user_screen/booking_details.dart';

class MyRequests extends StatefulWidget {
  @override
  _MyRequestsState createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  LocalStorage storage = LocalStorage("storage-key");
  Future<List> fetchrequests() async {
    var token = storage.getItem("token");
    var url = Uri.parse(api_url + "/booking/request/");
    var response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      return jsonDecode(response.body);
    } else {
      print(response.body);
      throw Exception("Error");
    }
  }

  @override
  void initState() {
    fetchrequests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("My Bookings"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List>(
              future: fetchrequests(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new BookingDetails(
                                          index: index,
                                          list: snapshot.data,
                                        )));
                              },
                              child: Card(
                                elevation: 6,
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Text("ID"),
                                      title: Text(
                                        snapshot.data[index]["id"].toString(),
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
                                          snapshot.data[index]["category"],
                                          textAlign: TextAlign.center,
                                        )),
                                    Divider(
                                      height: 0.6,
                                      color: Colors.black87,
                                    ),
                                    ListTile(
                                        leading: Text("Name"),
                                        title: Text(
                                          snapshot.data[index]["vehicle_name"],
                                          textAlign: TextAlign.center,
                                        )),
                                    Divider(
                                      height: 0.6,
                                      color: Colors.black87,
                                    ),
                                    ListTile(
                                      leading: Text("Problem"),
                                      title: Text(
                                        snapshot.data[index]
                                            ["problem_description"],
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Divider(
                                      height: 0.6,
                                      color: Colors.black87,
                                    ),
                                    ListTile(
                                        leading: Text("Status"),
                                        title: snapshot.data[index]["status"] ==
                                                "Booked"
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Booked",
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Pending",
                                                  style: TextStyle(
                                                      color: Colors.amber,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
