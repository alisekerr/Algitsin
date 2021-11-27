
/*import 'package:algitsin/extensions/size_extention.dart';
import 'package:algitsin/feature/algitsin/view/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePage createState() => _WelcomePage();
}

class _WelcomePage extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
    
        body: Container(
          color: Theme.of(context).dialogBackgroundColor,
          child: Padding(
            padding: EdgeInsets.all(10.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildWelcomeAnimation(),
                buildSellerGuestButton(context)
              ],
            ),
          ),
        ),
      )
    ;
  }

  Row buildSellerGuestButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(PageTransition(
                  child: const SellerLogin(),
                  type: PageTransitionType.fade));
            },
            child: SizedBox(
              width: 100.0.w,
              height: 60.0.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.arrow_left),
                  Text("Seller", style: Theme.of(context).textTheme.bodyText1)
                ],
              ),
            ),
            style: ElevatedButton.styleFrom(
                primary: Theme.of(context).scaffoldBackgroundColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0.sp)))),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(PageTransition(
                child: const SellerLogin(),
                type: PageTransitionType.rightToLeft));
          },
          child: SizedBox(
              width: 100.0.w,
              height: 60.0.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Guest", style: Theme.of(context).textTheme.bodyText1),
                  const Icon(Icons.arrow_right)
                ],
              )),
          style: ElevatedButton.styleFrom(
              primary: Theme.of(context).scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0.sp),
              )),
        ),
      ],
    );
  }

  Align buildWelcomeAnimation() {
    return Align(
        alignment: Alignment.center,
        child: SizedBox(
            width: 200.0.w,
            height: 200.0.h,
            child: Lottie.network(
                "https://assets7.lottiefiles.com/packages/lf20_30jzypta.json")));
  }
}*/
