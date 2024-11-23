import 'package:flutter/cupertino.dart';
import 'package:snap_kart_admin/product/model/product_model.dart';
import 'package:snap_kart_admin/product/service/product_service.dart';
import 'package:snap_kart_admin/service/app_util.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> productList = [];
  ProductService productService;
  String? errorMessage;
  bool isLoading = false;

  ProductProvider(this.productService);

  Future<void> fetchProducts() async {
    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    try {
      productList = await productService.fetchProducts();
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
      productList = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      errorMessage = null;
      bool success = await productService.addProduct(product);
      if (success) {
        AppUtil.showToast('Product added successfully');
        productList.add(product); // Update local list if needed
        notifyListeners();
      } else {
        AppUtil.showToast('Failed to add product!');
      }
    } catch (e) {
      errorMessage = e.toString();
      AppUtil.showToast(errorMessage!);
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      errorMessage = null;
      bool success = await productService.deleteProduct(productId);
      if (success) {
        productList.removeWhere((product) => product.id == productId);
        AppUtil.showToast('Product deleted successfully');
        notifyListeners();
      } else {
        AppUtil.showToast('Failed to delete product!');
      }
    } catch (e) {
      errorMessage = e.toString();
      AppUtil.showToast(errorMessage!);
    } finally {
      notifyListeners();
    }
  }
}
