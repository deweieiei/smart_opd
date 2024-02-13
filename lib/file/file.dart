import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:smart_opd/provider.dart';

class File_Save extends StatefulWidget {
  const File_Save({super.key});

  @override
  State<File_Save> createState() => _File_SaveState();
}

class _File_SaveState extends State<File_Save> {
  List data = [];
  List datakey = [];
  void loadSave() async {
    setState(() {
      data = [];
      print('-----');
    });

    Directory app = await getApplicationDocumentsDirectory();
    String dbpart = app.path + 'opd.db';
    final db = await databaseFactoryIo.openDatabase(dbpart);
    final store = intMapStoreFactory.store('data');
    var snapshot = await store.find(db);
    for (var records in snapshot) {
      setState(() {
        data.add(records);
        datakey.add(records.key);
      });
      print(records.key);
    }
    Timer(Duration(seconds: 2), () {
      setState(() {});
    });
  }

  @override
  void initState() {
    loadSave();
    // TODO: implement initState
    super.initState();
  }

  Text texts(String text) {
    return Text(
      '$text',
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
      style: TextStyle(color: Colors.white, fontSize: 18),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 8, 44, 73),
        body: SafeArea(
          child: Container(
            child: Column(children: [
              Container(
                color: Color.fromARGB(255, 5, 26, 43),
                width: _width,
                child: Row(
                  children: [
                    Text('SMART OPD',
                        style: TextStyle(
                            color: Colors.white, fontSize: _height * 0.04))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(255, 0, 2, 114),
                            offset: Offset(0, 13),
                            blurRadius: 13,
                            spreadRadius: -10)
                      ],
                      color: Color.fromARGB(255, 7, 36, 59),
                      borderRadius: BorderRadius.circular(5)),
                  height: _height * 0.68,
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        var value = data[index]['data'];
                        var valuekey = datakey[index];
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            width: _width,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromARGB(255, 0, 2, 114),
                                      offset: Offset(0, 13),
                                      blurRadius: 13,
                                      spreadRadius: -10)
                                ],
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromARGB(255, 26, 61, 88)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 5, 26, 43),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                            width: _width * 0.05,
                                            child: texts('NO : ${index + 1}')),
                                        Container(
                                            width: _width * 0.2,
                                            child:
                                                texts('HN : ${value['hn']}')),
                                        Container(
                                            width: _width * 0.2,
                                            child: texts(
                                                'Name : ${value['name']}')),
                                        Container(
                                            width: _width * 0.06,
                                            child:
                                                texts('Sex : ${value['sex']}')),
                                        Container(
                                            width: _width * 0.16,
                                            child: texts(
                                                'Staff : ${value['staff']}')),
                                        Container(
                                            width: _width * 0.22,
                                            child: texts(
                                                'Time : ${value['time']}')),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: _width * 0.56,
                                        child: Column(children: [
                                          Row(
                                            children: [
                                              Container(
                                                  width: _width * 0.14,
                                                  child: texts(
                                                      'SYS/DIA : ${value['sys']}/${value['dia']}')),
                                              Container(
                                                  width: _width * 0.14,
                                                  child: texts(
                                                      'Pulse : ${value['pulse']}')),
                                              Container(
                                                  width: _width * 0.14,
                                                  child: texts(
                                                      'Spo2 : ${value['spo2']}')),
                                              Container(
                                                  width: _width * 0.14,
                                                  child: texts(
                                                      'Bpm : ${value['bpm']}')),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                  width: _width * 0.14,
                                                  child: texts(
                                                      'Temp : ${value['temp']}')),
                                              Container(
                                                  width: _width * 0.14,
                                                  child: texts(
                                                      'Weight : ${value['weight']}')),
                                              Container(
                                                  width: _width * 0.14,
                                                  child: texts(
                                                      'Hright : ${value['hright']}')),
                                              Container(
                                                  width: _width * 0.14,
                                                  child: texts(
                                                      'BMI : ${value['bmi']}')),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                  width: _width * 0.14,
                                                  child: texts(
                                                      'Type : ${value['type']}')),
                                              Container(
                                                  width: _width * 0.14,
                                                  child: texts(
                                                      'Select : ${value['select']}')),
                                              Container(
                                                  width: _width * 0.14,
                                                  child: texts(
                                                      'Score : ${value['score']}')),
                                              Container(width: _width * 0.14),
                                            ],
                                          )
                                        ]),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 26, 61, 88)),
                                        width: _width * 0.4,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.red),
                                                onPressed: () {
                                                  print("ลบ: $valuekey");
                                                  loadSave();
                                                  DataProvider().delete_data(
                                                      '${valuekey}');
                                                },
                                                child: Text(' ลบ ')),
                                            SizedBox(width: _width * 0.01),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.green),
                                                onPressed: () {},
                                                child: Text(' ส่ง ')),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: _height * 0.05)
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
              Container(
                height: _height * 0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                height: _height * 0.08,
                                width: _width * 0.12,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 17, 14, 158),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Center(
                                  child: Text(
                                    'กลับ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: _height * 0.05,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ]),
          ),
        ));
  }
}
