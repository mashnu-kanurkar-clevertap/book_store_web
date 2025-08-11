import 'package:flutter/material.dart';
import '../models/book.dart';

class CartProvider with ChangeNotifier {
  final List<Book> _cart = [];

  List<Book> get cart => _cart;

  void addToCart(Book book) {
    _cart.add(book);
    notifyListeners();
  }

  void removeFromCart(Book book) {
    _cart.remove(book);
    notifyListeners();
  }

  double get total => _cart.fold(0, (sum, b) => sum + b.price);
}
