import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Bungkus setiap halaman dengan ini.
/// - Desktop native  → langsung tampil (window sudah di-lock 1024×600)
/// - Web besar       → sudah ditangani _WebContainer di main.dart
/// - Mobile          → full screen biasa
class ResponsiveWrapper extends StatelessWidget {
  final Widget child;
  const ResponsiveWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) => child;
}

/// Helper: apakah layar saat ini termasuk mobile (lebar < 600)
bool isMobileScreen(BuildContext context) =>
    MediaQuery.of(context).size.width < 600;

/// Helper: apakah ini web yang berjalan di browser desktop
bool isWebDesktop(BuildContext context) =>
    kIsWeb && MediaQuery.of(context).size.width >= 1024;
