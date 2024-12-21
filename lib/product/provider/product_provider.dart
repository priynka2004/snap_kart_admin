
import 'package:flutter/foundation.dart';
import 'package:snap_kart_admin/product/model/add_product_model.dart';
import 'package:snap_kart_admin/product/service/product_service.dart';
import 'package:snap_kart_admin/service/app_util.dart';



class ProductProvider extends ChangeNotifier {
  List<ProductModel> productList = [];
  ProductService productService;
  String? errorMessage;

  ProductProvider(this.productService);

  Future fetchProduct() async {
    try {
      productList = await productService.fetchProducts();
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<bool> addProduct(ProductModel product) async {
    try {
      bool success = await productService.addProduct(product);
      if (success) {
        notifyListeners();
        return true; // Explicit return for success
      }
      return false; // Explicit return for failure
    } catch (e) {
      notifyListeners();
      return false; // Explicit return for failure in case of exceptions
    }
  }

  Future deleteProduct(String productId) async {
    errorMessage = null;
    try {
      bool success = await productService.deleteProduct(productId);
      if (success) {
        productList.removeWhere((product) => product.id == productId);
        notifyListeners();
        AppUtil.showToast('Product deleted successfully');
        return true;
      } else {
        errorMessage = 'Failed to delete product';
        notifyListeners();
        return false;
      }
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
      AppUtil.showToast(e.toString());
      return false;
    }
  }




  Future<bool> updateProduct(ProductModel updatedProduct) async {
    errorMessage = null;
    try {
      bool success = await productService.updateProducs(updatedProduct);

      if (success) {
        int index = productList.indexWhere((product) => product.id == updatedProduct.id);
        if (index != -1) {
          productList[index] = updatedProduct;
        }

        notifyListeners();
        AppUtil.showToast('Product updated successfully');
        return true;
      } else {
        errorMessage = 'Failed to update product';
        notifyListeners();
        AppUtil.showToast(errorMessage!);
        return false;
      }
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
      AppUtil.showToast(e.toString());
      return false;
    }
  }



  void updateProductImage(int index, String imagePath) {
    productList[index].image = imagePath;
    notifyListeners();
  }

}

