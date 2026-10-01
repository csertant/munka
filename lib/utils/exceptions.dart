class AppError implements Exception {
  AppError(this.message, {this.cause});

  factory AppError.fromError(Exception error) {
    if (error is AppError) {
      return error;
    } else {
      return AppError('Unexpected error occurred', cause: error);
    }
  }

  final String message;
  final Object? cause;

  @override
  String toString() => 'AppError: $message';
}
