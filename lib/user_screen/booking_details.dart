import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:meroapp/constants/api_constants.dart';

class BookingDetails extends StatefulWidget {
  List list;
  int index;
  BookingDetails({this.list, this.index});
  @override
  _BookingDetailsState createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  LocalStorage storage = LocalStorage("storage-key");
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
    fetchprofile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("Confirm Booking"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                      leading: Text("Model"),
                      title: Text(
                        widget.list[widget.index]["vehicle_model"],
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Divider(
                      height: 0.6,
                      color: Colors.black87,
                    ),
                    ListTile(
                      leading: Text("Brand"),
                      title: Text(
                        widget.list[widget.index]["vehicle_brand"],
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
                    ListTile(
                      leading: Text("Problem"),
                      title: Text(
                        widget.list[widget.index]["problem_description"],
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ListTile(
                      leading: Text("Date"),
                      title: Text(
                        widget.list[widget.index]["date"],
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Divider(
                      height: 0.6,
                      color: Colors.black87,
                    ),
                    Container(
                      child: FutureBuilder(
                        future: fetchprofile(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListTile(
                              leading: Text("Customer"),
                              title: Text(
                                snapshot.data["user"]["name"],
                                textAlign: TextAlign.center,
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
                    Divider(
                      height: 0.6,
                      color: Colors.black87,
                    ),
                    ListTile(
                      leading: Text("Status"),
                      title: Text(
                        widget.list[widget.index]["status"],
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
          ],
        ),
      ),
    );
  }
}
