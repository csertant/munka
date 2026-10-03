import 'package:drift/drift.dart';
import 'package:flutter/services.dart';

class AppError implements Exception {
  AppError(this.message, {this.cause});

  factory AppError.fromError(Exception error) {
    if (error is AppError) {
      return error;
    } else if (error is StateError) {
      return DatabaseError('Row cardinality violated', cause: error);
    } else if (error is FormatException || error is InvalidDataException) {
      return DatabaseError('Data format invalid', cause: error);
    } else if (error is DriftWrappedException) {
      return DatabaseError('Database operation failed', cause: error);
    } else if (error is PlatformException) {
      return PlatformError('Platform-specific error occurred', cause: error);
    } else {
      return AppError('Unexpected error occurred', cause: error);
    }
  }

  final String message;
  final Object? cause;

  @override
  String toString() => 'AppError: $message';
}

class DatabaseError extends AppError {
  DatabaseError(super.message, {super.cause});

  @override
  String toString() => 'DatabaseError: $message';
}

class ValidationError extends AppError {
  ValidationError(super.message, {super.cause});

  @override
  String toString() => 'ValidationError: $message';
}

class PlatformError extends AppError {
  PlatformError(super.message, {super.cause});

  @override
  String toString() => 'PlatformError: $message';
}
