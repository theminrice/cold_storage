import '../providers/product_provider.dart';

class ProductRepository {
  final ProductProvider api;

  ProductRepository({required this.api});

  // Mengolah data produk dari API
  Future<List<dynamic>?> fetchAllProducts() async {
    final response = await api.getProducts();
    if (response.status.hasError) {
      return Future.error(response.statusText ?? "Terjadi kesalahan");
    } else {
      return response.body['data']; // Mengembalikan array data dari Node.js
    }
  }
}
