import 'package:get/get.dart';

class ProductProvider extends GetConnect {
  @override
  void onInit() {
    // Set URL dasar backend Node.js kamu di sini
    httpClient.baseUrl = 'http://localhost:3000/api/';
  }

  // Fungsi menembak API Node.js untuk ambil data stok/produk
  Future<Response> getProducts() => get('products');

  // Fungsi untuk upload gambar ke Node.js (yang nantinya diteruskan ke MinIO)
  Future<Response> uploadProductImage(List<int> imageBytes, String filename) {
    final formData = FormData({
      'file': MultipartFile(imageBytes, filename: filename),
    });
    return post('products/upload', formData);
  }
}
