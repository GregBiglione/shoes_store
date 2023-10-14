import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoes_store/app/constant/constant.dart';
import 'package:shoes_store/domain/model/previous_purchase.dart';

import '../domain/model/product.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
String uid = FirebaseAuth.instance.currentUser!.uid;

//------------------------------------------------------------------------------
// Get product -----------------------------------------------------------------
//------------------------------------------------------------------------------

Future<List<Product>> getProducts() async {
  List<Product> productList = [];
  
  QuerySnapshot querySnapshot = await  _firestore.collection("products").get();

  for(var documentSnapshot in querySnapshot.docs) {
    Product product = await getProductFromDocumentSnapshot(documentSnapshot);
    productList.add(product);
  }

  return productList;
}

Future<Product> getProductFromDocumentSnapshot(DocumentSnapshot documentSnapshot) async {
  String price = "";
  String priceId = "";

  QuerySnapshot querySnapshot = await _firestore.collection("products")
      .doc(documentSnapshot.id)
      .collection("prices")
      .get();

  price = (querySnapshot.docs.first.get("unit_amount") / 100).toString();
  priceId = querySnapshot.docs.first.id;

  return Product(
    name: documentSnapshot.get("name"),
    description: documentSnapshot.get("description"),
    imageUrl: documentSnapshot.get("images")[0],
    price: price,
    priceId: priceId,
    quantity: 1,
  );
}

//------------------------------------------------------------------------------
// Get previous purchase -------------------------------------------------------
//------------------------------------------------------------------------------

Future<List<PreviousPurchase>> getPreviousPurchase() async {
  List<PreviousPurchase> previousPurchaseList = [];

  QuerySnapshot querySnapshot = await _firestore.collection("users")
      .doc(uid).collection("payments")
      .get();

  for(DocumentSnapshot documentSnapshot in querySnapshot.docs) {
    var status = documentSnapshot.get("status");

    if(status == succeeded) {
      String docId = documentSnapshot.id;
      double pricePaid = documentSnapshot.get("amount") / 100;
      DocumentReference priceReference = documentSnapshot.get("prices")[0];

      PreviousPurchase previousPurchase= PreviousPurchase(
        docId: docId,
        pricePaid: pricePaid,
        priceReference: priceReference.id,
      );

      previousPurchaseList.add(previousPurchase);
    }
  }
  return previousPurchaseList;
}

//------------------------------------------------------------------------------
// Get purchase status ---------------------------------------------------------
//------------------------------------------------------------------------------

Future<List> getPurchaseStatus() async {
  DocumentSnapshot documentSnapshot = await _firestore.collection("users")
      .doc(uid)
      .get();

  List deliveredProductList = documentSnapshot.get("delivered_products");

  return deliveredProductList;
}