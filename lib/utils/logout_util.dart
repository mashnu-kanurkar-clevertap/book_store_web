import 'package:web/web.dart' as web;
import 'dart:js_interop';

@JS('clearCookies')
external void clearCookiesJS();

void logoutUser() {
  print("Clearing the local storage and cookies");
  // Clear localStorage
  web.window.localStorage.clear();

  // Clear sessionStorage
  web.window.sessionStorage.clear();

  // Clear browser cookies
  clearCookiesJS();

  // Optionally redirect to login page or reset app state
  print('✅ User logged out, storage and cookies cleared.');
}
