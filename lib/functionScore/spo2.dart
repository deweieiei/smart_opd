double sop2function(String spo2, String select) {
  double numscore = 0;
  if (spo2 != null && spo2 != '') {
    if (select == '15ปีขึ้นไป') {
      if (double.parse(spo2) >= 93.00) {
        numscore += 0;
      } else if (double.parse(spo2) > 89.00) {
        numscore += 1;
      } else if (double.parse(spo2) > 84.00) {
        numscore += 2;
      } else if (double.parse(spo2) <= 84.00) {
        numscore += 3;
      }
    } else if (select == 'เด็ก 5-12 ปี') {
      if (double.parse(spo2) >= 94.00) {
        numscore += 0;
      } else if (double.parse(spo2) > 89.00) {
        numscore += 1;
      } else if (double.parse(spo2) > 84.00) {
        numscore += 2;
      } else if (double.parse(spo2) <= 84.00) {
        numscore += 3;
      }
    } else if (select == 'เด็ก 1-5 ปี') {
      if (double.parse(spo2) >= 94.00) {
        numscore += 0;
      } else if (double.parse(spo2) > 89.00) {
        numscore += 1;
      } else if (double.parse(spo2) > 85.00) {
        numscore += 2;
      } else if (double.parse(spo2) <= 85.00) {
        numscore += 3;
      }
    } else if (select == 'เด็ก 1 เดือน - 1 ปี') {
      if (double.parse(spo2) >= 95.00) {
        numscore += 0;
      } else if (double.parse(spo2) > 84.00) {
        numscore += 1;
      } else if (double.parse(spo2) >= 80.00) {
        numscore += 2;
      } else if (double.parse(spo2) < 80.00) {
        numscore += 3;
      }
    } else if (select == '6 สัปดาห์หลังคลอด') {
      if (double.parse(spo2) >= 95.00) {
        numscore += 0;
      } else if (double.parse(spo2) > 89.00) {
        numscore += 1;
      } else if (double.parse(spo2) <= 89.00) {
        numscore += 3;
      }
    }
  } else {
    numscore += 0;
  }
  return numscore;
}
