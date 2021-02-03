import 'package:fluttertoast/fluttertoast.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

void showPublicToast({
  String msg,
  double fontSize = kDefaultSmallMargin,
  ToastGravity gravity = ToastGravity.CENTER,
}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: gravity,
    timeInSecForIosWeb: 1,
    backgroundColor: kAppGreyA,
    textColor: kAppWhite,
    fontSize: fontSize,
  );
}
