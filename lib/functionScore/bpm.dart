double bpmfunction(String bpm, String select) {
  double numscore = 0;
  if (bpm != null && bpm != '') {
    if (select == '15ปีขึ้นไป') {
      if (double.parse(bpm) >= 36.00) {
        numscore += 3;
      } else if (double.parse(bpm) > 30.00) {
        numscore += 2;
      } else if (double.parse(bpm) > 20.00) {
        numscore += 1;
      } else if (double.parse(bpm) > 10.00) {
        numscore += 0;
      } else if (double.parse(bpm) <= 10.00) {
        numscore += 3;
      }
    } else if (select == 'เด็ก 5-12 ปี') {
      if (double.parse(bpm) > 50.00) {
        numscore += 3;
      } else if (double.parse(bpm) > 39.00) {
        numscore += 2;
      } else if (double.parse(bpm) > 29.00) {
        numscore += 1;
      } else if (double.parse(bpm) > 15.00) {
        numscore += 0;
      } else if (double.parse(bpm) > 9.00) {
        numscore += 1;
      } else if (double.parse(bpm) < 10.00) {
        numscore += 3;
      }
    } else if (select == 'เด็ก 1-5 ปี') {
      if (double.parse(bpm) > 60.00) {
        numscore += 3;
      } else if (double.parse(bpm) > 49.00) {
        numscore += 2;
      } else if (double.parse(bpm) > 39.00) {
        numscore += 1;
      } else if (double.parse(bpm) > 19.00) {
        numscore += 0;
      } else if (double.parse(bpm) >= 15.00) {
        numscore += 1;
      } else if (double.parse(bpm) < 15.00) {
        numscore += 3;
      }
    } else if (select == 'เด็ก 1 เดือน - 1 ปี') {
      if (double.parse(bpm) > 50.00) {
        numscore += 2;
      } else if (double.parse(bpm) > 40.00) {
        numscore += 1;
      } else if (double.parse(bpm) >= 30.00) {
        numscore += 0;
      } else if (double.parse(bpm) < 30.00) {
        numscore += 3;
      }
    } else if (select == '6 สัปดาห์หลังคลอด') {
      if (double.parse(bpm) >= 30.00) {
        numscore += 3;
      } else if (double.parse(bpm) > 24.00) {
        numscore += 2;
      } else if (double.parse(bpm) > 20.00) {
        numscore += 1;
      } else if (double.parse(bpm) > 10.00) {
        numscore += 0;
      } else if (double.parse(bpm) <= 10.00) {
        numscore += 3;
      }
    }
  } else {
    numscore += 0;
  }
  return numscore;
}
