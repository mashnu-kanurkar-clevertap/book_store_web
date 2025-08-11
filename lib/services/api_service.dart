import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class ApiService {
  static const base = 'https://www.dbooks.org/api';
  Future<List<Book>> search(String q) async {
    final res = await http.get(Uri.parse('$base/search/$q'));
    if (res.statusCode == 200) {
      final arr = json.decode(res.body)['books'] as List;
      return arr.map((e) => Book.fromJson(e)).toList();
    }
    throw Exception('API failure');
  }
}
