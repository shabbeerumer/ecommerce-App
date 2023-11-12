import 'package:flutter_e_commerce_app/consts/packege.dart';

textformfieldwidget(String hinttext, BuildContext context,
    TextEditingController controller, bool obscureText) {
  return Container(
    padding: EdgeInsets.only(
        left: MediaQueryu.getScreenWidth(context) * 0.03,
        right: MediaQueryu.getScreenWidth(context) * 0.03),
    child: TextFormField(
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
          hintText: hinttext,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    ),
  );
}
