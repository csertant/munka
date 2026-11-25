import 'dart:async';

import 'package:material_ui/material_ui.dart';

import '../../data/database/database.dart';
import '../../data/managers/session/session_manager.dart';
import '../../data/repositories/timeentries/timeentries_repository.dart';
import '../../domain/models/models.dart';
import '../../utils/utils.dart';

class StatsViewModel extends ChangeNotifier {
  StatsViewModel({
    required this._sessionManager,
    required this._timeEntriesRepository,
    this._granularity = StatsGranularity.week,
  }) {
    load = Command0(_load);

    _sessionManager.addListener(_onSessionChanged);
    _timeEntriesSubscription = _timeEntriesRepository
        .watchRecentEntries(profileId: _sessionManager.profileId!)
        .listen(_onTimeEntriesChanged);

    unawaited(load.execute());
  }

  final SessionManager _sessionManager;
  final TimeEntriesRepository _timeEntriesRepository;
  StreamSubscription<List<TimeEntry>>? _timeEntriesSubscription;

  List<TimeEntry> _timeEntries = [];
  StatsGranularity _granularity;
  int _pageOffset = 0;

  late Command0<void> load;

  List<TimeEntry> get timeEntries => _timeEntries;
  StatsGranularity get granularity => _granularity;
  int get pageOffset => _pageOffset;
  bool get canGoForward => _pageOffset < 0;

  Future<Result<void>> _load() async {
    try {
      final profileId = _sessionManager.profileId;
      if (profileId == null) {
        return Result.error(NotFoundError('No active session found'));
      } else {
        return const Result.ok(null);
      }
    } finally {
      notifyListeners();
    }
  }

  void setGranularity(StatsGranularity next) {
    if (_granularity == next && _pageOffset == 0) {
      return;
    }
    _granularity = next;
    _pageOffset = 0;
    notifyListeners();
  }

  void stepBackward() {
    _pageOffset -= 1;
    notifyListeners();
  }

  void stepForward() {
    if (_pageOffset >= 0) {
      return;
    }
    _pageOffset += 1;
    notifyListeners();
  }

  String get summaryTitle {
    switch (_granularity) {
      case StatsGranularity.day:
        final now = DateTime.now();
        final day = DateTime(now.year, now.month, now.day + _pageOffset);
        return AppDateFormat.yMMdd.format(day);

      case StatsGranularity.week:
        final range = AppDateUtils.weekRange(_pageOffset);
        return '${AppDateFormat.MMdd.format(range.start)} - '
            '${AppDateFormat.MMdd.format(range.end.subtract(const Duration(days: 1)))}';

      case StatsGranularity.month:
        final range = AppDateUtils.threeMonthRange(_pageOffset);
        return '${AppDateFormat.yMMM.format(range.start)} - '
            '${AppDateFormat.yMMM.format(range.end.subtract(const Duration(days: 1)))}';

      case StatsGranularity.year:
        final range = AppDateUtils.threeYearRange(_pageOffset);
        return '${range.start.year} - ${range.end.year - 1}';
    }
  }

  List<StatsBucket> get buckets {
    switch (_granularity) {
      case StatsGranularity.day:
        final now = DateTime.now();
        final start = DateTime(now.year, now.month, now.day + _pageOffset);
        final end = start.add(const Duration(days: 1));
        final hours = _sumOverlapHours(start, end);
        return [
          StatsBucket(
            index: 0,
            label: AppDateFormat.MMdd.format(start),
            hours: hours,
            start: start,
            end: end,
          ),
        ];

      case StatsGranularity.week:
        final range = AppDateUtils.weekRange(_pageOffset);
        return List.generate(7, (i) {
          final dayStart = range.start.add(Duration(days: i));
          final dayEnd = dayStart.add(const Duration(days: 1));
          return StatsBucket(
            index: i,
            label: AppDateFormat.MMdd.format(dayStart),
            hours: _sumOverlapHours(dayStart, dayEnd),
            start: dayStart,
            end: dayEnd,
          );
        });

      case StatsGranularity.month:
        final range = AppDateUtils.threeMonthRange(_pageOffset);
        return List.generate(3, (i) {
          final month = range.start.month + i;
          final year = range.start.year + ((month - 1) ~/ 12);
          final monthStart = DateTime(year, month);
          final monthEnd = DateTime(year, month + 1);
          return StatsBucket(
            index: i,
            label: AppDateFormat.yMMM.format(monthStart),
            hours: _sumOverlapHours(monthStart, monthEnd),
            start: monthStart,
            end: monthEnd,
          );
        });

      case StatsGranularity.year:
        final range = AppDateUtils.threeYearRange(_pageOffset);
        return List.generate(3, (i) {
          final year = range.start.year + i;
          final yearStart = DateTime(year);
          final yearEnd = DateTime(year + 1);
          return StatsBucket(
            index: i,
            label: year.toString(),
            hours: _sumOverlapHours(yearStart, yearEnd),
            start: yearStart,
            end: yearEnd,
          );
        });
    }
  }

  double get totalHours =>
      buckets.fold(0.0, (sumSoFar, bucket) => sumSoFar + bucket.hours);

  double get maxHours {
    final maxValue = buckets.fold<double>(
      0.0,
      (maxSoFar, bucket) => bucket.hours > maxSoFar ? bucket.hours : maxSoFar,
    );
    return maxValue <= 0 ? 2.0 : maxValue * 1.05;
  }

  double _sumOverlapHours(DateTime windowStart, DateTime windowEnd) {
    final currentTime = DateTime.now();
    var totalMinutes = 0;

    for (final entry in _timeEntries) {
      final entryStart = entry.startedAt.toLocal();
      final entryEnd = (entry.endedAt ?? currentTime).toLocal();
      if (!entryEnd.isAfter(entryStart)) {
        continue;
      }

      final overlapStart = entryStart.isAfter(windowStart)
          ? entryStart
          : windowStart;
      final overlapEnd = entryEnd.isBefore(windowEnd) ? entryEnd : windowEnd;

      if (overlapEnd.isAfter(overlapStart)) {
        totalMinutes += overlapEnd.difference(overlapStart).inMinutes;
      }
    }

    return totalMinutes / 60.0;
  }

  Future<void> _onSessionChanged() async {
    await _timeEntriesSubscription?.cancel();
    _timeEntriesSubscription = _timeEntriesRepository
        .watchRecentEntries(profileId: _sessionManager.profileId!)
        .listen((_) {
          notifyListeners();
        });
    await load.execute();
  }

  void _onTimeEntriesChanged(List<TimeEntry> timeEntries) {
    _timeEntries = timeEntries;
    notifyListeners();
  }

  @override
  Future<void> dispose() async {
    _sessionManager.removeListener(_onSessionChanged);
    await _timeEntriesSubscription?.cancel();
    super.dispose();
  }
}
