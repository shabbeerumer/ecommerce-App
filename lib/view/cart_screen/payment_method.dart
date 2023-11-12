import 'package:flutter_e_commerce_app/consts/packege.dart';

class payment_method extends StatefulWidget {
  final cart_controller cc;

  payment_method({Key? key, required this.cc}) : super(key: key);

  @override
  State<payment_method> createState() => _payment_methodState();
}

class _payment_methodState extends State<payment_method> {
  var isloading = false;
  var paymentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Payment Method'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: paymentmethodimg.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      changepaymentindex(index);
                    },
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: paymentindex == index
                              ? redcolor
                              : transparentcolor,
                          width: 3,
                        ),
                      ),
                      margin: EdgeInsets.only(bottom: 8),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image.asset(
                            paymentmethodimg[index],
                            width: double.infinity,
                            height: 120,
                            fit: BoxFit.cover,
                            colorBlendMode: paymentindex == index
                                ? BlendMode.darken
                                : BlendMode.color,
                            color: paymentindex == index
                                ? blackcolor.withOpacity(0.2)
                                : transparentcolor,
                          ),
                          paymentindex == index
                              ? Transform.scale(
                                  scale: 1.3,
                                  child: Checkbox(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    activeColor: greencolor,
                                    value: true,
                                    onChanged: (value) {},
                                  ),
                                )
                              : Container(),
                          Positioned(
                            bottom: 3,
                            right: 12,
                            child: Text(
                              paymentmethod[index],
                              style: TextStyle(color: whitecolor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: isloading
                  ? lodingindicator()
                  : Buttons(
                      'Place my order',
                      context,
                      redcolor,
                      whitecolor,
                      () async {
                        setState(() {
                          isloading = true;
                        });

                        await widget.cc.placemyorder(
                            paymentmethod[paymentindex], widget.cc.totalp);
                        await widget.cc.clearcart();
                        VxToast.show(context, msg: 'order placed sucessfully');
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => home()));
                        setState(() {
                          isloading = false;
                        });
                      },
                    )),
          SizedBox(
            height: MediaQueryu.getScreenHeight(context) * 0.02,
          ),
        ],
      ),
    );
  }

  changepaymentindex(index) {
    setState(() {
      paymentindex = index;
    });
  }
}
