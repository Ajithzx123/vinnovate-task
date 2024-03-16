import 'package:flutter/widgets.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:vinnovate/services/firebase_auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuthService _authService = FirebaseAuthService();

  final RoundedLoadingButtonController buttonController = RoundedLoadingButtonController();

  bool _isPasswordVisible = true;
  bool isLoading = false;

  bool get isPasswordVisible => _isPasswordVisible;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  Future<String?> signInWithEmailAndPassword(String email, String password) async {

    
    String? response = await _authService.signInWithEmailAndPassword(email, password);
    notifyListeners();

    isLoading = false;

    return response;
  }

  Future<void> signOut() async {
    await _authService.signOut();
    notifyListeners();
  }
}
