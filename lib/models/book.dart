class Book {
  final String id;
  final String title;
  final String subtitle;
  final String authors;
  final String image;
  final double price;

  Book({required this.id, required this.title, required this.subtitle, required this.authors, required this.image, required this.price});

  factory Book.fromJson(Map<String, dynamic> j) => Book (
    id: j['id'],
    title: j['title'],
    subtitle: j['subtitle'] ?? '',
    authors: j['authors'] ?? '',
    image: j['image'] ?? '',
    price: j['price']?? 100
  );
}
