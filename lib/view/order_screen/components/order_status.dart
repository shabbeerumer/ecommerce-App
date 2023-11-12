import 'package:flutter_e_commerce_app/consts/packege.dart';

order_status(icon, color, title, showdone) {
  return ListTile(
    leading: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: color)),
        child: Icon(
          icon,
          color: color,
        )),
    trailing: SizedBox(
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
          ),
          showdone ? const Icon(Icons.done) : Container()
        ],
      ),
    ),
  );
}
