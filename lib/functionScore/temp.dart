double tempfunction(String temp, String select) {
  double numscore = 0;

  if (temp != null && temp != "") {
    if (select == '15ปีขึ้นไป') {
      if (double.parse(temp) >= 39.00) {
        numscore += 2;
      } else if (double.parse(temp) > 37.9) {
        numscore += 1;
      } else if (double.parse(temp) > 35.9) {
        numscore += 0;
      } else if (double.parse(temp) > 34.9) {
        numscore += 1;
      } else if (double.parse(temp) > 33.9) {
        numscore += 2;
      } else if (double.parse(temp) <= 33.9) {
        numscore += 3;
      }
    } else if (select == 'เด็ก 5-12 ปี') {
      if (double.parse(temp) > 38.50) {
        numscore += 1;
      } else if (double.parse(temp) >= 36.0) {
        numscore += 0;
      } else if (double.parse(temp) < 36.0) {
        numscore += 1;
      }
    } else if (select == 'เด็ก 1-5 ปี') {
      if (double.parse(temp) > 38.50) {
        numscore += 1;
      } else if (double.parse(temp) >= 36.0) {
        numscore += 0;
      } else if (double.parse(temp) < 36.0) {
        numscore += 1;
      }
    } else if (select == 'เด็ก 1 เดือน - 1 ปี') {
      if (double.parse(temp) > 38.50) {
        numscore += 1;
      } else if (double.parse(temp) >= 36.0) {
        numscore += 0;
      } else if (double.parse(temp) < 36.0) {
        numscore += 1;
      }
    } else if (select == '6 สัปดาห์หลังคลอด') {
      if (double.parse(temp) >= 40.00) {
        numscore += 3;
      } else if (double.parse(temp) > 38.9) {
        numscore += 2;
      } else if (double.parse(temp) > 37.9) {
        numscore += 1;
      } else if (double.parse(temp) > 35.9) {
        numscore += 0;
      } else if (double.parse(temp) > 34.9) {
        numscore += 1;
      } else if (double.parse(temp) <= 34.9) {
        numscore += 3;
      }
    }
  }
  return numscore;
}
