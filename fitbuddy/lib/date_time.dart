String todaysDateYYYYMMDD() {
  var dateTimeObject = DateTime.now();

  String year = dateTimeObject.year.toString();
  String month = dateTimeObject.month.toString();
  if (month.length == 1) {
    month = "0" + month;
  }
  String day = dateTimeObject.day.toString();
  if (day.length == 1) {
    day = "0" + day;
  }
  String yyyymmdd = year + month + day;
  return yyyymmdd;
}

DateTime createDateTimeObject(String yyyymmdd) {
  String year = yyyymmdd.substring(0, 4);
  String month = yyyymmdd.substring(4, 6);
  String day = yyyymmdd.substring(6, 8);
  DateTime dateTimeObject = DateTime(int.parse(year), int.parse(month),
      int.parse(day));
  return dateTimeObject;
}

String convertDateTimetoYYYYMMDD(DateTime dateTime){
  String year = dateTime.year.toString();
  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = "0" + month;
  }
  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = "0" + day;
  }
  String yyyymmdd = year + month + day;
  return yyyymmdd;
}
