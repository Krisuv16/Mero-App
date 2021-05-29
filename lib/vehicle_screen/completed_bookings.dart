import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:meroapp/constants/api_constants.dart';

import 'complete_bookings.dart';

class CompletedBookings extends StatefulWidget {
  @override
  _CompletedBookingsState createState() => _CompletedBookingsState();
}

class _CompletedBookingsState extends State<CompletedBookings> {
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
        title: Text("Completed Requests"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder<List>(
                future: fetchrequests(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return snapshot.data[index]["status"] == "Completed"
                              ? Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        new CompleteBooking(
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
                                                snapshot.data[index]["id"]
                                                    .toString(),
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
                                                  snapshot.data[index]
                                                      ["category"],
                                                  textAlign: TextAlign.center,
                                                )),
                                            Divider(
                                              height: 0.6,
                                              color: Colors.black87,
                                            ),
                                            ListTile(
                                                leading: Text("Name"),
                                                title: Text(
                                                  snapshot.data[index]
                                                      ["vehicle_name"],
                                                  textAlign: TextAlign.center,
                                                )),
                                            Divider(
                                              height: 0.6,
                                              color: Colors.black87,
                                            ),
                                            ListTile(
                                              leading: Text("Status"),
                                              title: Text(
                                                snapshot.data[index]["status"],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.green),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container();
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
