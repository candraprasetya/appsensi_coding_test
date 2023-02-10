part of 'utilities.dart';

ThemeData myTheme = ThemeData(
  useMaterial3: true,
  textTheme: GoogleFonts.poppinsTextTheme(),
  primaryColor: colorName.primary500,
  dividerColor: colorName.neutral50,
);

mixin colorName {
  static const orang500 = Color(0xFFFFAA81);
  static const primary500 = Color(0xFF47C2FF);
  static const neutral50 = Color(0xFFf1f2f6);
  static const neutral0 = Color(0xFFFFFFFF);
  static const neutral200 = Color(0xFF9EA6AF);
  static const neutral300 = Color(0xFF727E8A);
  static const neutral500 = Color(0xFF2C3E50);
  static const warning100 = Color(0xFFFFEFCB);
  static const warning500 = Color(0xFFFECA57);
  static const warning700 = Color(0xFFB48F3E);
  static const red500 = Color(0xFFFF7070);
}
