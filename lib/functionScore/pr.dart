double prfunction(String pr, String select) {
  double numscore = 0;
  if (pr != null && pr != '') {
    if (select == '15ปีขึ้นไป') {
      if (double.parse(pr) >= 130.00) {
        numscore += 3;
      } else if (double.parse(pr) > 109.00) {
        numscore += 2;
      } else if (double.parse(pr) > 99.00) {
        numscore += 1;
      } else if (double.parse(pr) > 49.00) {
        numscore += 0;
      } else if (double.parse(pr) > 39.00) {
        numscore += 1;
      } else if (double.parse(pr) <= 39.00) {
        numscore += 3;
      }
    } else if (select == 'เด็ก 5-12 ปี') {
      if (double.parse(pr) > 150.00) {
        numscore += 3;
      } else if (double.parse(pr) > 129.00) {
        numscore += 2;
      } else if (double.parse(pr) > 109.00) {
        numscore += 1;
      } else if (double.parse(pr) > 69.00) {
        numscore += 0;
      } else if (double.parse(pr) >= 50.00) {
        numscore += 1;
      } else if (double.parse(pr) < 50.00) {
        numscore += 3;
      }
    } else if (select == 'เด็ก 1-5 ปี') {
      if (double.parse(pr) > 170.00) {
        numscore += 3;
      } else if (double.parse(pr) > 149.00) {
        numscore += 2;
      } else if (double.parse(pr) > 129.00) {
        numscore += 1;
      } else if (double.parse(pr) > 79.00) {
        numscore += 0;
      } else if (double.parse(pr) >= 60.00) {
        numscore += 1;
      } else if (double.parse(pr) < 60.00) {
        numscore += 3;
      }
    } else if (select == 'เด็ก 1 เดือน - 1 ปี') {
      if (double.parse(pr) > 190.00) {
        numscore += 3;
      } else if (double.parse(pr) > 179.00) {
        numscore += 2;
      } else if (double.parse(pr) > 160.00) {
        numscore += 1;
      } else if (double.parse(pr) > 99.00) {
        numscore += 0;
      } else if (double.parse(pr) >= 80.00) {
        numscore += 1;
      } else if (double.parse(pr) < 80.00) {
        numscore += 3;
      }
    } else if (select == '6 สัปดาห์หลังคลอด') {
      if (double.parse(pr) >= 130.00) {
        numscore += 3;
      } else if (double.parse(pr) > 119.00) {
        numscore += 2;
      } else if (double.parse(pr) > 109.00) {
        numscore += 1;
      } else if (double.parse(pr) > 49.00) {
        numscore += 0;
      } else if (double.parse(pr) >= 40.00) {
        numscore += 2;
      } else if (double.parse(pr) < 40.00) {
        numscore += 3;
      }
    }
  } else {
    numscore += 0;
  }
  return numscore;
}
