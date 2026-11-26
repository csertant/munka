import 'package:share_plus/share_plus.dart';

import 'utils.dart';

Future<Result<void>> safeShareFile({
  required String filePath,
  required String fileName,
  String? mimeType,
}) async {
  try {
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(filePath, name: fileName, mimeType: mimeType)],
      ),
    );
    return const Result.ok(null);
  } on Exception catch (e) {
    return Result.error(e);
  }
}
