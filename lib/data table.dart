import 'package:flutter/material.dart';

class Episode5 extends StatefulWidget {
  @override
  Episode5State createState() {
    return new Episode5State();
  }
}

class Episode5State extends State<Episode5> {
  Widget bodyData() => DataTable(
      onSelectAll: (b) {},
      sortColumnIndex: 1,
      sortAscending: true,
      columns: <DataColumn>[
        DataColumn(
          label: Text("First Name"),
          numeric: false,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              names.sort((a, b) => a.firstName.compareTo(b.firstName));
            });
          },
          tooltip: "To display first name of the Name",
        ),
        DataColumn(
          label: Text("Last Name"),
          numeric: false,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              names.sort((a, b) => a.lastName.compareTo(b.lastName));
            });
          },
          tooltip: "To display last name of the Name",
        ),
                DataColumn(
                label: Text("address"),
                numeric: false,
                onSort: (i, b) {
                print("$i $b");
                setState(() {
                names.sort((a, b) => a.address.compareTo(b.address));
                });
                },
          tooltip: "To display last name of the Name",
                ),
                    ],
      rows: names
          .map(
            (name) => DataRow(
          cells: [
            DataCell(
              Text(name.firstName),
              showEditIcon: false,
              placeholder: false,
            ),
            DataCell(
              Text(name.lastName),
              showEditIcon: false,
              placeholder: false,
            ),

            DataCell(
              Text(name.address),
              showEditIcon: false,
              placeholder: false,
            )
          ],
        ),
      )
          .toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Episode 5 - Data Table"),
      ),
      body: Container(
        child: bodyData(),
      ),
    );
  }
}

class Name {
  String firstName;
  String lastName;
  String address;

  Name({this.firstName, this.lastName, this.address, });
}

var names = <Name>[
  Name(firstName: "Pawan", lastName: "Kumar", address:"ff", ),

];