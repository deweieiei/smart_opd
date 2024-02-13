double sbpfunction(String sbp, String select) {
  double numscore = 0;
  if (sbp != null && sbp != '') {
    if (select == '15ปีขึ้นไป') {
      if (double.parse(sbp) >= 200.00) {
        numscore += 2;
      } else if (double.parse(sbp) > 99.00) {
        numscore += 0;
      } else if (double.parse(sbp) > 89.00) {
        numscore += 1;
      } else if (double.parse(sbp) <= 89.00) {
        numscore += 3;
      }
    } else if (select == 'เด็ก 5-12 ปี') {
      if (double.parse(sbp) > 140.00) {
        numscore += 3;
      } else if (double.parse(sbp) > 129.00) {
        numscore += 2;
      } else if (double.parse(sbp) > 119.00) {
        numscore += 1;
      } else if (double.parse(sbp) > 89.00) {
        numscore += 0;
      } else if (double.parse(sbp) >= 80.00) {
        numscore += 1;
      } else if (double.parse(sbp) < 80.00) {
        numscore += 3;
      }
    } else if (select == 'เด็ก 1-5 ปี') {
      if (double.parse(sbp) > 130.00) {
        numscore += 3;
      } else if (double.parse(sbp) > 119.00) {
        numscore += 2;
      } else if (double.parse(sbp) > 109.00) {
        numscore += 1;
      } else if (double.parse(sbp) > 89.00) {
        numscore += 0;
      } else if (double.parse(sbp) > 79.00) {
        numscore += 1;
      } else if (double.parse(sbp) >= 70.00) {
        numscore += 2;
      } else if (double.parse(sbp) < 70.00) {
        numscore += 3;
      }
    } else if (select == 'เด็ก 1 เดือน - 1 ปี') {
      if (double.parse(sbp) > 110.00) {
        numscore += 3;
      } else if (double.parse(sbp) > 99.00) {
        numscore += 2;
      } else if (double.parse(sbp) > 79.00) {
        numscore += 1;
      } else if (double.parse(sbp) > 69.00) {
        numscore += 0;
      } else if (double.parse(sbp) >= 60.00) {
        numscore += 1;
      } else if (double.parse(sbp) < 60.00) {
        numscore += 2;
      }
    } else if (select == '6 สัปดาห์หลังคลอด') {
      if (double.parse(sbp) >= 160.00) {
        numscore += 3;
      } else if (double.parse(sbp) > 149.00) {
        numscore += 2;
      } else if (double.parse(sbp) > 139.00) {
        numscore += 1;
      } else if (double.parse(sbp) > 89.00) {
        numscore += 0;
      } else if (double.parse(sbp) >= 80.00) {
        numscore += 2;
      } else if (double.parse(sbp) < 80.00) {
        numscore += 3;
      }
    }
  } else {
    numscore += 0;
  }
  return numscore;
}
