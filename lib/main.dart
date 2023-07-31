
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'database.dart';
import 'new1.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home1(),
    );
  }
}
class Home1 extends StatefulWidget {
  const Home1({Key? key}) : super(key: key);

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  final List<String> items = [
    'Home Nurse',

  ];
  final DBStudentManager dbStudentManager = DBStudentManager();
  final _nameController = TextEditingController();
  final _startController = TextEditingController();
  final _endController = TextEditingController();
  final _serviceController = TextEditingController();
  final _hospitalController = TextEditingController();
  TextEditingController dateinput = TextEditingController();
  TextEditingController dateoutput = TextEditingController();
  String? selectedValue;
  final _formkey = GlobalKey<FormState>();
  Nurse? nurse;
  late int updateindex;

  late List<Nurse> studlist;
  @override
  void initState() {
    dateinput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Form(
        key: _formkey,

        child: ListView(
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(top: 60, left: 8, right: 8),
              //   child: TextFormField(
              //     decoration: InputDecoration(
              //       prefixIcon: Icon(Icons.search),
              //       border: OutlineInputBorder()
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top:40),
                child: SizedBox(
                  width: 350,
                  height: 180,
                  child: Image.asset("assets/images/img.png"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Make a Booking",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10,left: 15,right: 15),
                child: SizedBox(
                  width: 350,
                  height: 60,
                  child: DropdownButton2(
                    hint: Text(
                      'Select Services',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items: items
                        .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                        .toList(),
                    value: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value as String;
                      });
                    },
                    buttonStyleData: const ButtonStyleData(
                      height: 40,
                      width: 500,
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      width: 185,
                      child: TextField(
                        controller: _startController, //editing controller of this TextField
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.calendar_today),
                            enabledBorder: OutlineInputBorder(), //icon of text field
                            labelText: "Start Date" //label text of field
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                  2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            print(pickedDate);
                            String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(formattedDate);

                            setState(() {
                              _startController.text = formattedDate;
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      width: 185,
                      child: TextField(
                        controller: _endController, //editing controller of this TextField
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.calendar_today),
                            enabledBorder: OutlineInputBorder(), //icon of text field
                            labelText: "End Date" //label text of field
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                  2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            print(pickedDate);
                            String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(formattedDate);

                            setState(() {
                              _endController.text = formattedDate;
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone_android),
                      enabledBorder: OutlineInputBorder(),
                      labelText: "Contact Number"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(), labelText: "Name"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _serviceController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      labelText: "House/Flat/Building Name"),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      width: 185,
                      child: TextField(
                        controller: _hospitalController,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(),
                            labelText: "House Number"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      width: 185,
                      child: TextField(
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(), labelText: "Pin Code"),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      width: 185,
                      child: ElevatedButton(
                        onPressed: () {
                          _nameController.clear();
                          _startController.clear();
                          _endController.clear();
                          _serviceController.clear();
                          _hospitalController.clear();
                          dateinput.clear();
                          dateoutput.clear();
                        },
                        child: Text(
                          "Reset",
                        ),
                        style: ElevatedButton.styleFrom(primary: Colors.grey),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      width: 185,
                      child: ElevatedButton(
                        onPressed: () {
                          submitStudent(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  Scheduling()),
                          );
                        },
                        child: Text(
                          "Check Availability",
                        ),
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                      ),
                    ),
                  ),
                ],
              ),


            ]),
      ),
    );
  }
void submitStudent(BuildContext context) {
  if (_formkey.currentState!.validate()) {
    if (nurse == null) {
      Nurse st =  Nurse(
          name: _nameController.text, start: _startController.text,end: _endController.text,service: _serviceController.text,
          hospital: _hospitalController.text);
      dbStudentManager.insertNurse(st).then((value) => {
        _nameController.clear(),
        _startController.clear(),
        _endController.clear(),
        _serviceController.clear(),
        _hospitalController.clear(),
        print("nurse Data Add to database $value"),
      });
    }
    else {
      nurse?.name = _nameController.text;
      nurse?.start = _startController.text;
      nurse?.end=_endController.text;
      nurse?.service=_serviceController.text;
      nurse?.hospital=_hospitalController.text;

      dbStudentManager.updateNurse(nurse!).then((value) {
        setState(() {
          studlist[updateindex].name = _nameController.text;
          studlist[updateindex].start = _startController.text;
          studlist[updateindex].end=_endController.text;
          studlist[updateindex].service=_serviceController.text;
          studlist[updateindex].hospital=_hospitalController.text;
        });
        _nameController.clear();
        _startController.clear();
        _endController.clear();
        _serviceController.clear();
        _hospitalController.clear();
        nurse=null;
      });
    }
  }
}
}


