import 'package:flutter_e_commerce_app/consts/packege.dart';

homebuttons(String lable, icon, height, width, VoidCallback ontap, iconhight,
    iconwidth) {
  return InkWell(
    onTap: ontap,
    child: Container(
      decoration: BoxDecoration(
          color: whitecolor, borderRadius: BorderRadius.circular(10)),
      width: width,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            height: iconhight,
            width: iconwidth,
          ),
          Text(
            lable,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    ),
  );
}
