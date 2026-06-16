import 'package:cold_storage/app/utils/responsive_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../../routes/app_pages.dart';

// ─── Palette ──────────────────────────────────────────────────────────────────
const Color _blue = Color(0xFF0066FF);
const Color _blueDark = Color(0xFF003ECC);
const Color _blueLight = Color(0xFFE8F1FF);
const Color _bgSlide = Color(0xFFF0F5FF);
const Color _textDark = Color(0xFF0D1B4B);
const Color _textGrey = Color(0xFF6B7BA4);
const Color _white = Colors.white;
const Color _greenOn = Color(0xFF22C55E);

class IntroductionView extends StatelessWidget {
  const IntroductionView({super.key});

  void _goToLogin() => Get.offAllNamed(Routes.LOGIN);

  // ── Cek apakah layar ini mobile (lebar < 600) ───────────────────────────
  bool _isMobile(BuildContext ctx) => isMobileScreen(ctx);

  @override
  Widget build(BuildContext context) {
    final mobile = _isMobile(context);

    return ResponsiveWrapper(
      child: Scaffold(
        backgroundColor: _bgSlide,
        body: LayoutBuilder(
          builder: (context, box) {
            return IntroductionScreen(
              globalBackgroundColor: _bgSlide,
              pages: [
                _page1(box, mobile),
                _page2(box, mobile),
                _page3(box, mobile),
                _page4(box, mobile),
              ],
              onDone: _goToLogin,
              onSkip: _goToLogin,
              showSkipButton: true,
              showNextButton: true,
              showDoneButton: false,
              skip: _btnSkip(mobile),
              next: _btnNext('NEXT', mobile),
              done: _btnNext('DONE', mobile),
              dotsDecorator: DotsDecorator(
                size: Size(mobile ? 8.w : 10.w, mobile ? 8.w : 10.w),
                activeSize: Size(mobile ? 8.w : 10.w, mobile ? 8.w : 10.w),
                color: _white.withOpacity(0.5),
                activeColor: _blue,
                shape: const CircleBorder(),
                activeShape: const CircleBorder(),
                spacing: EdgeInsets.symmetric(horizontal: 4.w),
              ),
              dotsContainerDecorator: const BoxDecoration(
                color: Colors.transparent,
              ),
              controlsMargin: EdgeInsets.symmetric(
                horizontal: mobile ? 20.w : 32.w,
                vertical: mobile ? 12.h : 20.h,
              ),
              controlsPadding: EdgeInsets.zero,
              animationDuration: 400,
              curve: Curves.easeInOutCubic,
              isProgress: true,
              isProgressTap: true,
              freeze: false,
            );
          },
        ),
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // SLIDE 1 — Welcome
  // ══════════════════════════════════════════════════════════════════════════
  PageViewModel _page1(BoxConstraints box, bool mobile) => PageViewModel(
    titleWidget: const SizedBox.shrink(),
    bodyWidget: _WaveSlide(
      maxH: box.maxHeight,
      mobile: mobile,
      child: mobile
          // ── MOBILE: ilustrasi atas, teks bawah ──
          ? SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(24.w, 40.h, 24.w, 0),
              child: Column(
                children: [
                  _buildIllustration(mobile: true),
                  SizedBox(height: 24.h),
                  _buildWelcomeText(mobile: true),
                ],
              ),
            )
          // ── DESKTOP: kiri ilustrasi, kanan teks ──
          : Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Center(child: _buildIllustration(mobile: false)),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.only(right: 48.w),
                    child: _buildWelcomeText(mobile: false),
                  ),
                ),
              ],
            ),
    ),
  );

  Widget _buildIllustration({required bool mobile}) {
    final iconSize = mobile ? 70.sp : 100.sp;
    final circleSize = mobile ? 180.w : 260.w;
    final buildingW = mobile ? 120.w : 160.w;
    final buildingH = mobile ? 60.h : 80.h;
    final doorW = mobile ? 30.w : 40.w;
    final doorH = mobile ? 45.h : 60.h;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: circleSize,
          height: circleSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [_blue.withOpacity(0.12), _blue.withOpacity(0.0)],
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.ac_unit_rounded, size: iconSize, color: _blue),
            SizedBox(height: 8.h),
            Container(
              width: buildingW,
              height: buildingH,
              decoration: BoxDecoration(
                color: _white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.r),
                  topRight: Radius.circular(8.r),
                ),
                border: Border.all(color: _blue.withOpacity(0.3), width: 1.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.air,
                        color: _blue,
                        size: mobile ? 14.sp : 18.sp,
                      ),
                      Icon(
                        Icons.air,
                        color: _blue,
                        size: mobile ? 14.sp : 18.sp,
                      ),
                    ],
                  ),
                  Container(
                    width: doorW,
                    height: doorH,
                    decoration: BoxDecoration(
                      color: _blue.withOpacity(0.15),
                      border: Border.all(color: _blue, width: 1.5),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Icon(
                      Icons.ac_unit,
                      color: _blue,
                      size: mobile ? 16.sp : 20.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 10,
          left: 20,
          child: Icon(
            Icons.ac_unit,
            color: _blue.withOpacity(0.25),
            size: mobile ? 14 : 18,
          ),
        ),
        Positioned(
          top: 30,
          right: 10,
          child: Icon(Icons.ac_unit, color: _blue.withOpacity(0.15), size: 12),
        ),
        Positioned(
          bottom: 20,
          right: 30,
          child: Icon(Icons.ac_unit, color: _blue.withOpacity(0.20), size: 14),
        ),
      ],
    );
  }

  Widget _buildWelcomeText({required bool mobile}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'WELCOME TO',
          style: TextStyle(
            fontSize: mobile ? 11.sp : 16.sp,
            fontWeight: FontWeight.w700,
            color: _textDark,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'COLD STORAGE\nCONTROLLER',
          style: TextStyle(
            // ✅ FIX: font lebih kecil di mobile agar tidak terpotong
            fontSize: mobile ? 22.sp : 36.sp,
            fontWeight: FontWeight.w900,
            color: _blue,
            height: 1.1,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          'Smart Monitoring & Control System',
          style: TextStyle(
            fontSize: mobile ? 12.sp : 14.sp,
            fontWeight: FontWeight.w600,
            color: _textDark,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.h),
          width: 40.w,
          height: 3,
          decoration: BoxDecoration(
            color: _blue,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Text(
          'Monitor dan kendalikan sistem cold storage\nsecara real-time dari satu dashboard terintegrasi.',
          style: TextStyle(
            fontSize: mobile ? 11.sp : 13.sp,
            color: _textGrey,
            height: 1.65,
          ),
        ),
      ],
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // SLIDE 2 — Real-Time Monitoring
  // ══════════════════════════════════════════════════════════════════════════
  PageViewModel _page2(BoxConstraints box, bool mobile) => PageViewModel(
    titleWidget: const SizedBox.shrink(),
    bodyWidget: _WaveSlide(
      maxH: box.maxHeight,
      mobile: mobile,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: mobile ? 16.w : 40.w,
          vertical: mobile ? 20.h : 0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!mobile) SizedBox(height: 20.h),
            // ── Header
            Text(
              'REAL-TIME',
              style: TextStyle(
                fontSize: mobile ? 11.sp : 14.sp,
                fontWeight: FontWeight.w700,
                color: _textDark,
                letterSpacing: 2,
              ),
            ),
            Text(
              'MONITORING',
              style: TextStyle(
                fontSize: mobile ? 24.sp : 32.sp,
                fontWeight: FontWeight.w900,
                color: _blue,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 6.h),
              width: 36.w,
              height: 3,
              decoration: BoxDecoration(
                color: _blue,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Text(
              'Pantau suhu, kelembaban, status fan, defrost,\nalarm, dan konsumsi daya secara langsung',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: mobile ? 11.sp : 12.sp,
                color: _textGrey,
                height: 1.5,
              ),
            ),
            SizedBox(height: mobile ? 12.h : 14.h),

            // ── Row stat card: suhu + kelembaban
            Row(
              children: [
                Expanded(
                  child: _statCard(
                    icon: Icons.thermostat_rounded,
                    label: 'TEMPERATURE',
                    value: '-18.5 °C',
                    sub: 'Set Point  -20.0 °C',
                    mobile: mobile,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _statCard(
                    icon: Icons.water_drop_rounded,
                    label: 'HUMIDITY',
                    value: '85%',
                    sub: 'Normal',
                    subColor: _greenOn,
                    mobile: mobile,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),

            // ── Row chart + equipment
            // Mobile: column, Desktop: row
            mobile
                ? Column(
                    children: [
                      _chartCard(mobile: true),
                      SizedBox(height: 10.h),
                      _equipCard(mobile: true),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(flex: 6, child: _chartCard(mobile: false)),
                      SizedBox(width: 12.w),
                      Expanded(flex: 4, child: _equipCard(mobile: false)),
                    ],
                  ),
            SizedBox(height: 10.h),

            // ── 3 fitur bawah
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _featureIcon(
                  Icons.thermostat_rounded,
                  'Temperature\nMonitoring',
                  mobile,
                ),
                SizedBox(width: mobile ? 20.w : 32.w),
                _featureIcon(
                  Icons.water_drop_rounded,
                  'Humidity\nMonitoring',
                  mobile,
                ),
                SizedBox(width: mobile ? 20.w : 32.w),
                _featureIcon(
                  Icons.settings_suggest_rounded,
                  'Equipment\nStatus',
                  mobile,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );

  Widget _chartCard({required bool mobile}) => _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TEMPERATURE CHART',
          style: TextStyle(
            fontSize: mobile ? 9.sp : 10.sp,
            fontWeight: FontWeight.w700,
            color: _textDark,
            letterSpacing: 0.8,
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(height: mobile ? 60.h : 70.h, child: const _MiniChart()),
      ],
    ),
  );

  Widget _equipCard({required bool mobile}) => _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'EQUIPMENT STATUS',
          style: TextStyle(
            fontSize: mobile ? 9.sp : 10.sp,
            fontWeight: FontWeight.w700,
            color: _textDark,
            letterSpacing: 0.8,
          ),
        ),
        SizedBox(height: 8.h),
        _equipRow('Compressor', true, mobile),
        _equipRow('Evaporator Fan', true, mobile),
        _equipRow('Defrost Heater', false, mobile),
        _equipRow('Door Heater', true, mobile),
      ],
    ),
  );

  // ══════════════════════════════════════════════════════════════════════════
  // SLIDE 3 — Control Anytime
  // ══════════════════════════════════════════════════════════════════════════
  PageViewModel _page3(BoxConstraints box, bool mobile) => PageViewModel(
    titleWidget: const SizedBox.shrink(),
    bodyWidget: _WaveSlide(
      maxH: box.maxHeight,
      mobile: mobile,
      child: mobile
          // ── MOBILE: scroll column
          ? SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(24.w, 40.h, 24.w, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildControlText(mobile: true),
                  SizedBox(height: 24.h),
                  Center(child: _buildPhoneMockup(mobile: true)),
                ],
              ),
            )
          // ── DESKTOP: kiri teks, kanan mockup
          : Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.only(left: 40.w),
                    child: _buildControlText(mobile: false),
                  ),
                ),
                Expanded(flex: 5, child: _buildPhoneMockup(mobile: false)),
              ],
            ),
    ),
  );

  Widget _buildControlText({required bool mobile}) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'CONTROL ANYTIME,',
        style: TextStyle(
          fontSize: mobile ? 18.sp : 26.sp,
          fontWeight: FontWeight.w900,
          color: _textDark,
          height: 1.1,
        ),
      ),
      Text(
        'ANYWHERE',
        style: TextStyle(
          fontSize: mobile ? 18.sp : 26.sp,
          fontWeight: FontWeight.w900,
          color: _blue,
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        width: 36.w,
        height: 3,
        decoration: BoxDecoration(
          color: _blue,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      Text(
        'Kelola cold storage dari mana saja dan terima notifikasi saat terjadi kondisi abnormal.',
        style: TextStyle(
          fontSize: mobile ? 11.sp : 12.sp,
          color: _textGrey,
          height: 1.6,
        ),
      ),
      SizedBox(height: 20.h),
      Wrap(
        spacing: 10.w,
        runSpacing: 10.h,
        children: [
          _featureBox(Icons.settings_remote_rounded, 'Remote\nControl', mobile),
          _featureBox(
            Icons.notifications_active_rounded,
            'Alarm\nNotification',
            mobile,
          ),
          _featureBox(Icons.bar_chart_rounded, 'Historical\nData', mobile),
        ],
      ),
      SizedBox(height: 20.h),
      SizedBox(
        width: mobile ? double.infinity : 180.w,
        child: ElevatedButton(
          onPressed: _goToLogin,
          style: ElevatedButton.styleFrom(
            backgroundColor: _blue,
            foregroundColor: _white,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            elevation: 4,
          ),
          child: Text(
            'GET STARTED',
            style: TextStyle(
              fontSize: mobile ? 12.sp : 13.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    ],
  );

  Widget _buildPhoneMockup({required bool mobile}) {
    final phoneW = mobile ? 140.w : 170.w;
    final phoneH = mobile ? 240.h : 310.h;

    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        // Phone frame
        Container(
          width: phoneW,
          height: phoneH,
          decoration: BoxDecoration(
            color: _blueDark,
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: _blue.withOpacity(0.3),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '9:41',
                      style: TextStyle(
                        color: _white,
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.signal_cellular_alt,
                          color: _white,
                          size: 10.sp,
                        ),
                        SizedBox(width: 3.w),
                        Icon(Icons.battery_full, color: _white, size: 10.sp),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                // App bar
                Row(
                  children: [
                    Icon(Icons.arrow_back, color: _white, size: 12.sp),
                    SizedBox(width: 6.w),
                    Text(
                      'Cold Storage 01',
                      style: TextStyle(
                        color: _white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.settings, color: _white, size: 12.sp),
                  ],
                ),
                SizedBox(height: 8.h),
                // Temp card
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: _white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TEMPERATURE',
                        style: TextStyle(
                          color: _white.withOpacity(0.7),
                          fontSize: 7.sp,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        '-18.5 °C',
                        style: TextStyle(
                          color: _white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'Set Point -20.0 °C',
                        style: TextStyle(
                          color: _blue.withOpacity(0.8),
                          fontSize: 7.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  'EQUIPMENT',
                  style: TextStyle(
                    color: _white.withOpacity(0.6),
                    fontSize: 7.sp,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 4.h),
                _phoneEquipRow('Compressor', true),
                _phoneEquipRow('Evaporator Fan', true),
                _phoneEquipRow('Defrost Heater', false),
              ],
            ),
          ),
        ),

        // Alarm notif card — posisi kanan bawah
        Positioned(
          bottom: mobile ? -10.h : 30.h,
          right: mobile ? -20.w : 10.w,
          child: Container(
            width: mobile ? 160.w : 190.w,
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: _white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: BoxDecoration(
                    color: _blue,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.notifications_rounded,
                    color: _white,
                    size: 16.sp,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ALARM NOTIFICATION',
                        style: TextStyle(
                          fontSize: 7.sp,
                          fontWeight: FontWeight.w800,
                          color: _textDark,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        'High Temperature Alert!',
                        style: TextStyle(
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        'Cold Storage 01  •  10:23 AM',
                        style: TextStyle(fontSize: 7.sp, color: _textGrey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        Positioned(
          top: 20.h,
          right: 20.w,
          child: Icon(
            Icons.ac_unit,
            color: _blue.withOpacity(0.2),
            size: 24.sp,
          ),
        ),
      ],
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // SLIDE 4 — Sign Up
  // ══════════════════════════════════════════════════════════════════════════
  PageViewModel _page4(BoxConstraints box, bool mobile) => PageViewModel(
    titleWidget: const SizedBox.shrink(),
    bodyWidget: _WaveSlide(
      maxH: box.maxHeight,
      mobile: mobile,
      child: mobile
          // ── MOBILE: form full screen, device mockup disembunyikan
          ? SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Monitor Cold Storage',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      color: _textDark,
                    ),
                  ),
                  Text(
                    'Anywhere, Anytime',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      color: _blue,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8.h),
                    width: 32.w,
                    height: 3,
                    decoration: BoxDecoration(
                      color: _blue,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Text(
                    'Pantau suhu, kelembaban, dan status peralatan secara real-time.',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: _textGrey,
                      height: 1.55,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildFormCard(mobile: true),
                ],
              ),
            )
          // ── DESKTOP: kiri device mockup, kanan form
          : Row(
              children: [
                Expanded(
                  flex: 55,
                  child: Padding(
                    padding: EdgeInsets.only(left: 36.w, top: 16.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Monitor Cold Storage',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w800,
                            color: _textDark,
                          ),
                        ),
                        Text(
                          'Anywhere, Anytime',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w800,
                            color: _blue,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8.h),
                          width: 32.w,
                          height: 3,
                          decoration: BoxDecoration(
                            color: _blue,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        Text(
                          'Pantau suhu, kelembaban, dan status peralatan\nsecara real-time dari mana saja.',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: _textGrey,
                            height: 1.55,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        _buildDeviceMockup(),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            _featureIcon(
                              Icons.thermostat_rounded,
                              'Real-time\nMonitoring',
                              false,
                            ),
                            SizedBox(width: 20.w),
                            _featureIcon(
                              Icons.notifications_active_rounded,
                              'Instant\nAlert',
                              false,
                            ),
                            SizedBox(width: 20.w),
                            _featureIcon(
                              Icons.bar_chart_rounded,
                              'Historical\nData',
                              false,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 45,
                  child: Center(child: _buildFormCard(mobile: false)),
                ),
              ],
            ),
    ),
  );

  Widget _buildFormCard({required bool mobile}) => Container(
    margin: EdgeInsets.symmetric(
      vertical: mobile ? 0 : 16.h,
      horizontal: mobile ? 0 : 20.w,
    ),
    padding: EdgeInsets.symmetric(
      horizontal: mobile ? 20.w : 24.w,
      vertical: mobile ? 20.h : 20.h,
    ),
    decoration: BoxDecoration(
      color: _white,
      borderRadius: BorderRadius.circular(20.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.10),
          blurRadius: 24,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            'Create Your Account',
            style: TextStyle(
              fontSize: mobile ? 14.sp : 16.sp,
              fontWeight: FontWeight.w800,
              color: _textDark,
            ),
          ),
        ),
        Center(
          child: Text(
            'Sign up to get started',
            style: TextStyle(
              fontSize: mobile ? 10.sp : 11.sp,
              color: _textGrey,
            ),
          ),
        ),
        SizedBox(height: mobile ? 12.h : 14.h),
        _formLabel('Full Name', mobile),
        _formField(
          Icons.person_outline,
          'Enter your full name',
          mobile: mobile,
        ),
        SizedBox(height: 8.h),
        _formLabel('Email Address', mobile),
        _formField(
          Icons.email_outlined,
          'Enter your email address',
          mobile: mobile,
        ),
        SizedBox(height: 8.h),
        _formLabel('Password', mobile),
        _formField(
          Icons.lock_outline,
          'Create a password',
          isPassword: true,
          mobile: mobile,
        ),
        SizedBox(height: 8.h),
        _formLabel('Confirm Password', mobile),
        _formField(
          Icons.lock_outline,
          'Confirm your password',
          isPassword: true,
          mobile: mobile,
        ),
        SizedBox(height: 10.h),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _goToLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: _blue,
              foregroundColor: _white,
              padding: EdgeInsets.symmetric(vertical: mobile ? 12.h : 13.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              elevation: 4,
            ),
            child: Text(
              'SIGN UP',
              style: TextStyle(
                fontSize: mobile ? 12.sp : 13.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Center(
          child: Text(
            'or sign up with',
            style: TextStyle(fontSize: mobile ? 9.sp : 10.sp, color: _textGrey),
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _socialBtn(Icons.g_mobiledata_rounded, Colors.red),
            SizedBox(width: 10.w),
            _socialBtn(Icons.window_rounded, Colors.blue),
            SizedBox(width: 10.w),
            _socialBtn(Icons.apple_rounded, Colors.black),
          ],
        ),
        SizedBox(height: 8.h),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account?  ',
                style: TextStyle(
                  fontSize: mobile ? 9.sp : 10.sp,
                  color: _textGrey,
                ),
              ),
              GestureDetector(
                onTap: _goToLogin,
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: mobile ? 9.sp : 10.sp,
                    color: _blue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _buildDeviceMockup() => SizedBox(
    height: 130.h,
    child: Stack(
      children: [
        // Monitor
        Positioned(
          right: 20.w,
          top: 0,
          child: Container(
            width: 170.w,
            height: 110.h,
            decoration: BoxDecoration(
              color: const Color(0xFF1A2340),
              borderRadius: BorderRadius.circular(8.r),
            ),
            padding: EdgeInsets.all(8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dashboard',
                      style: TextStyle(
                        color: _white,
                        fontSize: 7.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: _blue,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        'Today',
                        style: TextStyle(color: _white, fontSize: 6.sp),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Expanded(child: _miniChartBox()),
                    SizedBox(width: 6.w),
                    Expanded(child: _miniSummaryBox()),
                  ],
                ),
              ],
            ),
          ),
        ),
        // Phone
        Positioned(
          left: 0,
          top: 10.h,
          child: Container(
            width: 70.w,
            height: 115.h,
            decoration: BoxDecoration(
              color: const Color(0xFF1A2340),
              borderRadius: BorderRadius.circular(12.r),
            ),
            padding: EdgeInsets.all(6.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cold Storage 01',
                  style: TextStyle(color: _white, fontSize: 5.sp),
                ),
                SizedBox(height: 4.h),
                Text(
                  'TEMPERATURE',
                  style: TextStyle(
                    color: _white.withOpacity(0.5),
                    fontSize: 4.sp,
                  ),
                ),
                Text(
                  '-18.5°C',
                  style: TextStyle(
                    color: _white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'Set Point -20.0 °C',
                  style: TextStyle(color: Colors.blue.shade300, fontSize: 4.sp),
                ),
                SizedBox(height: 4.h),
                _phoneMiniRow('Compressor', true),
                _phoneMiniRow('Evap. Fan', true),
                _phoneMiniRow('Defrost', false),
                _phoneMiniRow('Door Heater', true),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  // ─────────────────────────────────────────────────────────────────────────
  // HELPER WIDGETS
  // ─────────────────────────────────────────────────────────────────────────

  Widget _btnSkip(bool mobile) => OutlinedButton(
    onPressed: _goToLogin,
    style: OutlinedButton.styleFrom(
      foregroundColor: _textDark,
      side: const BorderSide(color: Colors.transparent),
      padding: EdgeInsets.symmetric(horizontal: 4.w),
    ),
    child: Text(
      'SKIP',
      style: TextStyle(
        fontSize: mobile ? 11.sp : 13.sp,
        fontWeight: FontWeight.w700,
        color: _textDark,
      ),
    ),
  );

  // ✅ FIX: Tombol NEXT pakai ConstrainedBox agar tidak wrap teks "N E X T"
  Widget _btnNext(String label, bool mobile) => ConstrainedBox(
    constraints: BoxConstraints(minWidth: mobile ? 80.w : 110.w),
    child: ElevatedButton.icon(
      onPressed: null, // dikelola IntroductionScreen
      icon: Icon(Icons.arrow_forward_rounded, size: mobile ? 14.sp : 16.sp),
      label: Text(
        label,
        style: TextStyle(
          fontSize: mobile ? 11.sp : 13.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: _blue,
        foregroundColor: _white,
        padding: EdgeInsets.symmetric(
          horizontal: mobile ? 16.w : 24.w,
          vertical: mobile ? 10.h : 12.h,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        elevation: 4,
        shadowColor: _blue.withOpacity(0.4),
        disabledBackgroundColor: _blue,
        disabledForegroundColor: _white,
      ),
    ),
  );

  Widget _statCard({
    required IconData icon,
    required String label,
    required String value,
    required String sub,
    required bool mobile,
    Color? subColor,
  }) => _card(
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(mobile ? 8.w : 10.w),
          decoration: BoxDecoration(color: _blueLight, shape: BoxShape.circle),
          child: Icon(icon, color: _blue, size: mobile ? 18.sp : 22.sp),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: mobile ? 8.sp : 9.sp,
                  fontWeight: FontWeight.w700,
                  color: _textGrey,
                  letterSpacing: 0.8,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: mobile ? 16.sp : 20.sp,
                  fontWeight: FontWeight.w800,
                  color: _blue,
                ),
              ),
              Text(
                sub,
                style: TextStyle(
                  fontSize: mobile ? 9.sp : 10.sp,
                  color: subColor ?? _textGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _card({required Widget child}) => Container(
    padding: EdgeInsets.all(12.w),
    decoration: BoxDecoration(
      color: _white,
      borderRadius: BorderRadius.circular(14.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 10,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: child,
  );

  Widget _equipRow(String label, bool on, bool mobile) => Padding(
    padding: EdgeInsets.symmetric(vertical: 3.h),
    child: Row(
      children: [
        Icon(Icons.circle, size: mobile ? 5.sp : 6.sp, color: _textGrey),
        SizedBox(width: 6.w),
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: mobile ? 9.sp : 10.sp, color: _textDark),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: on ? _greenOn : _textGrey,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Text(
            on ? 'ON' : 'OFF',
            style: TextStyle(
              fontSize: mobile ? 7.sp : 8.sp,
              color: _white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
  );

  Widget _featureIcon(IconData icon, String label, bool mobile) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        padding: EdgeInsets.all(mobile ? 10.w : 12.w),
        decoration: BoxDecoration(
          color: _white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: _blue.withOpacity(0.12),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(icon, color: _blue, size: mobile ? 18.sp : 22.sp),
      ),
      SizedBox(height: 6.h),
      Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: mobile ? 9.sp : 10.sp,
          color: _textDark,
          fontWeight: FontWeight.w600,
          height: 1.3,
        ),
      ),
    ],
  );

  Widget _featureBox(IconData icon, String label, bool mobile) => Container(
    padding: EdgeInsets.symmetric(
      horizontal: mobile ? 12.w : 16.w,
      vertical: mobile ? 10.h : 14.h,
    ),
    decoration: BoxDecoration(
      color: _white,
      borderRadius: BorderRadius.circular(12.r),
      boxShadow: [
        BoxShadow(
          color: _blue.withOpacity(0.10),
          blurRadius: 10,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(icon, color: _blue, size: mobile ? 18.sp : 22.sp),
        SizedBox(height: 6.h),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: mobile ? 9.sp : 10.sp,
            color: _textDark,
            fontWeight: FontWeight.w600,
            height: 1.3,
          ),
        ),
      ],
    ),
  );

  Widget _phoneEquipRow(String label, bool on) => Padding(
    padding: EdgeInsets.symmetric(vertical: 3.h),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(color: _white.withOpacity(0.8), fontSize: 7.sp),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: on ? _greenOn : _textGrey,
            borderRadius: BorderRadius.circular(3.r),
          ),
          child: Text(
            on ? 'ON' : 'OFF',
            style: TextStyle(
              color: _white,
              fontSize: 6.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
  );

  Widget _formLabel(String text, bool mobile) => Padding(
    padding: EdgeInsets.only(bottom: 4.h),
    child: Text(
      text,
      style: TextStyle(
        fontSize: mobile ? 10.sp : 11.sp,
        fontWeight: FontWeight.w600,
        color: _textDark,
      ),
    ),
  );

  Widget _formField(
    IconData icon,
    String hint, {
    bool isPassword = false,
    required bool mobile,
  }) => TextField(
    obscureText: isPassword,
    style: TextStyle(fontSize: mobile ? 10.sp : 11.sp),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(fontSize: mobile ? 10.sp : 11.sp, color: _textGrey),
      prefixIcon: Icon(icon, color: _textGrey, size: mobile ? 14.sp : 16.sp),
      suffixIcon: isPassword
          ? Icon(
              Icons.visibility_outlined,
              color: _textGrey,
              size: mobile ? 14.sp : 16.sp,
            )
          : null,
      filled: true,
      fillColor: const Color(0xFFF8FAFF),
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(color: _blue, width: 1.5),
      ),
    ),
  );

  Widget _socialBtn(IconData icon, Color color) => Container(
    padding: EdgeInsets.all(8.w),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade200),
      borderRadius: BorderRadius.circular(8.r),
    ),
    child: Icon(icon, color: color, size: 20.sp),
  );

  Widget _miniChartBox() => Container(
    height: 60.h,
    decoration: BoxDecoration(
      color: _white.withOpacity(0.07),
      borderRadius: BorderRadius.circular(6.r),
    ),
    child: const Center(child: _MiniChart()),
  );

  Widget _miniSummaryBox() => Container(
    height: 60.h,
    padding: EdgeInsets.all(5.w),
    decoration: BoxDecoration(
      color: _white.withOpacity(0.07),
      borderRadius: BorderRadius.circular(6.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Summary',
          style: TextStyle(
            color: _white,
            fontSize: 5.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 3.h),
        _summaryRow('Temperature', '-18.5°C'),
        _summaryRow('Humidity', '85%'),
        _summaryRow('Status', 'Normal'),
      ],
    ),
  );

  Widget _summaryRow(String k, String v) => Padding(
    padding: EdgeInsets.only(bottom: 2.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          k,
          style: TextStyle(color: _white.withOpacity(0.5), fontSize: 4.5.sp),
        ),
        Text(
          v,
          style: TextStyle(
            color: _white,
            fontSize: 4.5.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );

  Widget _phoneMiniRow(String label, bool on) => Padding(
    padding: EdgeInsets.only(bottom: 2.h),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(color: _white.withOpacity(0.7), fontSize: 4.5.sp),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: on ? _greenOn : _textGrey.withOpacity(0.7),
            borderRadius: BorderRadius.circular(2.r),
          ),
          child: Text(
            on ? 'ON' : 'OFF',
            style: TextStyle(
              color: _white,
              fontSize: 4.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// WAVE SLIDE BACKGROUND
// ─────────────────────────────────────────────────────────────────────────────
class _WaveSlide extends StatelessWidget {
  const _WaveSlide({
    required this.maxH,
    required this.child,
    required this.mobile,
  });
  final double maxH;
  final Widget child;
  final bool mobile;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // ✅ FIX: mobile sisakan lebih banyak ruang untuk kontrol bawah
      height: maxH - (mobile ? 80 : 72),
      child: Stack(
        children: [
          // Wave biru bawah
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(double.infinity, mobile ? 100 : 130),
              painter: _WavePainter(),
            ),
          ),
          // Titik dekorasi kiri atas
          Positioned(
            top: 16,
            left: 20,
            child: Column(
              children: List.generate(
                3,
                (_) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: List.generate(
                      3,
                      (__) => Container(
                        margin: const EdgeInsets.only(right: 6),
                        width: mobile ? 3 : 4,
                        height: mobile ? 3 : 4,
                        decoration: BoxDecoration(
                          color: _blue.withOpacity(0.25),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Konten utama
          child,
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// WAVE PAINTER
// ─────────────────────────────────────────────────────────────────────────────
class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final p1 = Paint()..color = _blue.withOpacity(0.18);
    final path1 = Path()
      ..moveTo(0, h * 0.55)
      ..cubicTo(w * 0.25, h * 0.35, w * 0.55, h * 0.75, w * 0.80, h * 0.45)
      ..cubicTo(w * 0.90, h * 0.30, w * 0.95, h * 0.50, w, h * 0.40)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(path1, p1);

    final p2 = Paint()..color = _blue.withOpacity(0.35);
    final path2 = Path()
      ..moveTo(0, h * 0.70)
      ..cubicTo(w * 0.30, h * 0.50, w * 0.60, h * 0.85, w * 0.85, h * 0.60)
      ..cubicTo(w * 0.92, h * 0.50, w * 0.96, h * 0.65, w, h * 0.58)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(path2, p2);

    final p3 = Paint()..color = _blue.withOpacity(0.65);
    final path3 = Path()
      ..moveTo(0, h * 0.82)
      ..cubicTo(w * 0.20, h * 0.68, w * 0.50, h * 0.95, w * 0.75, h * 0.78)
      ..cubicTo(w * 0.88, h * 0.68, w * 0.94, h * 0.80, w, h * 0.75)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(path3, p3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─────────────────────────────────────────────────────────────────────────────
// MINI CHART
// ─────────────────────────────────────────────────────────────────────────────
class _MiniChart extends StatelessWidget {
  const _MiniChart();

  @override
  Widget build(BuildContext context) => CustomPaint(painter: _ChartPainter());
}

class _ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final gridPaint = Paint()
      ..color = Colors.grey.withOpacity(0.15)
      ..strokeWidth = 0.5;
    for (int i = 1; i <= 4; i++) {
      canvas.drawLine(Offset(0, h * i / 5), Offset(w, h * i / 5), gridPaint);
    }

    final linePaint = Paint()
      ..color = _blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [_blue.withOpacity(0.20), _blue.withOpacity(0.0)],
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    final points = [
      0.45,
      0.55,
      0.40,
      0.50,
      0.45,
      0.35,
      0.30,
      0.40,
      0.35,
      0.25,
      0.20,
      0.15,
    ];
    final xs = List.generate(points.length, (i) => w * i / (points.length - 1));
    final ys = points.map((p) => h * p).toList();

    final linePath = Path()..moveTo(xs[0], ys[0]);
    final fillPath = Path()..moveTo(xs[0], ys[0]);

    for (int i = 1; i < points.length; i++) {
      final cpx1 = xs[i - 1] + (xs[i] - xs[i - 1]) * 0.5;
      final cpx2 = xs[i] - (xs[i] - xs[i - 1]) * 0.5;
      linePath.cubicTo(cpx1, ys[i - 1], cpx2, ys[i], xs[i], ys[i]);
      fillPath.cubicTo(cpx1, ys[i - 1], cpx2, ys[i], xs[i], ys[i]);
    }

    final closedFill = Path.from(fillPath)
      ..lineTo(xs.last, h)
      ..lineTo(xs.first, h)
      ..close();

    canvas.drawPath(closedFill, fillPaint);
    canvas.drawPath(linePath, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
