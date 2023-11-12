import 'package:flutter_e_commerce_app/consts/packege.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hc.getusername();
  }

  home_controller hc = home_controller();
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    var bottomitem = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.category), label: 'category'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart), label: 'cart_screen'),
      const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'account'),
    ];
    var bottombody = [
      const home_screen(),
      const category_screen(),
      const cart_screen(),
      const account_screen(),
    ];
    return WillPopScope(
      onWillPop: () async {
        showAlertDialog(context);
        return false;
      },
      child: Scaffold(
        body: bottombody[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: redcolor,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          items: bottomitem,
          type: BottomNavigationBarType.fixed,
          backgroundColor: whitecolor,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
