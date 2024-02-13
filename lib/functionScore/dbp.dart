double dbpfunction(String sbp, String select) {
  double numscore = 0;
  if (sbp != null && sbp != '') {
    if (select == '15ปีขึ้นไป') {
    } else if (select == 'เด็ก 5-12 ปี') {
    } else if (select == 'เด็ก 1-5 ปี') {
    } else if (select == 'เด็ก 1 เดือน - 1 ปี') {
    } else if (select == '6 สัปดาห์หลังคลอด') {
      if (double.parse(sbp) >= 110.00) {
        numscore += 3;
      } else if (double.parse(sbp) > 99.00) {
        numscore += 2;
      } else if (double.parse(sbp) > 89.00) {
        numscore += 1;
      } else if (double.parse(sbp) > 39.00) {
        numscore += 0;
      } else if (double.parse(sbp) >= 39.00) {
        numscore += 3;
      }
    }
  } else {
    numscore += 0;
  }
  return numscore;
}
