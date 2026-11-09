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

  static const appBarHeight = 56.0;
  static const navigationBarHeight = 72.0;

  static const iconSizeLarge = 25.0;
  static const iconSizeMedium = 20.0;
  static const iconSizeSmall = 15.0;

  static const avatarSizeExtraLarge = 150.0;
  static const avatarSizeLarge = 100.0;
  static const avatarSizeMedium = 50.0;
  static const avatarSizeSmall = 30.0;

  static const paddingExtraLarge = 30.0;
  static const paddingLarge = 20.0;
  static const paddingMedium = 10.0;
  static const paddingSmall = 5.0;
  static const paddingExtraSmall = 2.5;

  static const borderRadiusFull = 999.0;
  static const borderRadiusLarge = 20.0;
  static const borderRadiusMedium = 10.0;
  static const borderRadiusSmall = 5.0;

  static const borderWidth = 1.0;

  double get iconSizeDefault;
  double get avatarSizeDefault;

  static const AppDimensions mobile = _AppDimensionsMobile();
  static const AppDimensions tablet = _AppDimensionsTablet();
  static const AppDimensions desktop = _AppDimensionsDesktop();
}

/// Mobile dimensions
final class _AppDimensionsMobile extends AppDimensions {
  const _AppDimensionsMobile();

  @override
  double get iconSizeDefault => AppDimensions.iconSizeMedium;

  @override
  double get avatarSizeDefault => AppDimensions.avatarSizeLarge;
}

/// Tablet dimensions
final class _AppDimensionsTablet extends AppDimensions {
  const _AppDimensionsTablet();

  @override
  double get iconSizeDefault => AppDimensions.iconSizeLarge;

  @override
  double get avatarSizeDefault => AppDimensions.avatarSizeLarge;
}

/// Desktop dimensions
final class _AppDimensionsDesktop extends AppDimensions {
  const _AppDimensionsDesktop();

  @override
  double get iconSizeDefault => AppDimensions.iconSizeLarge;

  @override
  double get avatarSizeDefault => AppDimensions.avatarSizeExtraLarge;
}
