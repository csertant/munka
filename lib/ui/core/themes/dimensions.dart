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

  static const iconSizeLarge = 28.0;
  static const iconSizeMedium = 24.0;
  static const iconSizeSmall = 20.0;

  static const paddingLarge = 32.0;
  static const paddingMedium = 16.0;
  static const paddingSmall = 8.0;
  static const paddingExtraSmall = 4.0;

  double get iconSizeDefault;

  static const AppDimensions mobile = _AppDimensionsMobile();
  static const AppDimensions tablet = _AppDimensionsTablet();
  static const AppDimensions desktop = _AppDimensionsDesktop();
}

/// Mobile dimensions
final class _AppDimensionsMobile extends AppDimensions {
  const _AppDimensionsMobile();

  @override
  double get iconSizeDefault => AppDimensions.iconSizeMedium;
}

/// Tablet dimensions
final class _AppDimensionsTablet extends AppDimensions {
  const _AppDimensionsTablet();

  @override
  double get iconSizeDefault => AppDimensions.iconSizeLarge;
}

/// Desktop dimensions
final class _AppDimensionsDesktop extends AppDimensions {
  const _AppDimensionsDesktop();

  @override
  double get iconSizeDefault => AppDimensions.iconSizeLarge;
}
