import 'package:flutter/widgets.dart';

abstract final class AppDimensions {
  const AppDimensions();

  /// Get dimensions definition based on screen size
  factory AppDimensions.of(BuildContext context) =>
      switch (MediaQuery.sizeOf(context).width) {
        < mobileMaxWidth => mobile,
        < tabletMaxWidth => tablet,
        _ => desktop,
      };

  static const tabletMaxWidth = 840.0;
  static const mobileMaxWidth = 600.0;

  static const AppDimensions mobile = _AppDimensionsMobile();
  static const AppDimensions tablet = _AppDimensionsTablet();
  static const AppDimensions desktop = _AppDimensionsDesktop();
}

/// Mobile dimensions
final class _AppDimensionsMobile extends AppDimensions {
  const _AppDimensionsMobile();
}

/// Tablet dimensions
final class _AppDimensionsTablet extends AppDimensions {
  const _AppDimensionsTablet();
}

/// Desktop dimensions
final class _AppDimensionsDesktop extends AppDimensions {
  const _AppDimensionsDesktop();
}
