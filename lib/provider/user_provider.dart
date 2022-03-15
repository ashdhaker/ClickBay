import 'package:clickbay_flutter/models/user.dart' as model;
import 'package:clickbay_flutter/resources/auth_method.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  model.User? _user;
  final AuthMethods _authMethods =AuthMethods();
  
  model.User get getUser => _user!;
  
  Future<void> refreshUser() async{
    // WidgetsFlutterBinding.ensureInitialized();
    model.User user = await _authMethods.getUserDetails();
    
    _user=user;
    notifyListeners();
  }
  
}