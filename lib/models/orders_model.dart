// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<OrdersModel> ordersFromJson(String str) => List<OrdersModel>.from(
    json.decode(str).map((x) => OrdersModel.fromJson(x)));

String welcomeToJson(List<OrdersModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrdersModel {
  int id;
  int parentId;
  String status;
  String currency;
  String version;
  bool pricesIncludeTax;
  DateTime dateCreated;
  DateTime dateModified;
  String discountTotal;
  String discountTax;
  String shippingTotal;
  String shippingTax;
  String cartTax;
  String total;
  String totalTax;
  int customerId;
  String orderKey;
  Ing billing;
  Ing shipping;
  String paymentMethod;
  String paymentMethodTitle;
  String transactionId;
  String customerIpAddress;
  String customerUserAgent;
  String createdVia;
  String customerNote;
  DateTime? dateCompleted;
  DateTime? datePaid;
  String cartHash;
  String number;
  List<WelcomeMetaDatum> metaData;
  List<LineItem> lineItems;
  List<dynamic> taxLines;
  List<ShippingLine> shippingLines;
  List<dynamic> feeLines;
  List<CouponLine> couponLines;
  List<dynamic> refunds;
  String paymentUrl;
  bool isEditable;
  bool needsPayment;
  bool needsProcessing;
  DateTime dateCreatedGmt;
  DateTime dateModifiedGmt;
  DateTime? dateCompletedGmt;
  DateTime? datePaidGmt;
  String currencySymbol;
  Links links;

  OrdersModel({
    required this.id,
    required this.parentId,
    required this.status,
    required this.currency,
    required this.version,
    required this.pricesIncludeTax,
    required this.dateCreated,
    required this.dateModified,
    required this.discountTotal,
    required this.discountTax,
    required this.shippingTotal,
    required this.shippingTax,
    required this.cartTax,
    required this.total,
    required this.totalTax,
    required this.customerId,
    required this.orderKey,
    required this.billing,
    required this.shipping,
    required this.paymentMethod,
    required this.paymentMethodTitle,
    required this.transactionId,
    required this.customerIpAddress,
    required this.customerUserAgent,
    required this.createdVia,
    required this.customerNote,
    required this.dateCompleted,
    required this.datePaid,
    required this.cartHash,
    required this.number,
    required this.metaData,
    required this.lineItems,
    required this.taxLines,
    required this.shippingLines,
    required this.feeLines,
    required this.couponLines,
    required this.refunds,
    required this.paymentUrl,
    required this.isEditable,
    required this.needsPayment,
    required this.needsProcessing,
    required this.dateCreatedGmt,
    required this.dateModifiedGmt,
    required this.dateCompletedGmt,
    required this.datePaidGmt,
    required this.currencySymbol,
    required this.links,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
        id: json["id"],
        parentId: json["parent_id"],
        status: json["status"],
        currency: json["currency"],
        version: json["version"],
        pricesIncludeTax: json["prices_include_tax"],
        dateCreated: DateTime.parse(json["date_created"]),
        dateModified: DateTime.parse(json["date_modified"]),
        discountTotal: json["discount_total"],
        discountTax: json["discount_tax"],
        shippingTotal: json["shipping_total"],
        shippingTax: json["shipping_tax"],
        cartTax: json["cart_tax"],
        total: json["total"],
        totalTax: json["total_tax"],
        customerId: json["customer_id"],
        orderKey: json["order_key"],
        billing: Ing.fromJson(json["billing"]),
        shipping: Ing.fromJson(json["shipping"]),
        paymentMethod: json["payment_method"],
        paymentMethodTitle: json["payment_method_title"],
        transactionId: json["transaction_id"],
        customerIpAddress: json["customer_ip_address"],
        customerUserAgent: json["customer_user_agent"],
        createdVia: json["created_via"],
        customerNote: json["customer_note"],
        dateCompleted: json["date_completed"] == null
            ? null
            : DateTime.parse(json["date_completed"]),
        datePaid: json["date_paid"] == null
            ? null
            : DateTime.parse(json["date_paid"]),
        cartHash: json["cart_hash"],
        number: json["number"],
        metaData: List<WelcomeMetaDatum>.from(
            json["meta_data"].map((x) => WelcomeMetaDatum.fromJson(x))),
        lineItems: List<LineItem>.from(
            json["line_items"].map((x) => LineItem.fromJson(x))),
        taxLines: List<dynamic>.from(json["tax_lines"].map((x) => x)),
        shippingLines: List<ShippingLine>.from(
            json["shipping_lines"].map((x) => ShippingLine.fromJson(x))),
        feeLines: List<dynamic>.from(json["fee_lines"].map((x) => x)),
        couponLines: List<CouponLine>.from(
            json["coupon_lines"].map((x) => CouponLine.fromJson(x))),
        refunds: List<dynamic>.from(json["refunds"].map((x) => x)),
        paymentUrl: json["payment_url"],
        isEditable: json["is_editable"],
        needsPayment: json["needs_payment"],
        needsProcessing: json["needs_processing"],
        dateCreatedGmt: DateTime.parse(json["date_created_gmt"]),
        dateModifiedGmt: DateTime.parse(json["date_modified_gmt"]),
        dateCompletedGmt: json["date_completed_gmt"] == null
            ? null
            : DateTime.parse(json["date_completed_gmt"]),
        datePaidGmt: json["date_paid_gmt"] == null
            ? null
            : DateTime.parse(json["date_paid_gmt"]),
        currencySymbol: json["currency_symbol"],
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "status": status,
        "currency": currency,
        "version": version,
        "prices_include_tax": pricesIncludeTax,
        "date_created": dateCreated.toIso8601String(),
        "date_modified": dateModified.toIso8601String(),
        "discount_total": discountTotal,
        "discount_tax": discountTax,
        "shipping_total": shippingTotal,
        "shipping_tax": shippingTax,
        "cart_tax": cartTax,
        "total": total,
        "total_tax": totalTax,
        "customer_id": customerId,
        "order_key": orderKey,
        "billing": billing.toJson(),
        "shipping": shipping.toJson(),
        "payment_method": paymentMethod,
        "payment_method_title": paymentMethodTitle,
        "transaction_id": transactionId,
        "customer_ip_address": customerIpAddress,
        "customer_user_agent": customerUserAgent,
        "created_via": createdVia,
        "customer_note": customerNote,
        "date_completed": dateCompleted?.toIso8601String(),
        "date_paid": datePaid?.toIso8601String(),
        "cart_hash": cartHash,
        "number": number,
        "meta_data": List<dynamic>.from(metaData.map((x) => x.toJson())),
        "line_items": List<dynamic>.from(lineItems.map((x) => x.toJson())),
        "tax_lines": List<dynamic>.from(taxLines.map((x) => x)),
        "shipping_lines":
            List<dynamic>.from(shippingLines.map((x) => x.toJson())),
        "fee_lines": List<dynamic>.from(feeLines.map((x) => x)),
        "coupon_lines": List<dynamic>.from(couponLines.map((x) => x.toJson())),
        "refunds": List<dynamic>.from(refunds.map((x) => x)),
        "payment_url": paymentUrl,
        "is_editable": isEditable,
        "needs_payment": needsPayment,
        "needs_processing": needsProcessing,
        "date_created_gmt": dateCreatedGmt.toIso8601String(),
        "date_modified_gmt": dateModifiedGmt.toIso8601String(),
        "date_completed_gmt": dateCompletedGmt?.toIso8601String(),
        "date_paid_gmt": datePaidGmt?.toIso8601String(),
        "currency_symbol": currencySymbol,
        "_links": links.toJson(),
      };
}

class Ing {
  String firstName;
  String lastName;
  String company;
  String address1;
  String address2;
  String city;
  String state;
  String postcode;
  String country;
  String? email;
  String phone;

  Ing({
    required this.firstName,
    required this.lastName,
    required this.company,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
    this.email,
    required this.phone,
  });

  factory Ing.fromJson(Map<String, dynamic> json) => Ing(
        firstName: json["first_name"],
        lastName: json["last_name"],
        company: json["company"],
        address1: json["address_1"],
        address2: json["address_2"],
        city: json["city"],
        state: json["state"],
        postcode: json["postcode"],
        country: json["country"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "company": company,
        "address_1": address1,
        "address_2": address2,
        "city": city,
        "state": state,
        "postcode": postcode,
        "country": country,
        "email": email,
        "phone": phone,
      };
}

class CouponLine {
  int id;
  String code;
  String discount;
  String discountTax;
  List<CouponLineMetaDatum> metaData;
  String discountType;
  int nominalAmount;
  bool freeShipping;

  CouponLine({
    required this.id,
    required this.code,
    required this.discount,
    required this.discountTax,
    required this.metaData,
    required this.discountType,
    required this.nominalAmount,
    required this.freeShipping,
  });

  factory CouponLine.fromJson(Map<String, dynamic> json) => CouponLine(
        id: json["id"],
        code: json["code"],
        discount: json["discount"],
        discountTax: json["discount_tax"],
        metaData: List<CouponLineMetaDatum>.from(
            json["meta_data"].map((x) => CouponLineMetaDatum.fromJson(x))),
        discountType: json["discount_type"],
        nominalAmount: json["nominal_amount"],
        freeShipping: json["free_shipping"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "discount": discount,
        "discount_tax": discountTax,
        "meta_data": List<dynamic>.from(metaData.map((x) => x.toJson())),
        "discount_type": discountType,
        "nominal_amount": nominalAmount,
        "free_shipping": freeShipping,
      };
}

class CouponLineMetaDatum {
  int id;
  String key;
  MetaDatumDisplayValueClass value;
  String displayKey;
  MetaDatumDisplayValueClass displayValue;

  CouponLineMetaDatum({
    required this.id,
    required this.key,
    required this.value,
    required this.displayKey,
    required this.displayValue,
  });

  factory CouponLineMetaDatum.fromJson(Map<String, dynamic> json) =>
      CouponLineMetaDatum(
        id: json["id"],
        key: json["key"],
        value: MetaDatumDisplayValueClass.fromJson(json["value"]),
        displayKey: json["display_key"],
        displayValue:
            MetaDatumDisplayValueClass.fromJson(json["display_value"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "value": value.toJson(),
        "display_key": displayKey,
        "display_value": displayValue.toJson(),
      };
}

class MetaDatumDisplayValueClass {
  int id;
  String code;
  String amount;
  String status;
  Date dateCreated;
  Date dateModified;
  dynamic dateExpires;
  String discountType;
  String description;
  int usageCount;
  bool individualUse;
  List<dynamic> productIds;
  List<dynamic> excludedProductIds;
  int usageLimit;
  int usageLimitPerUser;
  dynamic limitUsageToXItems;
  bool freeShipping;
  List<int> productCategories;
  List<dynamic> excludedProductCategories;
  bool excludeSaleItems;
  String minimumAmount;
  String maximumAmount;
  List<dynamic> emailRestrictions;
  bool virtual;
  List<DisplayValueMetaDatum> metaData;

  MetaDatumDisplayValueClass({
    required this.id,
    required this.code,
    required this.amount,
    required this.status,
    required this.dateCreated,
    required this.dateModified,
    required this.dateExpires,
    required this.discountType,
    required this.description,
    required this.usageCount,
    required this.individualUse,
    required this.productIds,
    required this.excludedProductIds,
    required this.usageLimit,
    required this.usageLimitPerUser,
    required this.limitUsageToXItems,
    required this.freeShipping,
    required this.productCategories,
    required this.excludedProductCategories,
    required this.excludeSaleItems,
    required this.minimumAmount,
    required this.maximumAmount,
    required this.emailRestrictions,
    required this.virtual,
    required this.metaData,
  });

  factory MetaDatumDisplayValueClass.fromJson(Map<String, dynamic> json) =>
      MetaDatumDisplayValueClass(
        id: json["id"],
        code: json["code"],
        amount: json["amount"],
        status: json["status"],
        dateCreated: Date.fromJson(json["date_created"]),
        dateModified: Date.fromJson(json["date_modified"]),
        dateExpires: json["date_expires"],
        discountType: json["discount_type"],
        description: json["description"],
        usageCount: json["usage_count"],
        individualUse: json["individual_use"],
        productIds: List<dynamic>.from(json["product_ids"].map((x) => x)),
        excludedProductIds:
            List<dynamic>.from(json["excluded_product_ids"].map((x) => x)),
        usageLimit: json["usage_limit"],
        usageLimitPerUser: json["usage_limit_per_user"],
        limitUsageToXItems: json["limit_usage_to_x_items"],
        freeShipping: json["free_shipping"],
        productCategories:
            List<int>.from(json["product_categories"].map((x) => x)),
        excludedProductCategories: List<dynamic>.from(
            json["excluded_product_categories"].map((x) => x)),
        excludeSaleItems: json["exclude_sale_items"],
        minimumAmount: json["minimum_amount"],
        maximumAmount: json["maximum_amount"],
        emailRestrictions:
            List<dynamic>.from(json["email_restrictions"].map((x) => x)),
        virtual: json["virtual"],
        metaData: List<DisplayValueMetaDatum>.from(
            json["meta_data"].map((x) => DisplayValueMetaDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "amount": amount,
        "status": status,
        "date_created": dateCreated.toJson(),
        "date_modified": dateModified.toJson(),
        "date_expires": dateExpires,
        "discount_type": discountType,
        "description": description,
        "usage_count": usageCount,
        "individual_use": individualUse,
        "product_ids": List<dynamic>.from(productIds.map((x) => x)),
        "excluded_product_ids":
            List<dynamic>.from(excludedProductIds.map((x) => x)),
        "usage_limit": usageLimit,
        "usage_limit_per_user": usageLimitPerUser,
        "limit_usage_to_x_items": limitUsageToXItems,
        "free_shipping": freeShipping,
        "product_categories":
            List<dynamic>.from(productCategories.map((x) => x)),
        "excluded_product_categories":
            List<dynamic>.from(excludedProductCategories.map((x) => x)),
        "exclude_sale_items": excludeSaleItems,
        "minimum_amount": minimumAmount,
        "maximum_amount": maximumAmount,
        "email_restrictions":
            List<dynamic>.from(emailRestrictions.map((x) => x)),
        "virtual": virtual,
        "meta_data": List<dynamic>.from(metaData.map((x) => x.toJson())),
      };
}

class Date {
  DateTime date;
  int timezoneType;
  String timezone;

  Date({
    required this.date,
    required this.timezoneType,
    required this.timezone,
  });

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        date: DateTime.parse(json["date"]),
        timezoneType: json["timezone_type"],
        timezone: json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "timezone_type": timezoneType,
        "timezone": timezone,
      };
}

class DisplayValueMetaDatum {
  int id;
  String key;
  dynamic value;

  DisplayValueMetaDatum({
    required this.id,
    required this.key,
    required this.value,
  });

  factory DisplayValueMetaDatum.fromJson(Map<String, dynamic> json) =>
      DisplayValueMetaDatum(
        id: json["id"],
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "value": value,
      };
}

class PurpleValue {
  The6234 the6234;

  PurpleValue({
    required this.the6234,
  });

  factory PurpleValue.fromJson(Map<String, dynamic> json) => PurpleValue(
        the6234: The6234.fromJson(json["6234"]),
      );

  Map<String, dynamic> toJson() => {
        "6234": the6234.toJson(),
      };
}

class The6234 {
  String min;
  String max;

  The6234({
    required this.min,
    required this.max,
  });

  factory The6234.fromJson(Map<String, dynamic> json) => The6234(
        min: json["min"],
        max: json["max"],
      );

  Map<String, dynamic> toJson() => {
        "min": min,
        "max": max,
      };
}

class LineItem {
  int id;
  String name;
  int productId;
  int variationId;
  int quantity;
  String taxClass;
  String subtotal;
  String subtotalTax;
  String total;
  String totalTax;
  List<dynamic> taxes;
  List<LineItemMetaDatum> metaData;
  String? sku;
  double price;
  Image image;
  String? parentName;

  LineItem({
    required this.id,
    required this.name,
    required this.productId,
    required this.variationId,
    required this.quantity,
    required this.taxClass,
    required this.subtotal,
    required this.subtotalTax,
    required this.total,
    required this.totalTax,
    required this.taxes,
    required this.metaData,
    required this.sku,
    required this.price,
    required this.image,
    required this.parentName,
  });

  factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
        id: json["id"],
        name: json["name"],
        productId: json["product_id"],
        variationId: json["variation_id"],
        quantity: json["quantity"],
        taxClass: json["tax_class"],
        subtotal: json["subtotal"],
        subtotalTax: json["subtotal_tax"],
        total: json["total"],
        totalTax: json["total_tax"],
        taxes: List<dynamic>.from(json["taxes"].map((x) => x)),
        metaData: List<LineItemMetaDatum>.from(
            json["meta_data"].map((x) => LineItemMetaDatum.fromJson(x))),
        sku: json["sku"],
        price: json["price"]?.toDouble(),
        image: Image.fromJson(json["image"]),
        parentName: json["parent_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "product_id": productId,
        "variation_id": variationId,
        "quantity": quantity,
        "tax_class": taxClass,
        "subtotal": subtotal,
        "subtotal_tax": subtotalTax,
        "total": total,
        "total_tax": totalTax,
        "taxes": List<dynamic>.from(taxes.map((x) => x)),
        "meta_data": List<dynamic>.from(metaData.map((x) => x.toJson())),
        "sku": sku,
        "price": price,
        "image": image.toJson(),
        "parent_name": parentName,
      };
}

class Image {
  dynamic id;
  String src;

  Image({
    required this.id,
    required this.src,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        src: json["src"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "src": src,
      };
}

class LineItemMetaDatum {
  int id;
  String key;
  dynamic value;
  String displayKey;
  dynamic displayValue;

  LineItemMetaDatum({
    required this.id,
    required this.key,
    required this.value,
    required this.displayKey,
    required this.displayValue,
  });

  factory LineItemMetaDatum.fromJson(Map<String, dynamic> json) =>
      LineItemMetaDatum(
        id: json["id"],
        key: json["key"],
        value: json["value"],
        displayKey: json["display_key"],
        displayValue: json["display_value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "value": value,
        "display_key": displayKey,
        "display_value": displayValue,
      };
}

class DisplayValueDisplayValue {
  double initialPrice;
  double discountedPrice;
  Map<String, TotalDiscountDetail>? totalDiscountDetails;
  List<dynamic>? cartDiscountDetails;
  List<String>? applyAsCartRule;
  DiscountLines? discountLines;
  int? cartQuantity;
  int? productId;
  double initialPriceBasedOnTaxSettings;
  double discountedPriceBasedOnTaxSettings;
  List<AppliedRule>? appliedRules;
  double? savedAmount;
  double? savedAmountBasedOnTaxSettings;
  bool? isFreeProduct;

  DisplayValueDisplayValue({
    required this.initialPrice,
    required this.discountedPrice,
    this.totalDiscountDetails,
    this.cartDiscountDetails,
    this.applyAsCartRule,
    this.discountLines,
    this.cartQuantity,
    this.productId,
    required this.initialPriceBasedOnTaxSettings,
    required this.discountedPriceBasedOnTaxSettings,
    this.appliedRules,
    this.savedAmount,
    this.savedAmountBasedOnTaxSettings,
    this.isFreeProduct,
  });

  factory DisplayValueDisplayValue.fromJson(Map<String, dynamic> json) =>
      DisplayValueDisplayValue(
        initialPrice: json["initial_price"]?.toDouble(),
        discountedPrice: json["discounted_price"]?.toDouble(),
        totalDiscountDetails: Map.from(json["total_discount_details"]!).map(
            (k, v) => MapEntry<String, TotalDiscountDetail>(
                k, TotalDiscountDetail.fromJson(v))),
        cartDiscountDetails: json["cart_discount_details"] == null
            ? []
            : List<dynamic>.from(json["cart_discount_details"]!.map((x) => x)),
        applyAsCartRule: json["apply_as_cart_rule"] == null
            ? []
            : List<String>.from(json["apply_as_cart_rule"]!.map((x) => x)),
        discountLines: json["discount_lines"] == null
            ? null
            : DiscountLines.fromJson(json["discount_lines"]),
        cartQuantity: json["cart_quantity"],
        productId: json["product_id"],
        initialPriceBasedOnTaxSettings:
            json["initial_price_based_on_tax_settings"]?.toDouble(),
        discountedPriceBasedOnTaxSettings:
            json["discounted_price_based_on_tax_settings"]?.toDouble(),
        appliedRules: json["applied_rules"] == null
            ? []
            : List<AppliedRule>.from(
                json["applied_rules"]!.map((x) => AppliedRule.fromJson(x))),
        savedAmount: json["saved_amount"]?.toDouble(),
        savedAmountBasedOnTaxSettings:
            json["saved_amount_based_on_tax_settings"]?.toDouble(),
        isFreeProduct: json["is_free_product"],
      );

  Map<String, dynamic> toJson() => {
        "initial_price": initialPrice,
        "discounted_price": discountedPrice,
        "total_discount_details": Map.from(totalDiscountDetails!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "cart_discount_details": cartDiscountDetails == null
            ? []
            : List<dynamic>.from(cartDiscountDetails!.map((x) => x)),
        "apply_as_cart_rule": applyAsCartRule == null
            ? []
            : List<dynamic>.from(applyAsCartRule!.map((x) => x)),
        "discount_lines": discountLines?.toJson(),
        "cart_quantity": cartQuantity,
        "product_id": productId,
        "initial_price_based_on_tax_settings": initialPriceBasedOnTaxSettings,
        "discounted_price_based_on_tax_settings":
            discountedPriceBasedOnTaxSettings,
        "applied_rules": appliedRules == null
            ? []
            : List<dynamic>.from(appliedRules!.map((x) => x.toJson())),
        "saved_amount": savedAmount,
        "saved_amount_based_on_tax_settings": savedAmountBasedOnTaxSettings,
        "is_free_product": isFreeProduct,
      };
}

class AppliedRule {
  int id;
  String title;
  String type;
  Discount discount;

  AppliedRule({
    required this.id,
    required this.title,
    required this.type,
    required this.discount,
  });

  factory AppliedRule.fromJson(Map<String, dynamic> json) => AppliedRule(
        id: json["id"],
        title: json["title"],
        type: json["type"],
        discount: Discount.fromJson(json["discount"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "type": type,
        "discount": discount.toJson(),
      };
}

class Discount {
  String appliedIn;
  String discountType;
  int discountValue;
  int discountQuantity;
  double discountPrice;

  Discount({
    required this.appliedIn,
    required this.discountType,
    required this.discountValue,
    required this.discountQuantity,
    required this.discountPrice,
  });

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
        appliedIn: json["applied_in"],
        discountType: json["discount_type"],
        discountValue: json["discount_value"],
        discountQuantity: json["discount_quantity"],
        discountPrice: json["discount_price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "applied_in": appliedIn,
        "discount_type": discountType,
        "discount_value": discountValue,
        "discount_quantity": discountQuantity,
        "discount_price": discountPrice,
      };
}

class DiscountLines {
  The0 the0;
  NonApplied nonApplied;

  DiscountLines({
    required this.the0,
    required this.nonApplied,
  });

  factory DiscountLines.fromJson(Map<String, dynamic> json) => DiscountLines(
        the0: The0.fromJson(json["0"]),
        nonApplied: NonApplied.fromJson(json["non_applied"]),
      );

  Map<String, dynamic> toJson() => {
        "0": the0.toJson(),
        "non_applied": nonApplied.toJson(),
      };
}

class NonApplied {
  int quantity;
  int discount;
  double price;
  double calculateDiscountFrom;

  NonApplied({
    required this.quantity,
    required this.discount,
    required this.price,
    required this.calculateDiscountFrom,
  });

  factory NonApplied.fromJson(Map<String, dynamic> json) => NonApplied(
        quantity: json["quantity"],
        discount: json["discount"],
        price: json["price"]?.toDouble(),
        calculateDiscountFrom: json["calculate_discount_from"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "discount": discount,
        "price": price,
        "calculate_discount_from": calculateDiscountFrom,
      };
}

class The0 {
  int quantity;
  double discount;
  double originalPrice;
  double discountedPrice;

  The0({
    required this.quantity,
    required this.discount,
    required this.originalPrice,
    required this.discountedPrice,
  });

  factory The0.fromJson(Map<String, dynamic> json) => The0(
        quantity: json["quantity"],
        discount: json["discount"]?.toDouble(),
        originalPrice: json["original_price"]?.toDouble(),
        discountedPrice: json["discounted_price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "discount": discount,
        "original_price": originalPrice,
        "discounted_price": discountedPrice,
      };
}

class TotalDiscountDetail {
  The1 the1;

  TotalDiscountDetail({
    required this.the1,
  });

  factory TotalDiscountDetail.fromJson(Map<String, dynamic> json) =>
      TotalDiscountDetail(
        the1: The1.fromJson(json["1"]),
      );

  Map<String, dynamic> toJson() => {
        "1": the1.toJson(),
      };
}

class The1 {
  int setDiscount;
  int bulkDiscount;
  SimpleDiscount simpleDiscount;

  The1({
    required this.setDiscount,
    required this.bulkDiscount,
    required this.simpleDiscount,
  });

  factory The1.fromJson(Map<String, dynamic> json) => The1(
        setDiscount: json["set_discount"],
        bulkDiscount: json["bulk_discount"],
        simpleDiscount: SimpleDiscount.fromJson(json["simple_discount"]),
      );

  Map<String, dynamic> toJson() => {
        "set_discount": setDiscount,
        "bulk_discount": bulkDiscount,
        "simple_discount": simpleDiscount.toJson(),
      };
}

class SimpleDiscount {
  String discountType;
  String discountValue;
  int discountQuantity;
  double discountPricePerQuantity;
  double discountPrice;

  SimpleDiscount({
    required this.discountType,
    required this.discountValue,
    required this.discountQuantity,
    required this.discountPricePerQuantity,
    required this.discountPrice,
  });

  factory SimpleDiscount.fromJson(Map<String, dynamic> json) => SimpleDiscount(
        discountType: json["discount_type"],
        discountValue: json["discount_value"],
        discountQuantity: json["discount_quantity"],
        discountPricePerQuantity:
            json["discount_price_per_quantity"]?.toDouble(),
        discountPrice: json["discount_price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "discount_type": discountType,
        "discount_value": discountValue,
        "discount_quantity": discountQuantity,
        "discount_price_per_quantity": discountPricePerQuantity,
        "discount_price": discountPrice,
      };
}

class Links {
  List<Collection> self;
  List<Collection> collection;
  List<Collection> customer;

  Links({
    required this.self,
    required this.collection,
    required this.customer,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: List<Collection>.from(
            json["self"].map((x) => Collection.fromJson(x))),
        collection: List<Collection>.from(
            json["collection"].map((x) => Collection.fromJson(x))),
        customer: List<Collection>.from(
            json["customer"].map((x) => Collection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": List<dynamic>.from(self.map((x) => x.toJson())),
        "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
        "customer": List<dynamic>.from(customer.map((x) => x.toJson())),
      };
}

class Collection {
  String href;

  Collection({
    required this.href,
  });

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
      };
}

class WelcomeMetaDatum {
  int id;
  String key;
  String value;

  WelcomeMetaDatum({
    required this.id,
    required this.key,
    required this.value,
  });

  factory WelcomeMetaDatum.fromJson(Map<String, dynamic> json) =>
      WelcomeMetaDatum(
        id: json["id"],
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "value": value,
      };
}

class ShippingLine {
  int id;
  String methodTitle;
  String methodId;
  String instanceId;
  String total;
  String totalTax;
  List<dynamic> taxes;
  List<ShippingLineMetaDatum> metaData;

  ShippingLine({
    required this.id,
    required this.methodTitle,
    required this.methodId,
    required this.instanceId,
    required this.total,
    required this.totalTax,
    required this.taxes,
    required this.metaData,
  });

  factory ShippingLine.fromJson(Map<String, dynamic> json) => ShippingLine(
        id: json["id"],
        methodTitle: json["method_title"],
        methodId: json["method_id"],
        instanceId: json["instance_id"],
        total: json["total"],
        totalTax: json["total_tax"],
        taxes: List<dynamic>.from(json["taxes"].map((x) => x)),
        metaData: List<ShippingLineMetaDatum>.from(
            json["meta_data"].map((x) => ShippingLineMetaDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "method_title": methodTitle,
        "method_id": methodId,
        "instance_id": instanceId,
        "total": total,
        "total_tax": totalTax,
        "taxes": List<dynamic>.from(taxes.map((x) => x)),
        "meta_data": List<dynamic>.from(metaData.map((x) => x.toJson())),
      };
}

class ShippingLineMetaDatum {
  int id;
  String key;
  String value;
  String displayKey;
  String displayValue;

  ShippingLineMetaDatum({
    required this.id,
    required this.key,
    required this.value,
    required this.displayKey,
    required this.displayValue,
  });

  factory ShippingLineMetaDatum.fromJson(Map<String, dynamic> json) =>
      ShippingLineMetaDatum(
        id: json["id"],
        key: json["key"],
        value: json["value"],
        displayKey: json["display_key"],
        displayValue: json["display_value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "value": value,
        "display_key": displayKey,
        "display_value": displayValue,
      };
}




// // To parse this JSON data, do
// //
// //     final welcome = welcomeFromJson(jsonString);

// import 'dart:convert';

// // LineItemsModel itemsFromJson(String str) =>
// //     LineItemsModel.fromJson(json.decode(str));
// LineItemsModel itemsFromJson(String str) {
//   List<dynamic> jsonList = json.decode(str);
//   return LineItemsModel(
//     lineItems: List<LineItem>.from(jsonList.map((x) => LineItem.fromJson(x))),
//   );
// }

// String welcomeToJson(LineItemsModel data) => json.encode(data.toJson());

// class LineItemsModel {
//   List<LineItem> lineItems;

//   LineItemsModel({
//     required this.lineItems,
//   });

//   factory LineItemsModel.fromJson(Map<String, dynamic> json) => LineItemsModel(
//         lineItems: List<LineItem>.from(
//             json["line_items"].map((x) => LineItem.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "line_items": List<dynamic>.from(lineItems.map((x) => x.toJson())),
//       };
// }

// class LineItem {
//   int id;
//   String name;
//   int productId;
//   int variationId;
//   int quantity;
//   String taxClass;
//   String subtotal;
//   String subtotalTax;
//   String total;
//   String totalTax;
//   List<dynamic> taxes;
//   List<MetaDatum> metaData;
//   String sku;
//   double price;
//   Image image;
//   String? parentName;

//   LineItem({
//     required this.id,
//     required this.name,
//     required this.productId,
//     required this.variationId,
//     required this.quantity,
//     required this.taxClass,
//     required this.subtotal,
//     required this.subtotalTax,
//     required this.total,
//     required this.totalTax,
//     required this.taxes,
//     required this.metaData,
//     required this.sku,
//     required this.price,
//     required this.image,
//     required this.parentName,
//   });

//   factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
//         id: json["id"],
//         name: json["name"],
//         productId: json["product_id"],
//         variationId: json["variation_id"],
//         quantity: json["quantity"],
//         taxClass: json["tax_class"],
//         subtotal: json["subtotal"],
//         subtotalTax: json["subtotal_tax"],
//         total: json["total"],
//         totalTax: json["total_tax"],
//         taxes: List<dynamic>.from(json["taxes"].map((x) => x)),
//         metaData: List<MetaDatum>.from(
//             json["meta_data"].map((x) => MetaDatum.fromJson(x))),
//         sku: json["sku"],
//         price: json["price"]?.toDouble(),
//         image: Image.fromJson(json["image"]),
//         parentName: json["parent_name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "product_id": productId,
//         "variation_id": variationId,
//         "quantity": quantity,
//         "tax_class": taxClass,
//         "subtotal": subtotal,
//         "subtotal_tax": subtotalTax,
//         "total": total,
//         "total_tax": totalTax,
//         "taxes": List<dynamic>.from(taxes.map((x) => x)),
//         "meta_data": List<dynamic>.from(metaData.map((x) => x.toJson())),
//         "sku": sku,
//         "price": price,
//         "image": image.toJson(),
//         "parent_name": parentName,
//       };
// }

// class Image {
//   String id;
//   String src;

//   Image({
//     required this.id,
//     required this.src,
//   });

//   factory Image.fromJson(Map<String, dynamic> json) => Image(
//         id: json["id"],
//         src: json["src"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "src": src,
//       };
// }

// class MetaDatum {
//   int id;
//   String key;
//   String value;
//   String displayKey;
//   String displayValue;

//   MetaDatum({
//     required this.id,
//     required this.key,
//     required this.value,
//     required this.displayKey,
//     required this.displayValue,
//   });

//   factory MetaDatum.fromJson(Map<String, dynamic> json) => MetaDatum(
//         id: json["id"],
//         key: json["key"],
//         value: json["value"],
//         displayKey: json["display_key"],
//         displayValue: json["display_value"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "key": key,
//         "value": value,
//         "display_key": displayKey,
//         "display_value": displayValue,
//       };
// }

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }

