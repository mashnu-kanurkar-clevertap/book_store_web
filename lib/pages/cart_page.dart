import 'package:clevertap_plugin/clevertap_plugin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: cart.cart
                  .map((book) => ListTile(
                        leading: Image.network(book.image, width: 40),
                        title: Text(book.title),
                        subtitle: Text(book.authors),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle),
                          onPressed: () => cart.removeFromCart(book),
                        ),
                      ))
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text('Total: ₹${cart.total}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: (){
                    triggerChargedEvent(cart.cart, cart.total, "Amazon Pay");
                    showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Order Confirmed'),
                      content: const Text('Thank you for your purchase!'),
                      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
                    ),
                  );
                  },
                  child: const Text('Checkout'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void triggerChargedEvent(List<Book> cartItems, double total, String paymentMethod) {
    final chargeDetails = {
      'total': total.toStringAsFixed(2),
      'payment': paymentMethod,
    };

    final items = cartItems.map((book) => {
      'id': book.id,
      'bookName': book.title,
      'author': book.authors,
      'price': book.price,
      "imageUrl": book.image
    }).toList();

    CleverTapPlugin.recordChargedEvent(chargeDetails, items);
  }
}