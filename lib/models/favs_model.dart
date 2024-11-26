// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<FavModel> favFromJson(String str) =>
    List<FavModel>.from(json.decode(str).map((x) => FavModel.fromJson(x)));

String welcomeToJson(List<FavModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FavModel {
  String id;
  String prodId;
  String quantity;
  String userId;
  String wishlistId;
  String position;
  String originalPrice;
  String originalCurrency;
  DateTime dateadded;
  String onSale;
  String productName;
  String imageUrl;

  FavModel({
    required this.id,
    required this.prodId,
    required this.quantity,
    required this.userId,
    required this.wishlistId,
    required this.position,
    required this.originalPrice,
    required this.originalCurrency,
    required this.dateadded,
    required this.onSale,
    required this.productName,
    required this.imageUrl,
  });

  factory FavModel.fromJson(Map<String, dynamic> json) => FavModel(
        id: json["ID"],
        prodId: json["prod_id"],
        quantity: json["quantity"],
        userId: json["user_id"],
        wishlistId: json["wishlist_id"],
        position: json["position"],
        originalPrice: json["original_price"],
        originalCurrency: json["original_currency"],
        dateadded: DateTime.parse(json["dateadded"]),
        onSale: json["on_sale"],
        productName: json["product_name"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "prod_id": prodId,
        "quantity": quantity,
        "user_id": userId,
        "wishlist_id": wishlistId,
        "position": position,
        "original_price": originalPrice,
        "original_currency": originalCurrency,
        "dateadded": dateadded.toIso8601String(),
        "on_sale": onSale,
        "product_name": productName,
        "image_url": imageUrl,
      };
}
