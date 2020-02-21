import 'package:google_sign_in/google_sign_in.dart';
import 'sheet_row.dart';

final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['https://www.googleapis.com/auth/spreadsheets']);

const String sheetId = '1QAzPiIC-C6yrLt_50GGB5czH60mFEXIZt9yPSJIKQao';
const String accessEmail = 'ashish.warty@gmail.com';

SheetRow sheetRow = SheetRow();
