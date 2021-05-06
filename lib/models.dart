import 'package:flutter/cupertino.dart';

class UserInfo extends ChangeNotifier {
  bool _isDriver = false;
  bool _isPassenger = false;
  String driverAddress = "1301 Prosperity Road";
  String driverCity = "Bolehland";
  String driverPoscode = "78990";

  String passengerAddress = "56 Climaru Avenue";
  String passengerCity = "BoiCity";
  String passengerPoscode = "50600";
  

  void clearAll() {
    _isDriver = false;
    _isPassenger = false;
  }

  void setAsDriver() {
    _isDriver = true;
    notifyListeners();
  }

  void unsetAsDriver() {
    _isDriver = false;
    notifyListeners();
  }

  void setAsPassenger(){
    _isPassenger = true;
    notifyListeners();
  }

  void unsetAsPassenger(){
    _isPassenger = false;
    notifyListeners();
  }

  bool get isDriver => _isDriver;
  bool get isPassenger => _isPassenger;



}