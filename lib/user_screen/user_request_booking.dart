import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
  String _Vehicleno;
  String _Vehiclename;
  String _vehiclemodel;
  String _VehicleBrand;
  String _ProblemDescription;

  List Category = [
    'Two Wheeler with Gear',
    '4 Wheeler with gear',
    '4 wheeler without gear'
  ];
  List Services = [
    'FullServicing',
    'HalfServicing',
    'BatteryReplacement',
    'WheelTruing'
  ];

  String firstItem;
  String secondItem;
  String thirdItem;
  String fourthItem;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildVehicleno() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Vehicleno'),
      maxLength: 10,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _Vehicleno = value;
      },
    );
  }

  Widget firstDropDown() {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        icon: Icon(Icons.arrow_drop_down),
        hint: Text(
          'Select Category',
        ),
        isExpanded: true,
        value: firstItem,
        items: Category.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: (selectedItem) {
          setState(() {
            firstItem = selectedItem;
          });
        },
      ),
    );
  }

  Widget secondDropDown() {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        icon: Icon(Icons.arrow_drop_down),
        hint: Text(
          'Select Services',
        ),
        isExpanded: true,
        value: secondItem,
        items: Services.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: (selectedItem) {
          setState(() {
            secondItem = selectedItem;
          });
        },
      ),
    );
  }

  Widget _buildVehiclename() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Vehiclename'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'vehicle Name required';
        }

        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid vehicleno';
        }

        return null;
      },
      onSaved: (String value) {
        _Vehiclename = value;
      },
    );
  }

  Widget _buildvehiclemodel() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'vehiclemodel'),
      keyboardType: TextInputType.visiblePassword,
      validator: (String value) {
        if (value.isEmpty) {
          return 'vehiclemodel is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _vehiclemodel = value;
      },
    );
  }

  Widget _buildVehicleBrand() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'VehicleBrand'),
      keyboardType: TextInputType.url,
      validator: (String value) {
        if (value.isEmpty) {
          return 'vehicle brand is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _VehicleBrand = value;
      },
    );
  }

  Widget _buildProblemDescription() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'ProblemDescription'),
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return 'problem description is required ';
        }

        return null;
      },
      onSaved: (String value) {
        _ProblemDescription = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Booking details")),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildVehicleno(),
                _buildVehiclename(),
                _buildvehiclemodel(),
                _buildVehicleBrand(),
                _buildProblemDescription(),
                firstDropDown(),
                secondDropDown(),
                SizedBox(height: 100),
                RaisedButton(
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }

                    _formKey.currentState.save();

                    print(_Vehicleno);
                    print(_Vehiclename);
                    print(_vehiclemodel);
                    print(_VehicleBrand);
                    print(_ProblemDescription);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
