import 'package:blood_donation/constant/colors.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarousalImage extends StatefulWidget {
  const CarousalImage({Key? key}) : super(key: key);

  @override
  State<CarousalImage> createState() => _CarousalImageState();
}

class _CarousalImageState extends State<CarousalImage> {
  List<String> imageUrl = [
    "assets/slider1.png",
    "assets/slider2.png",
    "assets/slider3.png",
    "assets/slider4.png",
  ];
  int currIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CarouselSlider(
            items: imageUrl
                .map(
                  (item) => Container(
                      margin: EdgeInsets.all(18),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            item,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      )),
                )
                .toList(),
            options: CarouselOptions(
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() {
                  currIndex = index;
                });
              },
              aspectRatio: 18 / 10,
              enlargeCenterPage: false,
              viewportFraction: 1,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new DotsIndicator(
                dotsCount: imageUrl.length,
                position: currIndex,
                decorator: DotsDecorator(
                  activeColor: primary,
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
