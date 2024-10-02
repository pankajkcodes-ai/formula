import "package:flutter/material.dart";

TextTheme createTextTheme(
    BuildContext context, String bodyFontFamily, String displayFontFamily) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;

  // Create TextStyles with the custom font families
  TextTheme bodyTextTheme = baseTextTheme.copyWith(
    bodyLarge: baseTextTheme.bodyLarge?.copyWith(fontFamily: bodyFontFamily),
    bodyMedium: baseTextTheme.bodyMedium?.copyWith(fontFamily: bodyFontFamily),
    bodySmall: baseTextTheme.bodySmall?.copyWith(fontFamily: bodyFontFamily),
    labelLarge: baseTextTheme.labelLarge?.copyWith(fontFamily: bodyFontFamily),
    labelMedium: baseTextTheme.labelMedium?.copyWith(fontFamily: bodyFontFamily),
    labelSmall: baseTextTheme.labelSmall?.copyWith(fontFamily: bodyFontFamily),
  );

  TextTheme displayTextTheme = baseTextTheme.copyWith(
    headlineLarge: baseTextTheme.headlineLarge?.copyWith(fontFamily: displayFontFamily),
    headlineMedium: baseTextTheme.headlineMedium?.copyWith(fontFamily: displayFontFamily),
    headlineSmall: baseTextTheme.headlineSmall?.copyWith(fontFamily: displayFontFamily),
    titleLarge: baseTextTheme.titleLarge?.copyWith(fontFamily: displayFontFamily),
    titleMedium: baseTextTheme.titleMedium?.copyWith(fontFamily: displayFontFamily),
    titleSmall: baseTextTheme.titleSmall?.copyWith(fontFamily: displayFontFamily),
  );

  // Merge the body and display text themes
  TextTheme textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );

  return textTheme;
}


class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff006973),
      surfaceTint: Color(0xff006973),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff9df0fb),
      onPrimaryContainer: Color(0xff001f23),
      secondary: Color(0xff4a6366),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffcde7eb),
      onSecondaryContainer: Color(0xff051f22),
      tertiary: Color(0xff515e7d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffd9e2ff),
      onTertiaryContainer: Color(0xff0d1b36),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfff5fafb),
      onSurface: Color(0xff171d1e),
      onSurfaceVariant: Color(0xff3f484a),
      outline: Color(0xff6f797a),
      outlineVariant: Color(0xffbec8ca),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3132),
      inversePrimary: Color(0xff81d3df),
      primaryFixed: Color(0xff9df0fb),
      onPrimaryFixed: Color(0xff001f23),
      primaryFixedDim: Color(0xff81d3df),
      onPrimaryFixedVariant: Color(0xff004f56),
      secondaryFixed: Color(0xffcde7eb),
      onSecondaryFixed: Color(0xff051f22),
      secondaryFixedDim: Color(0xffb1cbcf),
      onSecondaryFixedVariant: Color(0xff324b4e),
      tertiaryFixed: Color(0xffd9e2ff),
      onTertiaryFixed: Color(0xff0d1b36),
      tertiaryFixedDim: Color(0xffb9c6ea),
      onTertiaryFixedVariant: Color(0xff3a4664),
      surfaceDim: Color(0xffd5dbdc),
      surfaceBright: Color(0xfff5fafb),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f5),
      surfaceContainer: Color(0xffe9eff0),
      surfaceContainerHigh: Color(0xffe3e9ea),
      surfaceContainerHighest: Color(0xffdee4e4),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff004a52),
      surfaceTint: Color(0xff006973),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff24808a),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2f474a),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff60797d),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff364260),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff677495),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff5fafb),
      onSurface: Color(0xff171d1e),
      onSurfaceVariant: Color(0xff3b4446),
      outline: Color(0xff576162),
      outlineVariant: Color(0xff737c7e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3132),
      inversePrimary: Color(0xff81d3df),
      primaryFixed: Color(0xff24808a),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff006670),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff60797d),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff486064),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff677495),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff4f5c7b),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd5dbdc),
      surfaceBright: Color(0xfff5fafb),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f5),
      surfaceContainer: Color(0xffe9eff0),
      surfaceContainerHigh: Color(0xffe3e9ea),
      surfaceContainerHighest: Color(0xffdee4e4),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff00272b),
      surfaceTint: Color(0xff006973),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff004a52),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff0c2629),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff2f474a),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff14223e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff364260),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff5fafb),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff1c2527),
      outline: Color(0xff3b4446),
      outlineVariant: Color(0xff3b4446),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3132),
      inversePrimary: Color(0xffbbf6ff),
      primaryFixed: Color(0xff004a52),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003238),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff2f474a),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff183034),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff364260),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff1f2c49),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd5dbdc),
      surfaceBright: Color(0xfff5fafb),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f5),
      surfaceContainer: Color(0xffe9eff0),
      surfaceContainerHigh: Color(0xffe3e9ea),
      surfaceContainerHighest: Color(0xffdee4e4),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff006973),
      surfaceTint: Color(0xff006973),
      onPrimary: Color(0xff00363c),
      primaryContainer: Color(0xff004f56),
      onPrimaryContainer: Color(0xff9df0fb),
      secondary: Color(0xffb1cbcf),
      onSecondary: Color(0xff1c3438),
      secondaryContainer: Color(0xff324b4e),
      onSecondaryContainer: Color(0xffcde7eb),
      tertiary: Color(0xffb9c6ea),
      onTertiary: Color(0xff23304d),
      tertiaryContainer: Color(0xff3a4664),
      onTertiaryContainer: Color(0xffd9e2ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0e1415),
      onSurface: Color(0xffdee4e4),
      onSurfaceVariant: Color(0xffbec8ca),
      outline: Color(0xff899294),
      outlineVariant: Color(0xff3f484a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee4e4),
      inversePrimary: Color(0xff006973),
      primaryFixed: Color(0xff9df0fb),
      onPrimaryFixed: Color(0xff001f23),
      primaryFixedDim: Color(0xff81d3df),
      onPrimaryFixedVariant: Color(0xff004f56),
      secondaryFixed: Color(0xffcde7eb),
      onSecondaryFixed: Color(0xff051f22),
      secondaryFixedDim: Color(0xffb1cbcf),
      onSecondaryFixedVariant: Color(0xff324b4e),
      tertiaryFixed: Color(0xffd9e2ff),
      onTertiaryFixed: Color(0xff0d1b36),
      tertiaryFixedDim: Color(0xffb9c6ea),
      onTertiaryFixedVariant: Color(0xff3a4664),
      surfaceDim: Color(0xff0e1415),
      surfaceBright: Color(0xff343a3b),
      surfaceContainerLowest: Color(0xff090f10),
      surfaceContainerLow: Color(0xff171d1e),
      surfaceContainer: Color(0xff1b2122),
      surfaceContainerHigh: Color(0xff252b2c),
      surfaceContainerHighest: Color(0xff303637),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff85d8e3),
      surfaceTint: Color(0xff81d3df),
      onPrimary: Color(0xff001a1d),
      primaryContainer: Color(0xff489ca7),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffb5cfd4),
      onSecondary: Color(0xff011a1d),
      secondaryContainer: Color(0xff7c9599),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffbdcaef),
      onTertiary: Color(0xff071531),
      tertiaryContainer: Color(0xff8390b2),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0e1415),
      onSurface: Color(0xfff6fcfd),
      onSurfaceVariant: Color(0xffc3ccce),
      outline: Color(0xff9ba5a6),
      outlineVariant: Color(0xff7b8586),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee4e4),
      inversePrimary: Color(0xff005058),
      primaryFixed: Color(0xff9df0fb),
      onPrimaryFixed: Color(0xff001417),
      primaryFixedDim: Color(0xff81d3df),
      onPrimaryFixedVariant: Color(0xff003d43),
      secondaryFixed: Color(0xffcde7eb),
      onSecondaryFixed: Color(0xff001417),
      secondaryFixedDim: Color(0xffb1cbcf),
      onSecondaryFixedVariant: Color(0xff223a3d),
      tertiaryFixed: Color(0xffd9e2ff),
      onTertiaryFixed: Color(0xff02102c),
      tertiaryFixedDim: Color(0xffb9c6ea),
      onTertiaryFixedVariant: Color(0xff293653),
      surfaceDim: Color(0xff0e1415),
      surfaceBright: Color(0xff343a3b),
      surfaceContainerLowest: Color(0xff090f10),
      surfaceContainerLow: Color(0xff171d1e),
      surfaceContainer: Color(0xff1b2122),
      surfaceContainerHigh: Color(0xff252b2c),
      surfaceContainerHighest: Color(0xff303637),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff0fdff),
      surfaceTint: Color(0xff81d3df),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff85d8e3),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfff0fdff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffb5cfd4),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffcfaff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffbdcaef),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0e1415),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfff3fdfe),
      outline: Color(0xffc3ccce),
      outlineVariant: Color(0xffc3ccce),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee4e4),
      inversePrimary: Color(0xff002f34),
      primaryFixed: Color(0xffa5f4ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff85d8e3),
      onPrimaryFixedVariant: Color(0xff001a1d),
      secondaryFixed: Color(0xffd1ecf0),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffb5cfd4),
      onSecondaryFixedVariant: Color(0xff011a1d),
      tertiaryFixed: Color(0xffdfe6ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffbdcaef),
      onTertiaryFixedVariant: Color(0xff071531),
      surfaceDim: Color(0xff0e1415),
      surfaceBright: Color(0xff343a3b),
      surfaceContainerLowest: Color(0xff090f10),
      surfaceContainerLow: Color(0xff171d1e),
      surfaceContainer: Color(0xff1b2122),
      surfaceContainerHigh: Color(0xff252b2c),
      surfaceContainerHighest: Color(0xff303637),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.background,
    canvasColor: colorScheme.surface,
  );

  /// pink
  static const pink = ExtendedColor(
    seed: Color(0xffffc0cb),
    value: Color(0xffffc0cb),
    light: ColorFamily(
      color: Color(0xff8d4959),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffd9df),
      onColorContainer: Color(0xff3a0717),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff8d4959),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffd9df),
      onColorContainer: Color(0xff3a0717),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff8d4959),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffd9df),
      onColorContainer: Color(0xff3a0717),
    ),
    dark: ColorFamily(
      color: Color(0xffffb1c0),
      onColor: Color(0xff551d2c),
      colorContainer: Color(0xff713342),
      onColorContainer: Color(0xffffd9df),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffffb1c0),
      onColor: Color(0xff551d2c),
      colorContainer: Color(0xff713342),
      onColorContainer: Color(0xffffd9df),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffffb1c0),
      onColor: Color(0xff551d2c),
      colorContainer: Color(0xff713342),
      onColorContainer: Color(0xffffd9df),
    ),
  );

  /// voilet
  static const voilet = ExtendedColor(
    seed: Color(0xff7f00ff),
    value: Color(0xff7f00ff),
    light: ColorFamily(
      color: Color(0xff69548d),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffecdcff),
      onColorContainer: Color(0xff240e45),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff69548d),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffecdcff),
      onColorContainer: Color(0xff240e45),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff69548d),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffecdcff),
      onColorContainer: Color(0xff240e45),
    ),
    dark: ColorFamily(
      color: Color(0xffd5bbfc),
      onColor: Color(0xff3a255b),
      colorContainer: Color(0xff513c73),
      onColorContainer: Color(0xffecdcff),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffd5bbfc),
      onColor: Color(0xff3a255b),
      colorContainer: Color(0xff513c73),
      onColorContainer: Color(0xffecdcff),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffd5bbfc),
      onColor: Color(0xff3a255b),
      colorContainer: Color(0xff513c73),
      onColorContainer: Color(0xffecdcff),
    ),
  );

  /// yellow
  static const yellow = ExtendedColor(
    seed: Color(0xffffff00),
    value: Color(0xffffff00),
    light: ColorFamily(
      color: Color(0xff616118),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffe8e78f),
      onColorContainer: Color(0xff1d1d00),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff616118),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffe8e78f),
      onColorContainer: Color(0xff1d1d00),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff616118),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffe8e78f),
      onColorContainer: Color(0xff1d1d00),
    ),
    dark: ColorFamily(
      color: Color(0xffcbcb76),
      onColor: Color(0xff323200),
      colorContainer: Color(0xff494900),
      onColorContainer: Color(0xffe8e78f),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffcbcb76),
      onColor: Color(0xff323200),
      colorContainer: Color(0xff494900),
      onColorContainer: Color(0xffe8e78f),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffcbcb76),
      onColor: Color(0xff323200),
      colorContainer: Color(0xff494900),
      onColorContainer: Color(0xffe8e78f),
    ),
  );

  /// blue
  static const blue = ExtendedColor(
    seed: Color(0xff0000ff),
    value: Color(0xff0000ff),
    light: ColorFamily(
      color: Color(0xff555992),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffe0e0ff),
      onColorContainer: Color(0xff11144b),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff555992),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffe0e0ff),
      onColorContainer: Color(0xff11144b),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff555992),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffe0e0ff),
      onColorContainer: Color(0xff11144b),
    ),
    dark: ColorFamily(
      color: Color(0xffbec2ff),
      onColor: Color(0xff272b60),
      colorContainer: Color(0xff3e4278),
      onColorContainer: Color(0xffe0e0ff),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffbec2ff),
      onColor: Color(0xff272b60),
      colorContainer: Color(0xff3e4278),
      onColorContainer: Color(0xffe0e0ff),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffbec2ff),
      onColor: Color(0xff272b60),
      colorContainer: Color(0xff3e4278),
      onColorContainer: Color(0xffe0e0ff),
    ),
  );


  List<ExtendedColor> get extendedColors => [
    pink,
    voilet,
    yellow,
    blue,
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}

