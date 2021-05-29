import 'package:flutter/material.dart';
import 'package:meroapp/user_screen/request_services.dart';

class WorkShopDetails extends StatefulWidget {
  List list;
  int index;
  WorkShopDetails({this.index, this.list});
  @override
  _WorkShopDetailsState createState() => _WorkShopDetailsState();
}

class _WorkShopDetailsState extends State<WorkShopDetails> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: Text(widget.list[widget.index]["user"]["user"]["name"]),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "WorkShop Details",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway',
                ),
              ),
            ),
            Container(
              width: width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name:  " +
                              widget.list[widget.index]["user"]["user"]["name"],
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Raleway',
                          ),
                        ),
                        Text(
                          "Email:  " +
                              widget.list[widget.index]["user"]["user"]
                                  ["email"],
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Raleway',
                          ),
                        ),
                        Text(
                          "Phone:  " +
                              widget.list[widget.index]["user"]["user"]
                                  ["phone"],
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Raleway',
                          ),
                        ),
                        Text(
                          "Address:  " +
                              widget.list[widget.index]["user"]["user"]
                                  ["address"],
                                  maxLines: 1,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Raleway',
                          ),
                        ),
                        Text(
                          "Description:  " +
                              widget.list[widget.index]["user"]
                                  ["workshop_about"],
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Raleway',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "WorkShop Services",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway',
                ),
              ),
            ),
            Container(
              width: width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Battery Replacement:  ",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Raleway',
                              ),
                            ),
                            widget.list[widget.index]["battery_replacement"] ==
                                    "true"
                                ? Icon(
                                    Icons.done,
                                    color: Colors.green,
                                  )
                                : Icon(
                                    Icons.highlight_remove_sharp,
                                    color: Colors.red,
                                  )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Brake Pad Change:  ",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Raleway',
                              ),
                            ),
                            widget.list[widget.index]["brake_pad_change"] ==
                                    "true"
                                ? Icon(
                                    Icons.done,
                                    color: Colors.green,
                                  )
                                : Icon(
                                    Icons.highlight_remove_sharp,
                                    color: Colors.red,
                                  )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Timing Belt Replacement:  ",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Raleway',
                              ),
                            ),
                            widget.list[widget.index]
                                        ["timing_belt_replacement"] ==
                                    "true"
                                ? Icon(
                                    Icons.done,
                                    color: Colors.green,
                                  )
                                : Icon(
                                    Icons.highlight_remove_sharp,
                                    color: Colors.red,
                                  )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Wheel Turing:  ",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Raleway',
                              ),
                            ),
                            widget.list[widget.index]["wheel_truing"] == "true"
                                ? Icon(
                                    Icons.done,
                                    color: Colors.green,
                                  )
                                : Icon(
                                    Icons.highlight_remove_sharp,
                                    color: Colors.red,
                                  )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Full Servicing:  ",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Raleway',
                              ),
                            ),
                            widget.list[widget.index]["full_servicing"] ==
                                    "true"
                                ? Icon(
                                    Icons.done,
                                    color: Colors.green,
                                  )
                                : Icon(
                                    Icons.highlight_remove_sharp,
                                    color: Colors.red,
                                  )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Partial Servicing:  ",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Raleway',
                              ),
                            ),
                            widget.list[widget.index]["partial_servicing"] ==
                                    "true"
                                ? Icon(
                                    Icons.done,
                                    color: Colors.green,
                                  )
                                : Icon(
                                    Icons.highlight_remove_sharp,
                                    color: Colors.red,
                                  )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Vehicle Full Wash:  ",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Raleway',
                              ),
                            ),
                            widget.list[widget.index]["vehicle_full_wash"] ==
                                    "true"
                                ? Icon(
                                    Icons.done,
                                    color: Colors.green,
                                  )
                                : Icon(
                                    Icons.highlight_remove_sharp,
                                    color: Colors.red,
                                  )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Vehicle Partial Wash:  ",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Raleway',
                              ),
                            ),
                            widget.list[widget.index]["vehicle_partial_wash"] ==
                                    "true"
                                ? Icon(
                                    Icons.done,
                                    color: Colors.green,
                                  )
                                : Icon(
                                    Icons.highlight_remove_sharp,
                                    color: Colors.red,
                                  )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => new RequestServices(
                          index: widget.list[widget.index]["user"]["user"]["id"],
                        ))),
                child: Text("Request Service"))
          ],
        ),
      ),
    );
  }
}
