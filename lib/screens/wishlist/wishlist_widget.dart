import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:liquor_purchase_app/Widgets/heart_btn.dart';
import 'package:liquor_purchase_app/Widgets/text_widget.dart';
import 'package:liquor_purchase_app/inner_screens/product_details.dart';
import 'package:liquor_purchase_app/models/wishlist_model.dart';
import 'package:provider/provider.dart';

import '../../providers/products_provider.dart';
import '../../providers/wishlist_provider.dart';
import '../../services/utils.dart';

class WishlistWidget extends StatelessWidget {
  const WishlistWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    final wishlistModel = Provider.of<WishlistModel>(context);

    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final getcurrProduct =
        productProvider.findProdById(wishlistModel.productId);

    double usedPrice = getcurrProduct.isOnSale
        ? getcurrProduct.salePrice
        : getcurrProduct.price;
    bool? _isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(getcurrProduct.id);
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ProductDetails.routeName,
              arguments: wishlistModel.productId);
        },
        child: Container(
          height: size.height * 0.20,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border.all(color: color, width: 1),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(children: [
            Flexible(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.only(left: 8),
                // width: size.width * 0.2,
                height: size.width * 0.25,
                child: FancyShimmerImage(
                  imageUrl: getcurrProduct.imageUrl,
                  boxFit: BoxFit.fill,
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            IconlyLight.bag,
                            color: color,
                          ),
                        ),
                        HeartBTN(
                          productId: getcurrProduct.id,
                          isInWishlist: _isInWishlist,
                        )
                      ],
                    ),
                  ),
                  TextWidget(
                    text: getcurrProduct.title,
                    color: color,
                    textSize: 20.0,
                    maxLines: 2,
                    isTitle: true,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextWidget(
                    text: 'Rs ${usedPrice.toStringAsFixed(2)}',
                    color: color,
                    textSize: 18.0,
                    maxLines: 1,
                    isTitle: true,
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
