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

  String _boolToString(bool b) => b ? 'YES' : 'NO';
}