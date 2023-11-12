import 'package:flutter_e_commerce_app/consts/packege.dart';

Buttons(String buttonname, BuildContext context, Color buttoncolor,
    Color textcolor, VoidCallback ontap) {
  return InkWell(
    onTap: ontap,
    child: Padding(
      padding: EdgeInsets.only(
          left: MediaQueryu.getScreenWidth(context) * 0.03,
          right: MediaQueryu.getScreenWidth(context) * 0.03),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: buttoncolor),
        child: Center(
            child: Text(
          buttonname,
          style: TextStyle(color: textcolor, fontWeight: FontWeight.bold),
        )),
      ),
    ),
  );
}
