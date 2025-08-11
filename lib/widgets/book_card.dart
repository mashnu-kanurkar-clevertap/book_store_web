import 'package:clevertap_plugin/clevertap_plugin.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/book.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class BookCard extends StatelessWidget {
  final Book book;
  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl: book.image,
              placeholder: (ctx, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (ctx, url, err) => const Icon(Icons.broken_image),
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(book.title, maxLines: 2, overflow: TextOverflow.ellipsis),
                Text(book.authors, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 6),
                ElevatedButton(
                  onPressed: () {
                    var eventData = {
                      'id': book.id,
                      'bookName': book.title,
                      'author': book.authors,
                      'price': book.price,
                      "imageUrl": book.image
                    };
                    CleverTapPlugin.recordEvent("Added To cart", eventData);
                    cart.addToCart(book);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Book added to cart')));
                  },
                  child: const Text('Add to Cart'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}