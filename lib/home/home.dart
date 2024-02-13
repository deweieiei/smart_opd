import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_opd/file/file.dart';
import 'package:smart_opd/home/boxtime.dart';
import 'package:smart_opd/provider.dart';
import 'package:usb_serial/usb_serial.dart';
import 'function.dart';
import 'package:permission_handler/permission_handler.dart';

class Home_Smart_OPD extends StatefulWidget {
  const Home_Smart_OPD({super.key});

  @override
  State<Home_Smart_OPD> createState() => _Home_Smart_OPDState();
}

class _Home_Smart_OPDState extends State<Home_Smart_OPD> {
  String command_center = '--';
  String sex = '';
  String age = '';
  DataProvider _provider = DataProvider();
  StreamSubscription<String>? streamValues;
  // final getValues = GetValues();
  StreamSubscription? getValues;
  String _receivedData = '';
  String? seve_score;

  Future<void> _requestCameraPermission() async {
    await Permission.location.request();
    await Permission.bluetooth.request();
    await Permission.camera.request();
    await Permission.audio.request();
    await Permission.microphone.request();
    await Permission.notification.request();
    await Permission.videos.request();
  }

  StreamController<String> value = StreamController<String>();

  DataProvider dataProvider = DataProvider();
  UsbPort? _port;
  String? sys;
  String? dia;
  String? bpr;

  void initSerialCommunication() async {
    List<UsbDevice> devices = await UsbSerial.listDevices();
    for (UsbDevice device in devices) {
      print(device);
      if (device.pid.toString() == '148') {
        _port = await device.create();
        if (!await _port!.open()) {
          print('!await _port!.open()');
          return;
        }
        _port!.setDTR(true);
        _port!.setRTS(true);
        _port!.setPortParameters(
            9600, UsbPort.DATABITS_8, UsbPort.STOPBITS_1, UsbPort.PARITY_NONE);
        _port!.setFlowControl(UsbPort.FLOW_CONTROL_OFF);
        _listenForData();
        break;
      }
    }
  }

  void _listenForData() async {
    String data = '';
    print('กำลังรอค่า');
    _port!.inputStream!.listen((Uint8List event) {
      data += String.fromCharCodes(event);
      print(data);

      List<String> dataList = data.split(';');
      for (String item in dataList) {
        if (item.contains('SYS:')) {
          sys = item.split(':')[1].split(' ')[0].trim();
        } else if (item.contains('DIA:')) {
          dia = item.split(':')[1].split(' ')[0].trim();
        } else if (item.contains('PR:')) {
          bpr = item.split(':')[1].trim().split(' ')[0];
        }
      }
      print('SYS: $sys');
      print('DIA: $dia');
      print('BPM: $bpr');

      dataProvider.sys.text = sys!;
      dataProvider.dia.text = dia!;
      dataProvider.pulse.text = bpr!;
    });
  }

  void disposeGetValue() {
    value.close();
  }

  Stream<String> getValue() {
    return value.stream;
  }

  @override
  void initState() {
    _requestCameraPermission();
    _provider.select.text = selects[4];
    _provider.streamScore();
    initSerialCommunication();

    super.initState();
  }

  @override
  void dispose() {
    disposeGetValue();

    super.dispose();
  }

  List types = ['Walk', 'Wheelchair', 'Bed'];
  List selects = [
    '6 สัปดาห์หลังคลอด',
    'เด็ก 1 เดือน - 1 ปี',
    'เด็ก 1-5 ปี',
    'เด็ก 5-12 ปี',
    '15ปีขึ้นไป'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 8, 44, 73),
      body: ListView(children: [head(), boby()]),
    );
  }

  Widget head() {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    TextStyle style = TextStyle(
        color: Color.fromARGB(255, 135, 201, 255), fontSize: _height * 0.03);
    return Container(
      width: _width,
      color: Color.fromARGB(255, 3, 18, 27),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: _width * 0.3, child: Text('Smart OPD', style: style)),
          Container(
            width: _width * 0.4,
            //   child: StreamBuilder<String>(
            //  //   stream: getValues?.getValue(),
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData) {
            //         return Text('ศูนย์สั่งการ: ${snapshot.data}', style: style);
            //       } else {
            //         return Text('ศูนย์สั่งการ...', style: style);
            //       }
            //     },
            //   ),
          ),
          Box_Time(),
        ],
      ),
    );
  }

  FocusNode _focusNode = FocusNode();
  Widget boby() {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    TextStyle style = TextStyle(
        color: Color.fromARGB(255, 135, 201, 255), fontSize: _height * 0.03);
    TextStyle style_white =
        TextStyle(color: Colors.white, fontSize: _height * 0.03);
    BoxDecoration boxDecoration = BoxDecoration(
      border: Border.all(
        color: Color.fromARGB(255, 135, 201, 255),
      ),
      borderRadius: BorderRadius.circular(4),
    );
    BoxDecoration boxDecoration_white = BoxDecoration(
      border: Border.all(
        color: Colors.white,
      ),
      borderRadius: BorderRadius.circular(4),
    );

    BoxDecoration boxDecoration2 = BoxDecoration(
      color: Color.fromARGB(255, 3, 0, 26),
      border: Border.all(
        color: Color.fromARGB(255, 11, 61, 102),
      ),
      borderRadius: BorderRadius.circular(6),
    );
    BoxDecoration boxDecoration3 = BoxDecoration(
      color: Color.fromARGB(255, 4, 24, 53),
      border: Border.all(
        color: Color.fromARGB(255, 11, 61, 102),
      ),
      borderRadius: BorderRadius.circular(6),
    );
    return Column(
      children: [
        Container(
          color: Color.fromARGB(255, 11, 61, 102),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Container(
              decoration: boxDecoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Container(child: Text(' HN : ', style: style)),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                          child: Container(
                            width: _width * 0.075,
                            decoration: boxDecoration,
                            child: TextField(
                              controller: _provider.hn,
                              focusNode: _focusNode,
                              decoration: InputDecoration(
                                  hintText: '-',
                                  hintStyle: TextStyle(
                                      fontSize: _height * 0.02,
                                      color:
                                          Color.fromARGB(255, 135, 201, 255)),
                                  border: InputBorder.none),
                              style: TextStyle(
                                  fontSize: _height * 0.02,
                                  color: Color.fromARGB(255, 135, 201, 255)),
                              textAlign: TextAlign.center,
                              //  keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(width: _width * 0.4),
                  Container(
                    child: Text(
                      'เพศ $sex , อายุ: $age ปี',
                      style: style,
                    ),
                  ),
                  Container(width: _width * 0.05),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                      child: Row(
                        children: [
                          Container(
                            child: Text('Staff :', style: style_white),
                          ),
                          Container(
                            width: _width * 0.04,
                            decoration: boxDecoration_white,
                            child: TextField(
                              controller: _provider.staff,
                              decoration: InputDecoration(
                                  hintText: '-',
                                  hintStyle: TextStyle(
                                      fontSize: _height * 0.02,
                                      color: Colors.white),
                                  border: InputBorder.none),
                              style: TextStyle(
                                  fontSize: _height * 0.02,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                            ),
                            // Text('-', style: style),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          child: Row(children: [
            Container(
              decoration: boxDecoration2,
              width: _width * 0.325,
              child: Container(
                child: Column(
                  children: [
                    Container(
                      child: Column(children: [
                        Container(
                          child: Text(
                            'SYS/DIA',
                            style: TextStyle(
                                fontSize: _height * 0.02, color: Colors.orange),
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: _width * 0.1,
                                child: TextField(
                                  controller: _provider.sys,
                                  decoration: InputDecoration(
                                      hintText: '-',
                                      hintStyle: TextStyle(
                                          fontSize: _height * 0.06,
                                          color: Colors.orange),
                                      border: InputBorder.none),
                                  style: TextStyle(
                                      fontSize: _height * 0.06,
                                      color: Colors.orange),
                                  textAlign: TextAlign.end,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              Text('/',
                                  style: TextStyle(
                                      fontSize: _height * 0.06,
                                      color: Colors.orange)),
                              Container(
                                width: _width * 0.1,
                                child: TextField(
                                  controller: _provider.dia,
                                  decoration: InputDecoration(
                                      hintText: '-',
                                      hintStyle: TextStyle(
                                          fontSize: _height * 0.06,
                                          color: Colors.orange),
                                      border: InputBorder.none),
                                  style: TextStyle(
                                      fontSize: _height * 0.06,
                                      color: Colors.orange),
                                  textAlign: TextAlign.start,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Text(
                            '(-)mmHg',
                            style: TextStyle(
                                fontSize: _height * 0.02, color: Colors.orange),
                          ),
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: _width * 0.325,
                        height: _height * 0.13,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Color.fromARGB(255, 15, 36, 68),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green),
                                onPressed: () {},
                                child: Text('Start')),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue),
                                onPressed: () {},
                                child: Text('Auto')),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    backgroundColor: Colors.amber),
                                onPressed: () {},
                                child: Text('Stop'))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: _height * 0.055)
                  ],
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                child: Row(
                  children: [
                    Column(
                      children: [
                        BoxdataInput(
                          boxDecoration: boxDecoration2,
                          textEditingController: _provider.pulse,
                          h: _height * 0.2,
                          w: _width * 0.25,
                          string_end: 'bpm ',
                          string_start: ' Pulse ',
                          styleinput: TextStyle(
                              fontSize: _height * 0.06, color: Colors.blue),
                          styletext: TextStyle(
                              color: Colors.blue, fontSize: _height * 0.018),
                        ),
                        BoxdataInput(
                          boxDecoration: boxDecoration2,
                          textEditingController: _provider.bpm,
                          h: _height * 0.2,
                          w: _width * 0.25,
                          string_end: '/min ',
                          string_start: ' bpm ',
                          styleinput: TextStyle(
                              fontSize: _height * 0.06, color: Colors.yellow),
                          styletext: TextStyle(
                              color: Colors.yellow, fontSize: _height * 0.018),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        BoxdataInput(
                          boxDecoration: boxDecoration2,
                          textEditingController: _provider.spo2,
                          h: _height * 0.2,
                          w: _width * 0.25,
                          string_end: '% ',
                          string_start: ' Spo2 ',
                          styleinput: TextStyle(
                              fontSize: _height * 0.06, color: Colors.blue),
                          styletext: TextStyle(
                              color: Colors.blue, fontSize: _height * 0.018),
                        ),
                        BoxdataInput(
                          boxDecoration: boxDecoration2,
                          textEditingController: _provider.temp,
                          h: _height * 0.2,
                          w: _width * 0.25,
                          string_end: 'c ',
                          string_start: ' Temp ',
                          styleinput: TextStyle(
                              fontSize: _height * 0.06, color: Colors.green),
                          styletext: TextStyle(
                              color: Colors.green, fontSize: _height * 0.018),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: boxDecoration2,
                          width: _width * 0.17,
                          // height: _height * 0.2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    ' Score ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: _height * 0.018),
                                  ),
                                  Text(
                                    ' ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: _height * 0.018),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: _width * 0.4,
                                  height: _height * 0.08,
                                  child: StreamBuilder<String>(
                                    stream: _provider.getScore(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        seve_score = snapshot.data;
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text('${snapshot.data}',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 135, 201, 255),
                                                    fontSize: _height * 0.05)),
                                          ],
                                        );
                                      } else {
                                        return Text('-', style: style);
                                      }
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: _height * 0.05,
                              )
                            ],
                          ),
                        ),
                        Stack(
                          children: [
                            Positioned(
                              child: Container(
                                decoration: boxDecoration2,
                                width: _width * 0.17,
                                height: _height * 0.18,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          ' Select ',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: _height * 0.018),
                                        ),
                                        Text(
                                          '  ',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: _height * 0.018),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                        controller: _provider.select,
                                        style: TextStyle(
                                            fontSize: _height * 0.04,
                                            color: Colors.white),
                                        decoration: InputDecoration(
                                            hintText: '-',
                                            hintStyle: TextStyle(
                                                fontSize: _height * 0.04,
                                                color: Colors.white),
                                            border: InputBorder.none),
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                    SizedBox(
                                      height: _height * 0.05,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                                child: Container(
                              width: _width * 0.17,
                              color: Color.fromARGB(0, 255, 255, 255),
                              child: Center(
                                  child: GestureDetector(
                                child: Container(
                                    width: _width * 0.15,
                                    height: _height * 0.15,
                                    color: Color.fromARGB(0, 255, 255, 255)),
                                onTap: () {
                                  popUp(selects, _provider.select, 'Select');
                                },
                              )),
                            )),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ]),
        ),
        Container(
          child: Stack(
            children: [
              Positioned(
                child: Row(children: [
                  GestureDetector(
                    child: Container(
                      decoration: boxDecoration3,
                      width: _width * 0.17,
                      // height: _height * 0.19,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ' Type ',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: _height * 0.018),
                              ),
                              Text(
                                '  ',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: _height * 0.018),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(.0),
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: '-',
                                  hintStyle: TextStyle(
                                      fontSize: _height * 0.04,
                                      color: Colors.white),
                                  border: InputBorder.none),
                              controller: _provider.type,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: _height * 0.04,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: _height * 0.05,
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      popUp(selects, _provider.type, 'Type');
                    },
                  ),
                  BoxdataInput(
                    boxDecoration: boxDecoration3,
                    textEditingController: _provider.weight,
                    h: _height * 0.19,
                    w: _width * 0.17,
                    string_end: ' ',
                    string_start: ' Weight ',
                    styleinput: TextStyle(
                        fontSize: _height * 0.04, color: Colors.white),
                    styletext: TextStyle(
                        color: Colors.grey, fontSize: _height * 0.018),
                  ),
                  BoxdataInput(
                    boxDecoration: boxDecoration3,
                    textEditingController: _provider.hright,
                    h: _height * 0.19,
                    w: _width * 0.17,
                    string_end: ' ',
                    string_start: ' Hright ',
                    styleinput: TextStyle(
                        fontSize: _height * 0.04, color: Colors.white),
                    styletext: TextStyle(
                        color: Colors.grey, fontSize: _height * 0.018),
                  ),
                  BoxdataInput(
                    boxDecoration: boxDecoration3,
                    textEditingController: _provider.bmi,
                    h: _height * 0.19,
                    w: _width * 0.17,
                    string_end: ' ',
                    string_start: ' BMI ',
                    styleinput: TextStyle(
                        fontSize: _height * 0.04, color: Colors.white),
                    styletext: TextStyle(
                        color: Colors.grey, fontSize: _height * 0.018),
                  ),
                ]),
              ),
              Positioned(
                  child: Container(
                width: _width * 0.17,
                height: _height * 0.19,
                color: Color.fromARGB(0, 255, 255, 255),
                child: Center(
                    child: GestureDetector(
                  child: Container(
                      width: _width * 0.15,
                      height: _height * 0.15,
                      color: Color.fromARGB(0, 255, 255, 255)),
                  onTap: () {
                    popUp(types, _provider.type, 'Type');
                  },
                )),
              )),
            ],
          ),
        ),
        Container(
          height: _height * 0.15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    child: Center(
                      child: Text(
                        'Log',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: _height * 0.05,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: _height * 0.1,
                        width: _width * 0.15,
                        child: Center(
                          child: Text(
                            'ยกเลิก',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: _height * 0.05,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //  initSerialCommunication();
                      },
                      child: Container(
                        height: _height * 0.1,
                        width: _width * 0.15,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 61, 151, 64),
                            borderRadius: BorderRadius.circular(4)),
                        child: Center(
                          child: Text(
                            'ส่งข้อมูล',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: _height * 0.05,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _provider.save_off_line(seve_score);
                        Timer(Duration(seconds: 1), () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                      child: Text(
                                    'บันทึกเเล้ว',
                                  )))));
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          height: _height * 0.1,
                          width: _width * 0.15,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 223, 226, 51),
                              borderRadius: BorderRadius.circular(4)),
                          child: Center(
                            child: Text(
                              'บันทึก',
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
        ),
        Container(
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => File_Save()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: _height * 0.1,
                    width: _width * 0.15,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 17, 14, 158),
                        borderRadius: BorderRadius.circular(4)),
                    child: Center(
                      child: Text(
                        'เเฟ้ม',
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
    );
  }

  Future popUp(
    List list,
    TextEditingController controller,
    String title,
  ) =>
      showDialog(
        context: context,
        builder: (context) {
          double _height = MediaQuery.of(context).size.height;
          double _width = MediaQuery.of(context).size.width;
          return AlertDialog(
            title: Text('$title${MediaQuery.of(context).size.height}'),
            content: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                children: [
                  MediaQuery.of(context).size.height > 300
                      ? TextField(
                          controller: controller,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.04,
                            color: const Color.fromARGB(255, 12, 76, 128),
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : Container(),
                  SizedBox(height: 16),
                  MediaQuery.of(context).size.height > 210
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  child: Center(
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.08,
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: Center(
                                        child: Text(
                                          list[index],
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.04,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      controller.text = list[index];
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            actions: [
              TextButton(
                onHover: (value) {},
                onLongPress: () {},
                style: TextButton.styleFrom(
                    backgroundColor: Color.fromARGB(50, 0, 0, 0)),
                child: Text(
                  'SUBMIT',
                  style: TextStyle(fontSize: _height * 0.04),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
}

class BoxdataInput extends StatefulWidget {
  String string_end;
  String string_start;
  Decoration boxDecoration;
  TextEditingController textEditingController;
  TextStyle styletext;
  TextStyle styleinput;
  double h;
  double w;
  BoxdataInput({
    super.key,
    required this.boxDecoration,
    required this.textEditingController,
    required this.string_start,
    required this.string_end,
    required this.styletext,
    required this.styleinput,
    required this.h,
    required this.w,
  });

  @override
  State<BoxdataInput> createState() => _BoxdataInputState();
}

class _BoxdataInputState extends State<BoxdataInput> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;

    return Container(
      decoration: widget.boxDecoration,
      width: widget.w,
      //  height: widget.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ' ${widget.string_start} ',
                style: widget.styletext,
              ),
              Text(
                '${widget.string_end} ',
                style: widget.styletext,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: widget.textEditingController,
              decoration: InputDecoration(
                  hintText: '-',
                  hintStyle: widget.styleinput,
                  border: InputBorder.none),
              style: widget.styleinput,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
            ),
          ),
          SizedBox(
            height: _height * 0.04,
          )
        ],
      ),
    );
  }
}
