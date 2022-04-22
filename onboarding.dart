import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../constants/kcolor.dart';
import '../../registration/register.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding>
    with TickerProviderStateMixin {
  late TabController controller;

  int position = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 3, vsync: this);
    controller.addListener(() {
      setState(() {
        position = controller.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        body: Stack(
          children: [
            TabBarView(
              controller: controller,
              children: [
                page(
                  context,
                  height: height,
                  width: width,
                  controller: controller,
                  backgroundImage: "assets/onboarding/step1.jpeg",
                  title: "Hi! We’re Sil",
                  subtitle:
                      "You simply turn on the phone, we will make sure you have a best Banking Experience",
                ),
                page(
                  context,
                  height: height,
                  width: width,
                  controller: controller,
                  backgroundImage: "assets/onboarding/step2.jpeg",
                  title: "More & More Choices",
                  subtitle:
                      "With a large number of partner Banks, we can serve most of your banking preferences.",
                ),
                page(
                  context,
                  height: height,
                  width: width,
                  controller: controller,
                  backgroundImage: "assets/onboarding/step3.jpeg",
                  title: "Manage all Accounts",
                  subtitle:
                      "With this Extensive Support, Sil will serve you the most professional way with the best quality",
                ),
              ],
            ),
            Positioned(
              left: width / 2.25,
              bottom: height / 7,
              child: AnimatedSmoothIndicator(
                activeIndex: position,
                count: 3,
                effect: ExpandingDotsEffect(
                    dotHeight: 4,
                    dotWidth: 4,
                    expansionFactor: 6,
                    // strokeWidth: 100,
                    dotColor: Colors.white.withOpacity(0.3),
                    activeDotColor: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget page(
  context, {
  required double height,
  required double width,
  required TabController controller,
  required String backgroundImage,
  required String title,
  required String subtitle,
}) {
  return SizedBox(
    height: height,
    width: width,
    child: Stack(
      fit: StackFit.expand,
      children: [
        ColorFiltered(
          colorFilter: const ColorFilter.mode(
              Colors.redAccent,BlendMode.overlay),
          child: Image.asset(
            backgroundImage,
            fit: BoxFit.cover,
            // color: primaryColor.withOpacity(.2),
          ),
        ),
        Column(
          children: [
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 37,
                      width: 38,
                      child: Image.asset("assets/icons/corner_icon.png"),
                    ),
                    const Spacer(),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: Feedback.wrapForTap(() {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => const Register(),
                          ),
                        );
                      }, context),
                      child: Text(
                        "Skip",
                        style: GoogleFonts.lato(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Spacer(),
            Text(title,
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                    color: Colors.white)),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: Text(subtitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.white)),
            ),
            SizedBox(
              height: height / 6,
            ),
            const Spacer(),
            SizedBox(
              // color: Colors.white.withOpacity(0.6),
              width: width,
              height: height / 10,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: ElevatedButton(
                  onPressed: () {
                    if (controller.index < 2) {
                      controller.animateTo(controller.index + 1);
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => const Register(),
                        ),
                      );
                    }
                  },
                  child: Text(
                    "NEXT",
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.lightBlueAccent,
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1000.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}
