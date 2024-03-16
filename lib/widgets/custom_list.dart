import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:vinnovate/utils/colors_utils.dart';

class CustomListWidget extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String price;
  final String rating;
  final int ratingCount;

  const CustomListWidget({
    super.key,
    required this.width,
    required this.height,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.ratingCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: EdgeInsets.only(top: height * 0.01),
      padding: EdgeInsets.all(width * 0.01),
      decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(width * 0.05)),
      child: Row(
        children: [
          Container(
            width: width * 0.26,
            height: height * 0.10,
            margin: EdgeInsets.all(height * 0.01),
            decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
                color: AppColors.greyColor,
                borderRadius: BorderRadius.circular(width * 0.04)),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: width * 0.55,
                    child: Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    )),
                SizedBox(height: height * 0.005),
                SizedBox(
                    width: width * 0.55,
                    child: Text(
                      subtitle,
                      style: const TextStyle(color: AppColors.greyColor),
                    )),
                SizedBox(height: height * 0.01),
                Row(
                  children: [
                    RatingBar.builder(
                      itemSize: width * 0.04,
                      initialRating: double.parse(rating),
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      glow: false,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                    SizedBox(width: width * 0.01),
                    Text(
                      "( $rating )",
                      style: const TextStyle(fontSize: 12, color: AppColors.greyColor),
                    ),
                    SizedBox(width: width * 0.01),
                    Text(
                      "( $ratingCount )",
                      style: const TextStyle(fontSize: 12, color: AppColors.greyColor),
                    ),
                    const Spacer(),
                    Text(
                      "\$$price",
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
