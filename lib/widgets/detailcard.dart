import 'package:flutter_e_commerce_app/consts/packege.dart';

detailcard(String count, String title, height, width) {
  return Container(
    height: height,
    width: width,
    decoration:
        BoxDecoration(color: redcolor, borderRadius: BorderRadius.circular(10)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          count,
          style:
              const TextStyle(color: whitecolor, fontWeight: FontWeight.bold),
        ),
        Text(
          title,
          style:
              const TextStyle(color: whitecolor, fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
}
