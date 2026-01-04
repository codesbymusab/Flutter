String getCurrentMonthName(int value) {
  String text = '';

  switch ((value.toInt() % 12)) {
    case 1:
      text = 'JAN';
      break;
    case 2:
      text = 'FEB';
      break;
    case 3:
      text = 'MAR';
      break;
    case 4:
      text = 'APR';
      break;
    case 5:
      text = 'MAY';
      break;
    case 6:
      text = 'JUN';
      break;
    case 7:
      text = 'JUL';
      break;
    case 8:
      text = 'AUG';
      break;
    case 9:
      text = 'SEP';
      break;
    case 10:
      text = 'OCT';
      break;
    case 11:
      text = 'NOV';
      break;
    case 0:
      text = 'DEC';
      break;
    default:
      text = '';
  }
  return text;
}
