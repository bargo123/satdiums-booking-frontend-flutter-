class Formater {
  String durationToString(int hour, int min) {
    Duration duration = Duration(hours: hour, minutes: min);
    var pos = duration.toString().lastIndexOf(":");
    return duration.toString().substring(0, pos);
  }
}
