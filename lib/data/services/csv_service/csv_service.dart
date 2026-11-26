import 'dart:io';

import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';

import '../../../config/csv_service_config.dart';
import '../../../utils/utils.dart';
import '../../database/database.dart';

class CsvService {
  CsvService({CsvServiceConfig? config})
    : _config = config ?? CsvServiceConfig.defaults;

  final CsvServiceConfig _config;

  Future<Result<void>> clearTemporaryCsvFiles() async {
    try {
      final directory = await getTemporaryDirectory();
      final files = directory.listSync();

      for (final file in files) {
        if (file is File && file.path.endsWith('.csv')) {
          await file.delete();
        }
      }
      return const Result.ok(null);
    } on Exception catch (e) {
      return Result.error(AppError.fromError(e));
    }
  }

  Future<Result<void>> exportTimeEntriesToCsv({
    required List<TimeEntry> timeEntries,
  }) async {
    try {
      final rows = [
        ['Id', 'Project', 'Start', 'End', 'Duration (Hours)', 'Notes'],
      ];

      for (final entry in timeEntries) {
        var durationHours = '';
        if (entry.endedAt != null) {
          final minutes = entry.endedAt!.difference(entry.startedAt).inMinutes;
          durationHours = (minutes / 60.0).toStringAsFixed(2);
        }

        rows.add([
          entry.id.toString(),
          entry.project ?? 'null',
          AppDateFormat.yMMddHHmm.format(entry.startedAt),
          if (entry.endedAt != null)
            AppDateFormat.yMMddHHmm.format(entry.endedAt!)
          else
            'null',
          durationHours,
          entry.notes ?? 'null',
        ]);
      }

      final csvString = Csv(
        fieldDelimiter: _config.fieldDelimiter,
        addBom: true,
      ).encode(rows);

      final directory = await getTemporaryDirectory();
      final fileName = _config.fileNameProvider(DateTime.now());
      final file = File('${directory.path}/$fileName');

      await file.writeAsString(csvString);

      return await safeShareFile(
        filePath: file.path,
        fileName: fileName,
        mimeType: _config.mimeType,
      );
    } on Exception catch (e) {
      return Result.error(AppError.fromError(e));
    }
  }
}
