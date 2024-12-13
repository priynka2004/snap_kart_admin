import 'package:flutter/material.dart';
import 'package:snap_kart_admin/cart/model/cart_model.dart';
import 'package:snap_kart_admin/cart/model/cart_response_model.dart';
import 'package:snap_kart_admin/cart/service/cart_service.dart';
import 'package:snap_kart_admin/service/app_util.dart';


class CartProvider extends ChangeNotifier {
  CartProvider(this.cartService);

  final CartService cartService;
  bool isLoading=false;
  String? error;

  CartResponse? cartResponse;


  Future<void> addToCart(CartModel cartModel) async {
    try {
      isLoading = true;
      error = null;


      final isSuccess = await cartService.addToCart(cartModel);

      if (isSuccess) {
        AppUtil.showToast('Item added to cart successfully');
      } else {
        AppUtil.showToast('Failed to add item to cart');
      }
      notifyListeners();

    } catch (e) {
      error = e.toString();
      AppUtil.showToast('Error: $error');
    } finally {
      isLoading = false;
    }
  }

  Future<void> fetchCartItems() async {
    try {
      isLoading = true;
      notifyListeners();


      final response = await cartService.fetchCartItems();
      print('API Response: ${response?.toJson()}');


      if (response != null && response.items != null && response.items!.isNotEmpty) {
        cartResponse = response;
        print('Cart items updated: ${cartResponse?.items}');
      } else {
        cartResponse = null;
        print('No items found in the cart');
      }
    } catch (e) {
      print('Error in fetchCartItems: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteCartItem(String id) async {
    try {
      isLoading = true;
      notifyListeners();

      final isSuccess = await cartService.deleteCart(id);
      if (isSuccess) {
        print('Item deleted successfully');
        await fetchCartItems();
      } else {
        throw 'Unable to delete cart item';
      }
    } catch (e) {
      print('Error in deleteCartItem: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateToCartQuantity(CartModel cartModel) async {
    try {
      isLoading = true;
      notifyListeners();

      final isSuccess = await cartService.updateToCartQuantity(cartModel);

      if (isSuccess) {
        final item = cartResponse?.items?.firstWhere(
              (item) => item.product?.id == cartModel.productId,
        );

        if (item != null) {
          item.quantity = cartModel.quantity;
          notifyListeners();
        }

        AppUtil.showToast('${cartModel.quantity} Quantity updated');
      } else {
        AppUtil.showToast('Failed to update quantity');
      }
    } catch (e) {
      error = e.toString();
      AppUtil.showToast('Error: $error');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> clearCart() async {
    try {
      isLoading = true;
      notifyListeners();

      final isSuccess = await cartService.clearCart();
      if (isSuccess) {
        cartResponse = null;
        await fetchCartItems();
        print('Cart cleared successfully');
      } else {
        throw 'Failed to clear the cart';
      }
    } catch (e) {
      print('Error in clearCart: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


}