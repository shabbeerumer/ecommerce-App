import 'package:flutter_e_commerce_app/consts/packege.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class category_screen extends StatefulWidget {
  const category_screen({Key? key}) : super(key: key);

  @override
  State<category_screen> createState() => _category_screenState();
}

class _category_screenState extends State<category_screen> {
  final Product_Controller _productController = Product_Controller();

  void initState() {
    super.initState();
    _productController.loadJsonData(); // Call the function here
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redcolor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Categories',
          style: TextStyle(color: whitecolor),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: GridView.builder(
            itemCount: 9,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 250,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8),
            itemBuilder: (context, index) {
              return Container(
                color: whitecolor,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => category_detail_screen(
                                  title: Categorieslist[index],
                                  subcategories: _productController
                                      .categories[index].subcategory,
                                )));
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        Categoriesimages[index],
                        height: MediaQueryu.getScreenHeight(context) * .20,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                          height: MediaQueryu.getScreenHeight(context) * 0.03),
                      Text(
                        Categorieslist[index],
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
