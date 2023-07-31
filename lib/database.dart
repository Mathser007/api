
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBStudentManager {
  late Database _datebase;

  Future openDB() async {
    _datebase = await openDatabase(join(await getDatabasesPath(), "nurse.db"),
        version: 1, onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE nurse(nurse_id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,start TEXT,end TEXT,service TEXT,hospital TEXT)");
        });
  }



  Future<int> insertNurse(Nurse nurse) async {
    await openDB();
    return await _datebase.insert('nurse', nurse.toMap());

  }




  Future<List<Nurse>> getNurseList() async {
    await openDB();
    final List<Map<String, dynamic>> maps = await _datebase.query('nurse');
    return List.generate(maps.length, (index) {
      return Nurse(id: maps[index]['nurse_id'], name: maps[index]['name'], start: maps[index]['start'],
          end: maps[index]['end'],service: maps[index]['service'],hospital: maps[index]['hospital']);
    });
  }


  Future<int> updateNurse(Nurse nurse) async {
    await openDB();
    return await _datebase.update('nurse', nurse.toMap(), where: 'nurse_id=?', whereArgs: [nurse.id]);
  }

  Future<void> deleteNurse(String? name) async {
    await openDB();
    await _datebase.delete("nurse", where: "name = ? ", whereArgs: [name]);
  }
}

class Nurse {
  int? id;
  String name;
  String start;
  String end;
  String service;
  String hospital;

  Nurse({ this.id,required this.name, required this.start,required this.end,required this.hospital,required this.service});
  Map<String, dynamic> toMap() {
    return {'nurse_id':id,'name': name, 'start': start,'end':end,'service':service,'hospital':hospital};
  }
}