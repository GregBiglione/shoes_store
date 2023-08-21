import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/model/product.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
    quantity: 0,
  );
}