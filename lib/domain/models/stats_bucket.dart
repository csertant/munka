enum StatsGranularity { day, week, month, year }

class StatsBucket {
  const StatsBucket({
    required this.index,
    required this.label,
    required this.hours,
    required this.start,
    required this.end,
  });

  final int index;
  final String label;
  final double hours;
  final DateTime start;
  final DateTime end;
}
