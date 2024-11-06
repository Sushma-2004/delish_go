import 'package:delish_go/data/data_models/cart_product_model.dart';
import 'package:delish_go/data/data_models/product_model.dart';
import 'package:flutter/material.dart';

class CartManagementService {
  bool isLoading = false;
  var cartProductList = ValueNotifier<List<CartProductModel>>([]);
  var subTotal = ValueNotifier<double>(0.0);

  init() {
    cartProductList.addListener(calculate);
  }

  CartProductModel? getCartProductFromCart(ProductModel product) {
    List<String> idsInCart = [];
    for (var cartProduct in cartProductList.value) {
      idsInCart.add(cartProduct.product.documentId);
    }
    if (idsInCart.contains(product.documentId)) {
      var cartProduct = cartProductList.value.singleWhere(
          (element) => element.product.documentId == product.documentId);
      return cartProduct;
    } else {
      return null;
    }
  }

  void removeCartProduct(CartProductModel cartProduct) {
    int index = cartProductList.value.indexWhere((element) =>
        element.product.name == cartProduct.product.name);
    cartProductList.value = List.from(cartProductList.value)..removeAt(index);
    calculate();
  }

  updateCart(CartProductModel cartProduct) {
    List<String> idsInCart = [];
    for (var cartProduct in cartProductList.value) {
      idsInCart.add(cartProduct.product.documentId);
    }
    if (idsInCart.contains(cartProduct.product.documentId)) {
      int index = cartProductList.value.indexWhere((element) =>
          element.product.documentId == cartProduct.product.documentId);
      if (cartProduct.quantity == 0) {
        cartProductList.value = List.from(cartProductList.value)
          ..removeAt(index);
      } else if (index != -1) {
        cartProductList.value = List.from(cartProductList.value)
          ..[index] = cartProduct;
      }
    } else {
      if (cartProduct.quantity != 0) {
        var cartProductListTemp = List.from(cartProductList.value);
        cartProductListTemp.add(cartProduct);
        cartProductList.value = cartProductListTemp.cast<CartProductModel>();
      }
    }
    calculate();
  }

  List<CartProductModel> updateProductList(
      List<CartProductModel> listOfProduct) {
    List<CartProductModel> newListofProducts = [];
    for (var productInCart in listOfProduct) {
      if (productInCart.quantity != 0) {
        CartProductModel productTemp = productInCart;
        productTemp.quantity = productInCart.quantity;
        newListofProducts.add(productTemp);
      } else if (productInCart.quantity != 0) {
        productInCart.quantity = productInCart.quantity;
        newListofProducts.add(productInCart);
      } else if (productInCart.quantity == 0) {
        CartProductModel freeProductTemp = CartProductModel(
          product: productInCart.product,
          price: productInCart.price,
          quantity: productInCart.quantity,
        );
        newListofProducts.add(freeProductTemp);
      }
      continue;
    }
    return newListofProducts;
  }

  void clearCart() {
    cartProductList = ValueNotifier<List<CartProductModel>>([]);
    subTotal.value = 0.0;
    calculate();
  }

  void showLoading() {
    isLoading = true;
  }

  void closeLoading() {
    isLoading = false;
  }

  void calculate() {
    double total = 0.0;
    for (var cartProduct in cartProductList.value) {
      total += cartProduct.price * cartProduct.quantity;
    }
    subTotal.value = total;
  }
}
