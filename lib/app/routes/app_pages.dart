import 'package:get/get.dart';

import '../modules/check_in/bindings/check_in_binding.dart';
import '../modules/check_in/views/check_in_view.dart';
import '../modules/check_out/bindings/check_out_binding.dart';
import '../modules/check_out/views/check_out_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/introduction/bindings/introduction_binding.dart';
import '../modules/introduction/views/introduction_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/map/bindings/map_binding.dart';
import '../modules/map/views/map_view.dart';
import '../modules/new_product/bindings/new_product_binding.dart';
import '../modules/new_product/views/new_product_view.dart';
import '../modules/rooms/bindings/rooms_binding.dart';
import '../modules/rooms/views/rooms_view.dart';
import '../modules/stock/bindings/stock_binding.dart';
import '../modules/stock/views/stock_view.dart';
import '../modules/transfer/bindings/transfer_binding.dart';
import '../modules/transfer/views/transfer_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.INTRODUCTION;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.INTRODUCTION,
      page: () => const IntroductionView(),
      binding: IntroductionBinding(),
    ),
    GetPage(
      name: _Paths.ROOMS,
      page: () => const RoomsView(),
      binding: RoomsBinding(),
    ),
    GetPage(
      name: _Paths.STOCK,
      page: () => const StockView(),
      binding: StockBinding(),
    ),
    GetPage(
      name: _Paths.MAP,
      page: () => const MapView(),
      binding: MapBinding(),
    ),
    GetPage(
      name: _Paths.NEW_PRODUCT,
      page: () => const NewProductView(),
      binding: NewProductBinding(),
    ),
    GetPage(
      name: _Paths.TRANSFER,
      page: () => const TransferView(),
      binding: TransferBinding(),
    ),
    GetPage(
      name: _Paths.CHECK_IN,
      page: () => const CheckInView(),
      binding: CheckInBinding(),
    ),
    GetPage(
      name: _Paths.CHECK_OUT,
      page: () => const CheckOutView(),
      binding: CheckOutBinding(),
    ),
  ];
}
