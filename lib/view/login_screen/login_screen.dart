import 'package:flutter_e_commerce_app/consts/packege.dart';

class login_screen extends StatefulWidget {
  const login_screen({Key? key}) : super(key: key);

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool isloading = false;

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: MediaQueryu.getScreenHeight(context),
          width: MediaQueryu.getScreenWidth(context),
          child: Column(
            children: [
              Image.asset(
                'assets/images/eCommerce.png',
                width: MediaQueryu.getScreenWidth(context) * .60,
              ),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * 0.02,
              ),
              textformfieldwidget('email', context, emailcontroller, false),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * 0.02,
              ),
              textformfieldwidget(
                  'Password', context, passwordcontroller, true),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * 0.02,
              ),
              isloading
                  ? lodingindicator()
                  : Buttons(
                      'login',
                      context,
                      redcolor,
                      whitecolor,
                      () async {
                        setState(() {
                          isloading = true;
                        });
                        try {
                          await loginmethod(emailcontroller.text.toString(),
                              passwordcontroller.text.toString(), context);
                        } catch (e) {
                          VxToast.show(context, msg: 'Something went wrong');
                        } finally {
                          setState(() {
                            isloading = false;
                          });
                        }
                      },
                    ),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * 0.01,
              ),
              Text(
                "don't have an accoumt?",
                style: TextStyle(
                    fontSize: MediaQueryu.getScreenHeight(context) * 0.02),
              ),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * 0.01,
              ),
              Buttons('signin', context, bluecolor, whitecolor, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const signin_screen()));
              }),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * 0.01,
              ),
              Text(
                'login with',
                style: TextStyle(
                    fontSize: MediaQueryu.getScreenHeight(context) * 0.03),
              ),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/google.png',
                    height: MediaQueryu.getScreenHeight(context) * .05,
                  ),
                  SizedBox(
                    width: MediaQueryu.getScreenWidth(context) * 0.03,
                  ),
                  Image.asset(
                    'assets/images/facebook.png',
                    height: MediaQueryu.getScreenHeight(context) * .05,
                  ),
                  SizedBox(
                    width: MediaQueryu.getScreenWidth(context) * 0.03,
                  ),
                  Image.asset(
                    'assets/images/twitter.png',
                    height: MediaQueryu.getScreenHeight(context) * .05,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
