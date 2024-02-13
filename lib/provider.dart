import 'dart:async';
import 'dart:io';
import 'package:sembast/sembast.dart';
import 'package:flutter/cupertino.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_opd/functionScore/bpm.dart';
import 'package:smart_opd/functionScore/dbp.dart';
import 'package:smart_opd/functionScore/pr.dart';
import 'package:smart_opd/functionScore/sbp.dart';
import 'package:smart_opd/functionScore/spo2.dart';
import 'package:smart_opd/functionScore/temp.dart';

class DataProvider with ChangeNotifier {
  TextEditingController temp = TextEditingController();
  TextEditingController select = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController sys = TextEditingController();
  TextEditingController dia = TextEditingController();
  TextEditingController pulse = TextEditingController();
  TextEditingController spo2 = TextEditingController();
  TextEditingController bpm = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController hright = TextEditingController();
  TextEditingController bmi = TextEditingController();
  TextEditingController hn = TextEditingController();
  TextEditingController staff = TextEditingController();
  // TextEditingController score = TextEditingController();
  StreamController<String> score = StreamController<String>();

  void streamScore() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      double numscore = 0;
      if (weight.text != null &&
          hright.text != null &&
          weight.text != '' &&
          hright.text != '') {
        bmi.text =
            calculateBMI(double.parse(weight.text), double.parse(hright.text))
                .toStringAsFixed(2);
        // if (bmi < 18.5) {
        //   return 'น้ำหนักน้อย / ผอม';
        // } else if (bmi >= 18.5 && bmi < 24.9) {
        //   return 'น้ำหนักปกติ';
        // } else if (bmi >= 25 && bmi < 29.9) {
        //   return 'น้ำหนักเกิน / โรคอ้วนระดับ 1';
        // } else if (bmi >= 30 && bmi < 34.9) {
        //   return 'โรคอ้วนระดับ 2';
        // } else if (bmi >= 35 && bmi < 39.9) {
        //   return 'โรคอ้วนระดับ 3';
        // } else {
        //   return 'โรคอ้วนขั้นสูงสุด';
        // }
      }
      numscore += bpmfunction(bpm.text, select.text);
      numscore += sop2function(spo2.text, select.text);
      numscore += tempfunction(temp.text, select.text);
      numscore += sbpfunction(sys.text, select.text);
      numscore += prfunction(pulse.text, select.text);
      numscore += dbpfunction(dia.text, select.text);
      score.add("$numscore");
    });
  }

  double calculateBMI(double weight, double height) {
    return weight / ((height / 100) * (height / 100));
  }

  Stream<String> getScore() {
    return score.stream;
  }

  void save_off_line(String? seve_score) async {
    String time;
    DateTime dateTime = DateTime.parse('0000-00-00 00:00');
    dateTime = DateTime.now();
    time = "${dateTime.day}/" +
        "${dateTime.month}/" +
        "${dateTime.year}, " +
        "${dateTime.hour}:" +
        "${dateTime.minute.toString().padLeft(2, '0')}:" +
        "${dateTime.second.toString().padLeft(2, '0')}";
    Map data = {
      'sys': sys.text,
      'dia': dia.text,
      'pulse': pulse.text,
      'spo2': spo2.text,
      'bpm': bpm.text,
      'temp': temp.text,
      'weight': weight.text,
      'hright': hright.text,
      'bmi': bmi.text,
      'hn': hn.text,
      'staff': staff.text,
      'time': time,
      'name': '',
      'sex': '',
      'score': ' $seve_score',
      'select': select.text,
      'type': type.text,

      // 'score': score.toString(),
    };
    Directory app = await getApplicationDocumentsDirectory();
    String dbpart = app.path + 'opd.db';
    final db = await databaseFactoryIo.openDatabase(dbpart);
    final store = intMapStoreFactory.store('data');
    var snapshot = await store.find(db);
    final key = await store.add(db, {
      'data': data,
    });

    await db.close();

    sys.text = '';
    dia.text = '';
    pulse.text = '';
    spo2.text = '';
    bpm.text = '';
    temp.text = '';
    weight.text = '';
    hright.text = '';
    bmi.text = '';
    hn.text = '';
    staff.text = '';
  }

  Future<void> delete_data(String key) async {
    Directory app = await getApplicationDocumentsDirectory();
    String dbpart = app.path + 'opd.db';
    final db = await databaseFactoryIo.openDatabase(dbpart);
    final store = intMapStoreFactory.store('data');
    await store.delete(
      db,
      finder: Finder(
          filter: Filter.or([
        Filter.byKey(double.parse(key)),
      ])),
    );
  }
}
