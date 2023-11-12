import 'package:flutter_e_commerce_app/consts/packege.dart';

class shopping_screen extends StatefulWidget {
  final cart_controller cc;
  shopping_screen({Key? key, required this.cc}) : super(key: key);

  @override
  State<shopping_screen> createState() => _shopping_screenState();
}

class _shopping_screenState extends State<shopping_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Shopping info'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              textformfieldwidget(
                  'Address', context, widget.cc.address_controller, false),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * 0.02,
              ),
              textformfieldwidget(
                  'city', context, widget.cc.city_controller, false),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * 0.02,
              ),
              textformfieldwidget(
                  'state', context, widget.cc.state_controller, false),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * 0.02,
              ),
              textformfieldwidget('postalcode', context,
                  widget.cc.postalcode_controller, false),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * 0.02,
              ),
              textformfieldwidget(
                  'phone', context, widget.cc.phone_controller, false),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * 0.02,
              ),
              Buttons('Continue', context, redcolor, whitecolor, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => payment_method(
                              cc: widget.cc,
                            )));
              })
            ],
          ),
        ),
      ),
    );
  }
}
