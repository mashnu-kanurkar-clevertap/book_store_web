import 'package:book_store_web/pages/login_page.dart';
import 'package:book_store_web/utils/logout_util.dart';
import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/api_service.dart';
import '../widgets/book_card.dart';
import 'cart_page.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _controller = TextEditingController();
  List<Book> books = [];

  void searchBooks(String q) async {
    final result = await ApiService().search(q);
    setState(() => books = result);
  }

  @override
  void initState() {
    super.initState();
    searchBooks("philosophy");
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Commerce Dashboard'),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_cart),
                if (cart.cart.isNotEmpty)
                  Positioned(
                    right: 0,
                    child: CircleAvatar(
                      radius: 8,
                      child: Text('${cart.cart.length}', style: const TextStyle(fontSize: 10)),
                    ),
                  )
              ],
            ),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartPage())),
          ),
        IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.logout),

              ],
            ),
            onPressed: (){
              logoutUser();
              Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPage()));
            } 
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              onSubmitted: searchBooks,
              decoration: InputDecoration(
                hintText: 'Search books...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => searchBooks(_controller.text),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.6,
        ),
        itemCount: books.length,
        itemBuilder: (_, i) => BookCard(book: books[i]),
      ),
    );
  }
}