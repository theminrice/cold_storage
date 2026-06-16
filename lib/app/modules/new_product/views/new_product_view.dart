import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/new_product_controller.dart';

class NewProductView extends GetView<NewProductController> {
  const NewProductView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NewProductView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'NewProductView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
