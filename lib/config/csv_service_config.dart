import '../utils/datetime.dart';

class CsvServiceConfig {
  const CsvServiceConfig({
    required this.fieldDelimiter,
    required this.fileNameProvider,
    required this.mimeType,
    required this.schemaVersion,
  });

  static final defaults = CsvServiceConfig(
    fieldDelimiter: ';',
    fileNameProvider: (timestamp) =>
        'munka_${AppDateFormat.yMMddHHmm.format(timestamp)}.csv',
    mimeType: 'text/csv',
    schemaVersion: 1,
  );

  final String fieldDelimiter;
  final String Function(DateTime) fileNameProvider;
  final String mimeType;
  final int schemaVersion;
}
