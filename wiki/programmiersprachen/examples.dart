void main() {
  var datum = DateTime.now();
  var nextMonth = datum.month == 12 ? 1 : datum.month + 1; // Dezember => Januar, sonst + 1
  var datumErsterFolgemonat = DateTime(datum.year, datum.month + 1, 1);
  var datumLetzter = datumErsterFolgemonat.subtract(Duration(days: 1)); // 1 Tag abgezogen
}
