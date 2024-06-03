import 'package:flutter/material.dart';

class TTextTheme {
  TTextTheme._(); // To avoid creating instances

  static TextTheme textTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF191716)),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF191716)),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF191716)),

    titleLarge: const TextStyle().copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF191716)),
    titleMedium: const TextStyle().copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF191716)),
    titleSmall: const TextStyle().copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF191716)),

    bodyLarge: const TextStyle().copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF191716)),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: const Color(0xFF191716)),
    bodySmall: const TextStyle().copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: const Color(0x80191716)), // Opacity 0.5

    labelLarge: const TextStyle().copyWith(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: const Color(0xFF191716)),
    labelMedium: const TextStyle().copyWith(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: const Color(0x80191716)), // Opacity 0.5
  );
}
