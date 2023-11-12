import 'package:flutter_e_commerce_app/consts/packege.dart';

featuredcategoriesbuttons(
    icon, iconhight, BuildContext context, title, subcategories) {
  return Padding(
    padding: EdgeInsets.only(left: MediaQueryu.getScreenWidth(context) * 0.01),
    child: InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => category_detail_screen(
                      title: title,
                      subcategories: subcategories,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        width: 200,
        decoration: BoxDecoration(
            color: whitecolor, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQueryu.getScreenWidth(context) * 0.03),
              child: Image.asset(
                icon,
                height: iconhight,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              width: MediaQueryu.getScreenWidth(context) * 0.02,
            ),
            Text(title)
          ],
        ),
      ),
    ),
  );
}
