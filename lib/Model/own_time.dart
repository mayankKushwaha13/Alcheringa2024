class OwnTime {
  int date = 0;
  int hours = 0;
  int min = 0;

  OwnTime({
    required this.date,
    required this.hours,
    required this.min,
  });

  factory OwnTime.fromMap(Map<String, dynamic> data) {
    return OwnTime(
      date: data['date'],
      hours: data['hours'],
      min: data['min'],
    );
  }

  // Convert OwnTime to total minutes (for easier comparison)
  int toMinutes() {
    return (date * 24 * 60) + (hours * 60) + min;
  }

  // Time conversion functions
  int convertToMinutes(OwnTime ownTime) {
    return (ownTime.date * 24 * 60) + (ownTime.hours * 60) + ownTime.min;
  }

  OwnTime convertToOwnTime(int minutes) {
    int days = minutes ~/ (24 * 60);
    int hours = (minutes % (24 * 60)) ~/ 60;
    int mins = minutes % 60;
    return OwnTime(date: days, hours: hours, min: mins);
  }
}
