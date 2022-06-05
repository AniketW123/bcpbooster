import 'package:date_format/date_format.dart';
import 'constants.dart';

SheetRow sheetRow = SheetRow();

class SheetRow {
  // Profile Info
  String firstName = '';
  String lastName = '';
  String email = '';
  String phoneNum = '';
  String gradYear = '';
  String address = '';
  String city = '';
  String state = '';
  String zip = '';

  // Membership Details
  String membershipType = 'Premium 4 Year';
  String jacketStyle = 'Male';
  String jacketSize = 'L';

  // Miscellaneous
  bool capPickedUp = false;
  bool jacketPickedUp = false;
  bool paymentConfirmed = false;
  bool boardInterest = false;
  bool volunteerInterest = true;

  List<String> getList() {
    List<String> list = [
      googleSignIn.currentUser!.email,
      formatDate(DateTime.now(), [mm, '-', dd, '-', yyyy, ' ', h, ':', nn, ' ', am]), // e.g. 02-20-2020 1:22 PM
      firstName,
      lastName,
      email,
      phoneNum,
      gradYear,
      address,
      city,
      state,
      zip,
      membershipType
    ];

    if (membershipType != 'Contact Info Only') {
      list.addAll([
        jacketStyle,
        jacketSize,
        _boolToString(jacketPickedUp),
        _boolToString(capPickedUp),
        '',
        _boolToString(paymentConfirmed),
        _boolToString(boardInterest),
        _boolToString(volunteerInterest)
      ]);
    }

    return list;
  }

  static String _boolToString(bool b) => b ? 'YES' : 'NO';
}