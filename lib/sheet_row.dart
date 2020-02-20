import 'package:date_format/date_format.dart';
import 'globals.dart';

class SheetRow {
  // Profile Info
  String firstName = '';
  String lastName = '';
  String email = '';
  String phoneNum = '';
  String address = '';
  String city = '';
  String state = '';
  String zip = '';

  // Membership Details
  bool isNewMember = true;
  String membershipType = 'Premium 4 Year';
  String jacketStyle = 'Male';
  String jacketSize = 'L';
  String sportsFormat = 'Digital';

  // Payment and Swag
  bool capPickedUp = false;
  bool jacketPickedUp = false;
  bool paymentConfirmed = false;
  // "MM-dd-yyyy hh:mm:ss a"
  List<String> getList() => [
    googleSignIn.currentUser.email,
    formatDate(DateTime.now(), [mm, '-', dd, '-', yyyy, ' ', h, ':', nn, ' ', am]), // e.g. 02-20-2020 1:22 PM
    firstName,
    lastName,
    email,
    phoneNum,
    address,
    city,
    state,
    zip,
    _boolToString(isNewMember),
    membershipType,
    jacketStyle,
    jacketSize,
    _boolToString(jacketPickedUp),
    _boolToString(capPickedUp),
    _boolToString(paymentConfirmed),
  ];

  String _boolToString(bool b) => b ? 'YES' : 'NO';
}