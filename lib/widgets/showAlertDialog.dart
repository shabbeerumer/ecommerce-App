import 'package:flutter_e_commerce_app/consts/packege.dart';

showAlertDialog(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        actions: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQueryu.getScreenHeight(context) * 0.01),
                const Text('Conform'),
                SizedBox(height: MediaQueryu.getScreenHeight(context) * 0.01),
                const Text('Are you sure you want to exit ?'),
                SizedBox(height: MediaQueryu.getScreenHeight(context) * 0.01),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                        onTap: () {
                          SystemNavigator.pop();
                        },
                        child: const Text('Yes')),
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text('No')),
                  ],
                )
              ],
            ),
          ),
        ],
      );
    },
  );
}
