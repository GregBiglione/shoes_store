import 'package:flutter/material.dart';
import 'package:shoes_store/data/service.dart';
import 'package:shoes_store/presentation/ressource/color_manager.dart';
import 'package:shoes_store/presentation/ressource/string_manager.dart';
import 'package:shoes_store/presentation/ressource/style_manager.dart';

import '../../app/function.dart';
import '../../domain/model/previous_purchase.dart';
import '../../domain/model/product.dart';

class PreviousPurchaseScreen extends StatefulWidget {
  final List<Product> productList;

  const PreviousPurchaseScreen({super.key, required this.productList});

  @override
  State<PreviousPurchaseScreen> createState() => _PreviousPurchaseScreenState();
}

class _PreviousPurchaseScreenState extends State<PreviousPurchaseScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PreviousPurchase>>(
        future: getPreviousPurchase(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<PreviousPurchase> previousPurchaseList = snapshot.data!;

            return FutureBuilder<List>(
              future: getPurchaseStatus(),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  List deliveredProductList = snapshot.data!;

                  return Scaffold(
                    appBar: AppBar(
                      title: Text(
                        StringManager.previousPurchase,
                        style: TextStyle(
                          color: ColorManager.white,
                        ),
                      ),
                      backgroundColor: ColorManager.black,
                      iconTheme: IconThemeData(
                        color: ColorManager.white, //change your color here
                      ),
                    ),
                    body: ListView.builder(
                      itemCount: previousPurchaseList.length,
                      itemBuilder: (context, index) {
                        PreviousPurchase previousPurchase = previousPurchaseList.elementAt(index);
                        Product? product;
                        bool isDelivered = deliveredProductList.contains(previousPurchase.docId);

                        for(Product p in widget.productList) {
                          if(previousPurchase.priceReference.contains(p.priceId)) {
                            product = p;
                            break;
                          }
                        }

                        if(product == null) {
                          return const SizedBox();
                        }

                        return ListTile(
                          leading: Image.network(product.imageUrl),
                          title: Text(
                            product.name,
                            style: getSemiBoldStyle(color: ColorManager.black),
                          ),
                          subtitle: Text(
                              isDelivered
                                  ? StringManager.delivered
                                  : StringManager.onTheWay,
                            style: getRegularStyle(color: ColorManager.black),
                          ),
                          trailing: Text(
                            "\$${addZero(previousPurchase.pricePaid.toString())}",
                            style: getSemiBoldStyle(color: ColorManager.black),
                          ),
                        );
                      },
                    ),
                  );
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return loading(StringManager.loadingDeliveredPurchase);
                } else {
                  return const SizedBox();
                }
              }
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return loading(StringManager.loadingPreviousPurchase);
          } else {
            return const SizedBox();
          }
        });
  }
}

/*return Scaffold(
                  appBar: AppBar(
                    title: Text(
                      StringManager.previousPurchase,
                      style: TextStyle(
                        color: ColorManager.white,
                      ),
                    ),
                    backgroundColor: ColorManager.black,
                    iconTheme: IconThemeData(
                      color: ColorManager.white, //change your color here
                    ),
                  ),
                  body: ListView.builder(
                    itemCount: previousPurchaseList.length,
                    itemBuilder: (context, index) {
                      PreviousPurchase previousPurchase = previousPurchaseList.elementAt(index);
                      Product? product;

                      for(Product p in widget.productList) {
                        if(previousPurchase.priceReference.contains(p.priceId)) {
                          product = p;
                          break;
                        }
                      }

                      if(product == null) {
                        return const SizedBox();
                      }

                      return ListTile(
                        leading: Image.network(product.imageUrl),
                        title: Text(
                          product.name,
                          style: getSemiBoldStyle(color: ColorManager.black),
                        ),
                        subtitle: Text(
                          StringManager.onTheWay,
                          style: getRegularStyle(color: ColorManager.black),
                        ),
                        trailing: Text(
                            "\$${addZero(previousPurchase.pricePaid.toString())}",
                          style: getSemiBoldStyle(color: ColorManager.black),
                        ),
                      );
                    },
                  ),
                );*/
