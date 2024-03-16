import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinnovate/models/product_model.dart';
import 'package:vinnovate/providers/home_provider.dart';
import 'package:vinnovate/utils/colors_utils.dart';
import 'package:vinnovate/utils/responsive_utils.dart';
import 'package:vinnovate/widgets/custom_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scrollcontroller = ScrollController();
  int limit = 10;
  late Provider provider;

  @override
  void initState() {
    super.initState();

    Provider.of<HomeProvider>(context, listen: false).fetchData(limit: 10);

    scrollcontroller.addListener(() {
      if (scrollcontroller.position.maxScrollExtent == scrollcontroller.offset) {
        setState(() {
          limit += 5;
          Provider.of<HomeProvider>(context, listen: false).fetchData(limit: limit);
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = ResponsiveUtils.screenWidth(context);
    double height = ResponsiveUtils.screenHeight(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Products"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.keyboard_arrow_left_rounded,
              size: 40,
            )),
      ),
      body: Padding(
          padding: EdgeInsets.all(width * 0.04),
          child: Consumer<HomeProvider>(builder: (context, homeProvider, child) {
            List<ProductModel> product = homeProvider.products;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Showing ${product.length} Products",
                  style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.greyColor),
                ),
                Expanded(
                    child: ListView.builder(
                  controller: scrollcontroller,
                  physics: const BouncingScrollPhysics(),
                  itemCount: product.length + 1,
                  itemBuilder: (context, index) {
                    if (index < product.length) {
                      var item = product[index];
                      return CustomListWidget(
                          width: width,
                          height: height,
                          title: item.title!,
                          subtitle: item.category!,
                          imageUrl: item.image!,
                          price: item.price.toString(),
                          rating: item.rating!.rate.toString(),
                          ratingCount: item.rating!.count!);
                    } else {
                      return Center(
                        child: homeProvider.isLoading == true ? CircularProgressIndicator() : SizedBox(),
                      );
                    }
                  },
                ))
              ],
            );
          })),
    );
  }
}
