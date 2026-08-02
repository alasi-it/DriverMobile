import 'package:flutter/material.dart';

class AppColors {
  static bool _isDark = false;

  static void updateTheme(bool isDark) => _isDark = isDark;

  static bool isDark() => _isDark;

  // Base
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Brand
  static Color primaryLight = primary700;
  static Color primaryDark = primary700;
  static Color secondaryLight = secondary700;
  static Color secondaryDark = secondary700;
  static const Color tertiaryLight = Color(0xFF213047);
  static const Color tertiaryDark = Color(0xFF213047);

  // Background / surfaces
  static const Color backgroundPrimaryLight = Color(0xFFFDFDFD);
  static const Color backgroundPrimaryDark = Color(0xFF232222);
  static const Color backgroundSecondaryLight = Color(0xFFFFFFFF);
  static const Color backgroundSecondaryDark = Color(0xFF494849);

  // Typography
  static const Color typographyHeadingLight = Color(0xFF2D2D2D);
  static const Color typographyHeadingDark = Color(0xFFFFFFFF);
  static const Color typographySubtitleLight = Color(0xFF696969);
  static const Color typographySubtitleDark = Color(0xFFFFFFFF);
  static const Color typographyBodyLight = Color(0xFF30303D);
  static const Color typographyBodyDark = Color(0xFFFFFFFF);

  // Inputs
  static const Color inputBackgroundLight = Color(0xFFFFFFFF);
  static const Color inputBackgroundDark = Color(0xFF1D2226);
  static const Color inputOutlineLight = grey50;
  static const Color inputOutlineDark = Color(0xFF292C32);
  static const Color inputPlaceholderLight = Color(0xFF656565);
  static const Color inputPlaceholderDark = Color(0xFFB3BAC6);

  // Buttons
  static final Color buttonPrimaryLight = primaryLight;
  static final Color buttonPrimaryDark = primaryDark;
  static const Color buttonLabelLight = white;
  static const Color buttonLabelDark = white;
  static const Color buttonDisabled = Color(0xFFCCCCCC);

  // Icons
  static const Color iconPrimaryLight = typographyHeadingLight;
  static const Color iconPrimaryDark = typographyHeadingDark;
  static const Color iconSuccess = Color(0xFF27AE60);

  //card
  static const Color cardBackgroundLight = white;
  static const Color cardBackgroundDark = Color(0xFF1D2226);

  // primary:
  static Color primary50 = Color(0xFFECFBFC);
  static Color primary100 = Color(0xFFC4F1F4);
  static Color primary200 = Color(0xFFA8EAEF);
  static Color primary300 = Color(0xFF80E1E8);
  static Color primary400 = Color(0xFF68DBE3);
  static Color primary500 = Color(0xFF42D2DC);
  static Color primary600 = Color(0xFF3CBFC8);
  static Color primary700 = Color(0xFF2F959C);
  static Color primary800 = Color(0xFF247479);
  static Color primary900 = Color(0xFF1C585C);

  // secondary:

  static Color secondary50 = Color(0xFFFDFAED);
  static Color secondary100 = Color(0xFFF9F0C6);
  static Color secondary200 = Color(0xFFF7E9AB);
  static Color secondary300 = Color(0xFFF3DF84);
  static Color secondary400 = Color(0xFFF1D96D);
  static Color secondary500 = Color(0xFFEDCF48);
  static Color secondary600 = Color(0xFFD8BC42);
  static Color secondary700 = Color(0xFFA89333);
  static Color secondary800 = Color(0xFF827228);
  static Color secondary900 = Color(0xFF64571E);
  //gray

  static const Color grey50 = Color(0xFFECECEC);
  static const Color grey100 = Color(0xFFC4C4C4);
  static const Color grey200 = Color(0xFFA7A7A7);
  static const Color grey300 = Color(0xFF7F7F7F);
  static const Color grey400 = Color(0xFF666666);
  static const Color grey500 = Color(0xFF404040);
  static const Color grey600 = Color(0xFF3A3A3A);
  static const Color grey700 = Color(0xFF2D2D2D);
  static const Color grey800 = Color(0xFF232323);
  static const Color grey900 = Color(0xFF1B1B1B);

  // green

  static const Color green50 = Color(0xFFE6FAF1);
  static const Color green100 = Color(0xFFB0EED4);
  static const Color green200 = Color(0xFF8AE5C0);
  static const Color green300 = Color(0xFF54DBA3);
  static const Color green400 = Color(0xFF33D491);
  static const Color green500 = Color(0xFF00C975);
  static const Color green600 = Color(0xFF00B76A);
  static const Color green700 = Color(0xFF008F53);
  static const Color green800 = Color(0xFF006F40);
  static const Color green900 = Color(0xFF005431);

  // Status
  static const Color errorColor = Color(0xFFC03131);
  static const Color secondErrorColor = Color(0xff8C3B00);
  static const Color warningColor = Color(0xffFF8933);
  static const Color warning50Color = Color(0xffFFF0E6);
  static const Color warning2Color = Color(0xffE86100);
  static const Color warning3Color = Color(0xffFFD1B0);

  static const Color errorBackground = Color(0xffFBEBEB);
  static const Color successColor = green700;

  static const Color cardTitleColor = Color(0xFF8A6D43);

  // Legacy (used by AppTheme)
  static const Color textLight = Color(0xFF101820);
  static const Color textDark = white;
  static const Color textGrayLight = grey300;
  static const Color bgNavBar = Color(0xffFCFCFC);

  //notifications icon background
  static const Color notificationIconBackground = Color(0x331D585E);

  // OnBoarding Button
  static final Color onboardingButton = secondary600;
  static const Color dotColor = Color(0xff3CBFC8);
  // gradient

  static LinearGradient appBarGradient = LinearGradient(
    begin: Alignment(-0.0357, -1.0),
    end: Alignment(0.0357, 1.0),
    colors: [Color(0xFF1D5E62), Color(0xFF1D5E62).withOpacity(0.7)],
    stops: const [0.0172, 0.9828],
  );

  // Dynamic getters (ThemeCubit-driven)
  static Color get primary => isDark() ? primaryDark : primaryLight;
  static Color get secondary => isDark() ? secondaryDark : secondaryLight;
  static Color get tertiary => isDark() ? tertiaryDark : tertiaryLight;

  static Color get backgroundPrimary =>
      isDark() ? backgroundPrimaryDark : backgroundPrimaryLight;
  static Color get backgroundSecondary =>
      isDark() ? backgroundSecondaryDark : backgroundSecondaryLight;

  static Color get typographyHeading =>
      isDark() ? typographyHeadingDark : typographyHeadingLight;
  static Color get typographySubtitle =>
      isDark() ? typographySubtitleDark : typographySubtitleLight;
  static Color get typographyBody =>
      isDark() ? typographyBodyDark : typographyBodyLight;

  static Color get inputBackground =>
      isDark() ? inputBackgroundDark : inputBackgroundLight;
  static Color get inputOutline =>
      isDark() ? inputOutlineDark : inputOutlineLight;
  static Color get inputPlaceholder =>
      isDark() ? inputPlaceholderDark : inputPlaceholderLight;

  static Color get buttonPrimary =>
      isDark() ? buttonPrimaryDark : buttonPrimaryLight;
  static Color get buttonLabel => isDark() ? buttonLabelDark : buttonLabelLight;

  static Color get iconPrimary => isDark() ? iconPrimaryDark : iconPrimaryLight;

  static Color get errorBorder => errorColor;
  static Color get errorText => errorColor;

  static void setPrimary(
    Color light,
    Color dark, {
    Color? secondaryLight,
    Color? secondaryDark,
  }) {
    primaryLight = light;
    primaryDark = dark;
    primary50 = _generateShade(light, 50);
    primary100 = _generateShade(light, 100);
    primary200 = _generateShade(light, 200);
    primary300 = _generateShade(light, 300);
    primary400 = _generateShade(light, 400);
    primary500 = _generateShade(light, 500);
    primary600 = _generateShade(dark, 600);
    primary700 = _generateShade(dark, 700);
    primary800 = _generateShade(dark, 800);
    primary900 = _generateShade(dark, 900);
    secondary50 = _generateShade(
      secondaryLight ?? AppColors.secondaryLight,
      50,
    );
    secondary100 = _generateShade(
      secondaryLight ?? AppColors.secondaryLight,
      100,
    );
    secondary200 = _generateShade(
      secondaryLight ?? AppColors.secondaryLight,
      200,
    );
    secondary300 = _generateShade(
      secondaryLight ?? AppColors.secondaryLight,
      300,
    );
    secondary400 = _generateShade(
      secondaryLight ?? AppColors.secondaryLight,
      400,
    );
    secondary500 = _generateShade(
      secondaryLight ?? AppColors.secondaryLight,
      500,
    );
    secondary600 = _generateShade(
      secondaryDark ?? AppColors.secondaryDark,
      600,
    );
    secondary700 = _generateShade(
      secondaryDark ?? AppColors.secondaryDark,
      700,
    );
    secondary800 = _generateShade(
      secondaryDark ?? AppColors.secondaryDark,
      800,
    );
    secondary900 = _generateShade(
      secondaryDark ?? AppColors.secondaryDark,
      900,
    );
    appBarGradient = LinearGradient(
      begin: Alignment(-0.0357, -1.0),
      end: Alignment(0.0357, 1.0),
      colors: [primary, primary.withOpacity(0.7)],
      stops: const [0.0172, 0.9828],
    );
  }

  static Color _generateShade(Color color, int shade) {
    final hsl = HSLColor.fromColor(color);

    const lightRatio = <int, double>{
      50: 2.28,
      100: 2.07,
      200: 1.93,
      300: 1.74,
      400: 1.61,
      500: 1.41,
      600: 1.28,
      700: 1.0,
      800: 0.774,
      900: 0.592,
    };
    const satBoost = <int, double>{
      50: 1.40,
      100: 1.38,
      200: 1.40,
      300: 1.40,
      400: 1.40,
      500: 1.40,
      600: 1.13,
      700: 1.0,
      800: 1.0,
      900: 1.0,
    };

    final l = (hsl.lightness * (lightRatio[shade] ?? 1.0)).clamp(0.0, 1.0);
    final s = (hsl.saturation * (satBoost[shade] ?? 1.0)).clamp(0.0, 1.0);
    return HSLColor.fromAHSL(1.0, hsl.hue, s, l).toColor();
  }
}
