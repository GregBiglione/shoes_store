import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shoes_store/app/constant/route.dart';
import 'package:shoes_store/data/service.dart';
import 'package:shoes_store/presentation/checkout/checkout_view.dart';
import 'package:shoes_store/presentation/ressource/color_manager.dart';
import 'package:shoes_store/presentation/ressource/size_manager.dart';
import 'package:shoes_store/presentation/ressource/string_manager.dart';
import 'package:shoes_store/presentation/ressource/style_manager.dart';

import '../../app/constant/constant.dart';
import '../../app/function.dart';
import '../../domain/model/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  var logger = Logger();
  bool isLoadingPayment = false;
  String? error = "";

  @override
  Widget build(BuildContext context) {
    return isLoadingPayment
        ? loading(processPayment)
        : FutureBuilder<List<Product>>(
            future: getProducts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Product> productList = snapshot.data!;

                return Scaffold(
                  appBar: AppBar(
                    title: Text(
                      StringManager.appName,
                      style: TextStyle(
                        color: ColorManager.white,
                      ),
                    ),
                    backgroundColor: ColorManager.black,
                    actions: [
                      // History button ----------------------------------------
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context,
                              Routes.previousPurchaseRoute,
                              arguments: productList,
                          );
                        },
                        icon: Icon(
                          Icons.history,
                          color: ColorManager.white,
                        ),
                      ),
                      // Log out button ----------------------------------------
                      IconButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                        },
                        icon: Icon(
                          Icons.exit_to_app,
                          color: ColorManager.white,
                        ),
                      ),
                    ],
                  ),
                  body: GridView.builder(
                    itemCount: productList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.7,
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      Product currentProduct = productList.elementAt(index);

                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(SizeManager.s8),
                          child: Column(
                            children: [
                              SizedBox(
                                  height: SizeManager.s170,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      SizeManager.s8,
                                    ),
                                    child: Image.network(
                                      currentProduct.imageUrl,
                                      fit: BoxFit.cover,
                                      alignment: Alignment.center,
                                      //fit: BoxFit.cover,
                                    ),
                                  )),
                              Text(
                                currentProduct.name,
                                style:
                                    getSemiBoldStyle(color: ColorManager.black),
                              ),
                              Text(
                                currentProduct.description,
                                style:
                                    getRegularStyle(color: ColorManager.grey2),
                              ),
                              const SizedBox(
                                height: SizeManager.s10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "\$${addZero(currentProduct.price)}",
                                    style: getSemiBoldStyle(
                                        color: ColorManager.black),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      displayBottomSheet(currentProduct);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            ColorManager.greenBuyButton),
                                    child: Text(
                                      StringManager.buy,
                                      style: TextStyle(
                                        color: ColorManager.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return loading(StringManager.loading);
              } else {
                return const SizedBox();
              }
            },
          );
  }

  //----------------------------------------------------------------------------
  // Display bottom sheet
  //----------------------------------------------------------------------------

  displayBottomSheet(Product product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(SizeManager.s18),
        topRight: Radius.circular(SizeManager.s18),
      )),
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              padding: const EdgeInsets.all(SizeManager.s8),
              height: SizeManager.s200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: SizeManager.s80,
                        child: Image.network(product.imageUrl),
                      ),
                      const SizedBox(
                        width: SizeManager.s10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: getSemiBoldStyle(color: ColorManager.black),
                          ),
                          SizedBox(
                            width: 20,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              initialValue: product.quantity.toString(),
                              textAlign: TextAlign.center,
                              onChanged: (value) {
                                setState(() {
                                  product.quantity = int.tryParse(value) ?? 1;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const Expanded(
                        child: SizedBox(
                          width: SizeManager.s5,
                        ),
                      ),
                      Text(
                        "\$${addZero(product.price)}",
                        style: getSemiBoldStyle(color: ColorManager.black),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    height: SizeManager.s50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        buyProduct(product);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.black,
                      ),
                      child: Text(
                        "Pay \$${addZero(calculateTotalPrice(product).toString())}",
                        style: getSemiBoldStyle(color: ColorManager.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  //----------------------------------------------------------------------------
  // Calculate total price
  //----------------------------------------------------------------------------

  calculateTotalPrice(Product product) {
    double totalPrice;

    totalPrice = double.parse(product.price) * product.quantity;

    return totalPrice;
  }

  //----------------------------------------------------------------------------
  // Buy product
  //----------------------------------------------------------------------------

  buyProduct(Product product) async {
    setState(() {
      isLoadingPayment = true;
    });

    DocumentReference documentReference = await FirebaseFirestore.instance.collection("users")
        .doc(uid)
        .collection("checkout_sessions")
        .add({
           "price": product.priceId,
           "quantity": product.quantity,
           "mode": payment,
           "success_url": successUrl,
           "cancel_url": cancelUrl,
        });

    documentReference.snapshots().listen((docSnapshot) async {
      if(docSnapshot.exists) {
        try {
         error = docSnapshot.get("error");
        } catch (e) {
          error = null;
        }

        if(error != null) {
          logger.e(error);

          setState(() {
            isLoadingPayment = false;
          });
        }
        else {
          String url = docSnapshot.get("url");
          goToPayment(url);
        }
        setState(() {
          isLoadingPayment = false;
        });
      }
    });
  }

  //----------------------------------------------------------------------------
  // Go to payment
  //----------------------------------------------------------------------------

  goToPayment(String url) async {
    var response = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CheckoutView(url: url),
        ));

    if(response == success) {
      // Payment successful ----------------------------------------------------
      displayDialog(successTitle, dialogButton);
    }
    else {
      // Payment failed --------------------------------------------------------
      displayDialog(failedTitle, dialogButton);
    }
    setState(() {
      isLoadingPayment = false;
    });
  }

  //----------------------------------------------------------------------------
  // Display dialog
  //----------------------------------------------------------------------------

  displayDialog(String title, String okButton) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.black,
              ),
              child: Text(
                okButton,
                style: TextStyle(
                    color: ColorManager.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
