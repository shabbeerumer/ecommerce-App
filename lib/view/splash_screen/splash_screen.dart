import 'package:flutter_e_commerce_app/consts/packege.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({Key? key}) : super(key: key);

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      auth.currentUser == null
          ? Navigator.push(context,
              MaterialPageRoute(builder: (context) => const signin_screen()))
          : Navigator.push(
              context, MaterialPageRoute(builder: (context) => const home()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Align(
            alignment: Alignment.center,
            child: Image.asset('assets/images/eCommerce.png')),
      ]),
    );
  }
}
