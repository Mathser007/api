
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite/main.dart';

import 'database.dart';

class Scheduling extends StatefulWidget {
  const Scheduling({Key? key}) : super(key: key);

  @override
  State<Scheduling> createState() => _SchedulingState();
}

class _SchedulingState extends State<Scheduling> with TickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> data = [];
  final DBStudentManager dbStudentManager = DBStudentManager();
  late List<Nurse> studlist;
  Nurse? nurse;
  late int updateindex;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchData();
  }

  Future<void> fetchData() async {
    List<Map<String, dynamic>> result = await fetchDataFromDatabase();
    setState(() {
      data = result;
    });
  }

  @override

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white70,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Homepage()),
            );
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
        ),
        bottom: TabBar(
          padding: EdgeInsets.all(10),
          controller: _tabController,
          // give the indicator a decoration (color and border radius)
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(
              8,
            ),
            color: Colors.green,
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          tabs: [
            // first tab [you can add an icon using the icon property]
            Tab(
              text: 'Schedules',
            ),

            // second tab [you can add an icon using the icon property]
            Tab(
              text: 'Past Schedules',
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: dbStudentManager.getNurseList(),
    builder: (context, snapshot) {
    if (snapshot.hasData) {
      studlist = snapshot.data as List<Nurse>;
      return ListView.builder(
          shrinkWrap: true,
          itemCount: studlist == null ? 0 : studlist.length,
          itemBuilder: (BuildContext context, int index) {
            Nurse st = studlist[index];
            return Card(
              child: Container(
                height: 200,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // first tab bar view widget
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 20, top: 10, left: 20),
                      child: Container(
                        height: 600,
                        width: 200,
                        child: ListView(children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            height: 160,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                      EdgeInsets.only(
                                          top: 20, left: 20, right: 28),
                                      child: Expanded(
                                        child: Column(
                                          children: [
                                            Text("Start date"),
                                            Text(
                                              "${st.start}",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      EdgeInsets.only(
                                          top: 20, left: 20, right: 30),
                                      child: Column(
                                        children: [
                                          Text("End date"),
                                          Text(
                                            "${st.end}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, left: 10, right: 20),
                                      child: Column(
                                        children: [
                                          Text("Nurse Name"),
                                          Text(
                                            "Amala joy",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Divider(
                                    height: 10,
                                    thickness: 1,
                                    indent: 10,
                                    endIndent: 0,
                                    color: Colors.black,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                      EdgeInsets.only(
                                          top: 5, left: 20, right: 28),
                                      child: Column(
                                        children: [
                                          Text("Service"),
                                          Text(
                                            "Home Nurse",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      EdgeInsets.only(
                                          top: 5, left: 10, right: 30),
                                      child: Column(
                                        children: [
                                          Text("Hospital"),
                                          Text(
                                            "MMC",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 5, right: 30),
                                      child: Column(
                                        children: [
                                          ElevatedButton(
                                              onPressed: () {
                                                _Dialog(context);
                                                dbStudentManager.deleteNurse(st.name);
                                                setState(() {
                                                  studlist.removeAt(index);
                                                });
                                              },
                                              child: Text("Cancel"),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.redAccent))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),


                        ]
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

      );
    }
      return CircularProgressIndicator();
    }
      )
    );
    }

void _Dialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content:Container(
          height: 200,
          width: 150,
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/images/untick.png"),

              ),
              Padding(
                padding: const EdgeInsets.only(top: 38,left: 20,right: 20,bottom: 10),
                child: Text("Your Booking Will be Cancelled",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
              )
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top:10,left: 70,right:80,bottom: 10),
            child: ElevatedButton(
              child:Text("Cancel Booking"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  Home1()),
                );

              },style: ElevatedButton.styleFrom(
                primary: Colors.redAccent
            ),
            ),
          ),
        ],
      );
    },
  );
}
    fetchDataFromDatabase() async {
      // Get a location using getDatabasesPath()
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'nurse.db');

      // Open the database
      Database database = await openDatabase(path, version: 1);

      // Query the database for all entries in the 'person' table
      List<Map<String, dynamic>> result = await database.query('nurse');

      // Close the database
      await database.close();

      return result;
    }
  }