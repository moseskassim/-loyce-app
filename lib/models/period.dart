class Period {
  DateTime startDate;
  DateTime? endDate;
  int? duration; 

  Period({
    required this.startDate,
    this.endDate,
    this.duration,
  });

  int get actualDuration => endDate != null ? endDate!.difference(startDate).inDays + 1 : duration ?? 5;
}
