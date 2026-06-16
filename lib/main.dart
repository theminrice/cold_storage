import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';
import 'app/routes/app_pages.dart';

const Size kDesktopSize = Size(1024, 600);
const Size kMobileSize = Size(390, 844);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (GetPlatform.isDesktop && !GetPlatform.isWeb) {
    await _initDesktopWindow();
  }
  runApp(const MyApp());
}

Future<void> _initDesktopWindow() async {
  await windowManager.ensureInitialized();
  const WindowOptions opts = WindowOptions(
    size: kDesktopSize,
    minimumSize: kDesktopSize,
    maximumSize: kDesktopSize,
    center: true,
    title: 'Cold Storage Controller',
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );
  await windowManager.waitUntilReadyToShow(opts, () async {
    await windowManager.show();
    await windowManager.focus();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Pilih designSize berdasarkan platform SEBELUM ScreenUtil init
  Size get _designSize {
    if (kIsWeb || GetPlatform.isDesktop) return kDesktopSize;
    return kMobileSize; // mobile pakai 390×844
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: _designSize,
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Cold Storage Controller',
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          themeMode: ThemeMode.light,
          theme: AppTheme.light(),
          // Web: center + constrain layout ke 1024×600
          builder: kIsWeb
              ? (context, child) => _WebContainer(child: child!)
              : null,
        );
      },
    );
  }
}

// ── Web Container: center konten 1024×600 di tengah layar ──────────────────
class _WebContainer extends StatelessWidget {
  final Widget child;
  const _WebContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;

    // Kalau layar lebih kecil dari 1024 (web mobile), full screen saja
    if (screenW < 1024) return child;

    // Layar besar (desktop browser): center + box 1024×600
    return Scaffold(
      backgroundColor: const Color(0xFFCDD8F0),
      body: Center(
        child: SizedBox(
          width: kDesktopSize.width,
          height: kDesktopSize.height.clamp(0, screenH - 40),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(0),
            child: child,
          ),
        ),
      ),
    );
  }
}

// ── Theme ───────────────────────────────────────────────────────────────────
class AppTheme {
  AppTheme._();
  static const Color _primary = Color(0xFF0066FF);
  static const Color _onSurface = Color(0xFF0D1B4B);
  static const Color _fieldFill = Color(0xFFE8F0FF);

  static ThemeData light() => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primary,
      brightness: Brightness.light,
      primary: _primary,
      onPrimary: Colors.white,
      surface: Colors.white,
      onSurface: _onSurface,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: _onSurface,
      elevation: 0,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _fieldFill,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
    ),
  );
}
