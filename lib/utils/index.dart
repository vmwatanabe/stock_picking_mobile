bool stringMatches(String value, String match) {
  return value.toUpperCase().contains(match.toUpperCase());
}

double getValueFromMoneyMask(String value) {
  String clear = value
      .replaceAll('.', '')
      .replaceAll(',', '.')
      .replaceAll(RegExp(r'[^0-9|^\.]'), '');

  return double.parse(clear);
}

bool isDateValid(String? value) {
  if (value == null) return false;

  List<String> splited = value.split('/');

  if (splited.length != 3) return false;

  DateTime? thisDate = DateTime.tryParse(splited[2] + splited[1] + splited[0]);

  return thisDate != null;
}

DateTime? getDateFromValue(String? value) {
  if (value == null) return null;

  List<String> splited = value.split('/');

  if (splited.length != 3) return null;

  DateTime? thisDate = DateTime.tryParse(splited[2] + splited[1] + splited[0]);

  return thisDate;
}
