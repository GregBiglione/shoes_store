import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoes_store/data/service.dart';
import 'package:shoes_store/presentation/ressource/color_manager.dart';
import 'package:shoes_store/presentation/ressource/size_manager.dart';
import 'package:shoes_store/presentation/ressource/string_manager.dart';
import 'package:shoes_store/presentation/ressource/style_manager.dart';

import '../../app/function.dart';
import '../../domain/model/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                          )
                        ),
                        Text(
                          currentProduct.name,
                          style: getSemiBoldStyle(color: ColorManager.black),
                        ),
                        Text(
                          currentProduct.description,
                          style: getRegularStyle(color: ColorManager.grey2),
                        ),
                        const SizedBox(
                          height: SizeManager.s10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                            "\$${addZero(currentProduct.price)}",
                              style: getSemiBoldStyle(color: ColorManager.black),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorManager.greenBuyButton
                              ),
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
        }
        else if(snapshot.connectionState == ConnectionState.waiting){
          return loading(StringManager.loading);
        }
        else{
          return const SizedBox();
        }
      },
    );
  }
}
