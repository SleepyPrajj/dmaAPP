// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<SaleModel> saleFromJson(String str) =>
    List<SaleModel>.from(json.decode(str).map((x) => SaleModel.fromJson(x)));

String welcomeToJson(List<SaleModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SaleModel {
  int id;
  String name;
  String slug;
  String permalink;
  DateTime dateCreated;
  DateTime dateCreatedGmt;
  DateTime dateModified;
  DateTime dateModifiedGmt;
  String type;
  String status;
  bool featured;
  String catalogVisibility;
  String description;
  String shortDescription;
  String sku;
  String price;
  String regularPrice;
  String salePrice;
  dynamic dateOnSaleFrom;
  dynamic dateOnSaleFromGmt;
  dynamic dateOnSaleTo;
  dynamic dateOnSaleToGmt;
  bool onSale;
  bool purchasable;
  int totalSales;
  bool virtual;
  bool downloadable;
  List<dynamic> downloads;
  int downloadLimit;
  int downloadExpiry;
  String externalUrl;
  String buttonText;
  String taxStatus;
  String taxClass;
  bool manageStock;
  int? stockQuantity;
  String backorders;
  bool backordersAllowed;
  bool backordered;
  dynamic lowStockAmount;
  bool soldIndividually;
  String weight;
  Dimensions dimensions;
  bool shippingRequired;
  bool shippingTaxable;
  String shippingClass;
  int shippingClassId;
  bool reviewsAllowed;
  String averageRating;
  int ratingCount;
  List<dynamic> upsellIds;
  List<dynamic> crossSellIds;
  int parentId;
  String purchaseNote;
  List<Category> categories;
  List<Category> tags;
  List<Image> images;
  List<Attribute> attributes;
  List<dynamic> defaultAttributes;
  List<int> variations;
  List<dynamic> groupedProducts;
  int menuOrder;
  String priceHtml;
  List<int> relatedIds;
  List<MetaDatum> metaData;
  String stockStatus;
  bool hasOptions;
  String postPassword;
  String globalUniqueId;
  Links links;

  SaleModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.permalink,
    required this.dateCreated,
    required this.dateCreatedGmt,
    required this.dateModified,
    required this.dateModifiedGmt,
    required this.type,
    required this.status,
    required this.featured,
    required this.catalogVisibility,
    required this.description,
    required this.shortDescription,
    required this.sku,
    required this.price,
    required this.regularPrice,
    required this.salePrice,
    required this.dateOnSaleFrom,
    required this.dateOnSaleFromGmt,
    required this.dateOnSaleTo,
    required this.dateOnSaleToGmt,
    required this.onSale,
    required this.purchasable,
    required this.totalSales,
    required this.virtual,
    required this.downloadable,
    required this.downloads,
    required this.downloadLimit,
    required this.downloadExpiry,
    required this.externalUrl,
    required this.buttonText,
    required this.taxStatus,
    required this.taxClass,
    required this.manageStock,
    required this.stockQuantity,
    required this.backorders,
    required this.backordersAllowed,
    required this.backordered,
    required this.lowStockAmount,
    required this.soldIndividually,
    required this.weight,
    required this.dimensions,
    required this.shippingRequired,
    required this.shippingTaxable,
    required this.shippingClass,
    required this.shippingClassId,
    required this.reviewsAllowed,
    required this.averageRating,
    required this.ratingCount,
    required this.upsellIds,
    required this.crossSellIds,
    required this.parentId,
    required this.purchaseNote,
    required this.categories,
    required this.tags,
    required this.images,
    required this.attributes,
    required this.defaultAttributes,
    required this.variations,
    required this.groupedProducts,
    required this.menuOrder,
    required this.priceHtml,
    required this.relatedIds,
    required this.metaData,
    required this.stockStatus,
    required this.hasOptions,
    required this.postPassword,
    required this.globalUniqueId,
    required this.links,
  });

  factory SaleModel.fromJson(Map<String, dynamic> json) => SaleModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        permalink: json["permalink"],
        dateCreated: DateTime.parse(json["date_created"]),
        dateCreatedGmt: DateTime.parse(json["date_created_gmt"]),
        dateModified: DateTime.parse(json["date_modified"]),
        dateModifiedGmt: DateTime.parse(json["date_modified_gmt"]),
        type: json["type"],
        status: json["status"],
        featured: json["featured"],
        catalogVisibility: json["catalog_visibility"],
        description: json["description"],
        shortDescription: json["short_description"],
        sku: json["sku"],
        price: json["price"],
        regularPrice: json["regular_price"],
        salePrice: json["sale_price"],
        dateOnSaleFrom: json["date_on_sale_from"],
        dateOnSaleFromGmt: json["date_on_sale_from_gmt"],
        dateOnSaleTo: json["date_on_sale_to"],
        dateOnSaleToGmt: json["date_on_sale_to_gmt"],
        onSale: json["on_sale"],
        purchasable: json["purchasable"],
        totalSales: json["total_sales"],
        virtual: json["virtual"],
        downloadable: json["downloadable"],
        downloads: List<dynamic>.from(json["downloads"].map((x) => x)),
        downloadLimit: json["download_limit"],
        downloadExpiry: json["download_expiry"],
        externalUrl: json["external_url"],
        buttonText: json["button_text"],
        taxStatus: json["tax_status"],
        taxClass: json["tax_class"],
        manageStock: json["manage_stock"],
        stockQuantity: json["stock_quantity"],
        backorders: json["backorders"],
        backordersAllowed: json["backorders_allowed"],
        backordered: json["backordered"],
        lowStockAmount: json["low_stock_amount"],
        soldIndividually: json["sold_individually"],
        weight: json["weight"],
        dimensions: Dimensions.fromJson(json["dimensions"]),
        shippingRequired: json["shipping_required"],
        shippingTaxable: json["shipping_taxable"],
        shippingClass: json["shipping_class"],
        shippingClassId: json["shipping_class_id"],
        reviewsAllowed: json["reviews_allowed"],
        averageRating: json["average_rating"],
        ratingCount: json["rating_count"],
        upsellIds: List<dynamic>.from(json["upsell_ids"].map((x) => x)),
        crossSellIds: List<dynamic>.from(json["cross_sell_ids"].map((x) => x)),
        parentId: json["parent_id"],
        purchaseNote: json["purchase_note"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        tags:
            List<Category>.from(json["tags"].map((x) => Category.fromJson(x))),
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        attributes: List<Attribute>.from(
            json["attributes"].map((x) => Attribute.fromJson(x))),
        defaultAttributes:
            List<dynamic>.from(json["default_attributes"].map((x) => x)),
        variations: List<int>.from(json["variations"].map((x) => x)),
        groupedProducts:
            List<dynamic>.from(json["grouped_products"].map((x) => x)),
        menuOrder: json["menu_order"],
        priceHtml: json["price_html"],
        relatedIds: List<int>.from(json["related_ids"].map((x) => x)),
        metaData: List<MetaDatum>.from(
            json["meta_data"].map((x) => MetaDatum.fromJson(x))),
        stockStatus: json["stock_status"],
        hasOptions: json["has_options"],
        postPassword: json["post_password"],
        globalUniqueId: json["global_unique_id"],
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "permalink": permalink,
        "date_created": dateCreated.toIso8601String(),
        "date_created_gmt": dateCreatedGmt.toIso8601String(),
        "date_modified": dateModified.toIso8601String(),
        "date_modified_gmt": dateModifiedGmt.toIso8601String(),
        "type": type,
        "status": status,
        "featured": featured,
        "catalog_visibility": catalogVisibility,
        "description": description,
        "short_description": shortDescription,
        "sku": sku,
        "price": price,
        "regular_price": regularPrice,
        "sale_price": salePrice,
        "date_on_sale_from": dateOnSaleFrom,
        "date_on_sale_from_gmt": dateOnSaleFromGmt,
        "date_on_sale_to": dateOnSaleTo,
        "date_on_sale_to_gmt": dateOnSaleToGmt,
        "on_sale": onSale,
        "purchasable": purchasable,
        "total_sales": totalSales,
        "virtual": virtual,
        "downloadable": downloadable,
        "downloads": List<dynamic>.from(downloads.map((x) => x)),
        "download_limit": downloadLimit,
        "download_expiry": downloadExpiry,
        "external_url": externalUrl,
        "button_text": buttonText,
        "tax_status": taxStatus,
        "tax_class": taxClass,
        "manage_stock": manageStock,
        "stock_quantity": stockQuantity,
        "backorders": backorders,
        "backorders_allowed": backordersAllowed,
        "backordered": backordered,
        "low_stock_amount": lowStockAmount,
        "sold_individually": soldIndividually,
        "weight": weight,
        "dimensions": dimensions.toJson(),
        "shipping_required": shippingRequired,
        "shipping_taxable": shippingTaxable,
        "shipping_class": shippingClass,
        "shipping_class_id": shippingClassId,
        "reviews_allowed": reviewsAllowed,
        "average_rating": averageRating,
        "rating_count": ratingCount,
        "upsell_ids": List<dynamic>.from(upsellIds.map((x) => x)),
        "cross_sell_ids": List<dynamic>.from(crossSellIds.map((x) => x)),
        "parent_id": parentId,
        "purchase_note": purchaseNote,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
        "default_attributes":
            List<dynamic>.from(defaultAttributes.map((x) => x)),
        "variations": List<dynamic>.from(variations.map((x) => x)),
        "grouped_products": List<dynamic>.from(groupedProducts.map((x) => x)),
        "menu_order": menuOrder,
        "price_html": priceHtml,
        "related_ids": List<dynamic>.from(relatedIds.map((x) => x)),
        "meta_data": List<dynamic>.from(metaData.map((x) => x.toJson())),
        "stock_status": stockStatus,
        "has_options": hasOptions,
        "post_password": postPassword,
        "global_unique_id": globalUniqueId,
        "_links": links.toJson(),
      };
}

class Attribute {
  int id;
  String name;
  String slug;
  int position;
  bool visible;
  bool variation;
  List<String> options;

  Attribute({
    required this.id,
    required this.name,
    required this.slug,
    required this.position,
    required this.visible,
    required this.variation,
    required this.options,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        position: json["position"],
        visible: json["visible"],
        variation: json["variation"],
        options: List<String>.from(json["options"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "position": position,
        "visible": visible,
        "variation": variation,
        "options": List<dynamic>.from(options.map((x) => x)),
      };
}

class Category {
  int id;
  String name;
  String slug;

  Category({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
      };
}

class Dimensions {
  String length;
  String width;
  String height;

  Dimensions({
    required this.length,
    required this.width,
    required this.height,
  });

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
        length: json["length"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "length": length,
        "width": width,
        "height": height,
      };
}

class Image {
  int id;
  DateTime dateCreated;
  DateTime dateCreatedGmt;
  DateTime dateModified;
  DateTime dateModifiedGmt;
  String src;
  String name;
  String alt;

  Image({
    required this.id,
    required this.dateCreated,
    required this.dateCreatedGmt,
    required this.dateModified,
    required this.dateModifiedGmt,
    required this.src,
    required this.name,
    required this.alt,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        dateCreated: DateTime.parse(json["date_created"]),
        dateCreatedGmt: DateTime.parse(json["date_created_gmt"]),
        dateModified: DateTime.parse(json["date_modified"]),
        dateModifiedGmt: DateTime.parse(json["date_modified_gmt"]),
        src: json["src"],
        name: json["name"],
        alt: json["alt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date_created": dateCreated.toIso8601String(),
        "date_created_gmt": dateCreatedGmt.toIso8601String(),
        "date_modified": dateModified.toIso8601String(),
        "date_modified_gmt": dateModifiedGmt.toIso8601String(),
        "src": src,
        "name": name,
        "alt": alt,
      };
}

class Links {
  List<Collection> self;
  List<Collection> collection;

  Links({
    required this.self,
    required this.collection,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: List<Collection>.from(
            json["self"].map((x) => Collection.fromJson(x))),
        collection: List<Collection>.from(
            json["collection"].map((x) => Collection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": List<dynamic>.from(self.map((x) => x.toJson())),
        "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
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

class MetaDatum {
  int id;
  String key;
  dynamic value;

  MetaDatum({
    required this.id,
    required this.key,
    required this.value,
  });

  factory MetaDatum.fromJson(Map<String, dynamic> json) => MetaDatum(
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

class ValueClass {
  String? bodyPaddings;
  String? themeSkin;
  String? bodyScheme;
  String? bodyFilled;
  String? bgCustom;
  String? bgColor;
  String? bgPattern;
  String? bgPatternCustom;
  String? bgImage;
  String? bgImageCustom;
  String? bgImageCustomPosition;
  String? bgImageLoad;
  String? topPanelStyle;
  String? topPanelImage;
  String? topPanelPosition;
  String? topPanelScheme;
  String? pushyPanelScheme;
  String? showPageTitle;
  String? showBreadcrumbs;
  String? menuMain;
  String? showTopPanelTop;
  String? menuUser;
  String? menuToc;
  String? menuTocHome;
  String? menuTocTop;
  String? logo;
  String? logoRetina;
  String? logoFixed;
  String? logoText;
  String? logoHeight;
  String? logoOffset;
  String? showSlider;
  String? sliderDisplay;
  String? sliderHeight;
  String? sliderEngine;
  String? sliderCategory;
  String? sliderPosts;
  String? sliderOrderby;
  String? sliderOrder;
  String? sliderInterval;
  String? sliderPagination;
  String? sliderInfobox;
  String? sliderInfoCategory;
  String? sliderInfoReviews;
  String? sliderInfoDescriptions;
  String? showSidebarMain;
  String? sidebarMainScheme;
  String? sidebarMain;
  String? showSidebarFooter;
  String? sidebarFooterScheme;
  String? sidebarFooter;
  String? sidebarFooterColumns;
  String? showContactsInFooter;
  String? contactsScheme;
  String? logoFooter;
  String? logoFooterRetina;
  String? logoFooterHeight;
  String? showCopyrightInFooter;
  String? copyrightScheme;
  String? menuFooter;
  String? footerCopyright;
  String? customCode;
  String? customCss;
  String? blogStyle;
  String? hoverStyle;
  String? hoverDir;
  String? articleStyle;
  String? dedicatedLocation;
  String? showFilters;
  String? blogSort;
  String? blogOrder;
  String? postsPerPage;
  String? postExcerptMaxlength;
  String? postExcerptMaxlengthMasonry;
  String? singleStyle;
  String? icon;
  String? alterThumbSize;
  String? showFeaturedImage;
  String? showPostTitle;
  String? showPostTitleOnQuotes;
  String? showPostInfo;
  String? showPostAuthor;
  String? showPostTags;
  String? showPostRelated;
  String? postRelatedCount;
  String? postRelatedColumns;
  String? showPostComments;
  String? blogPagination;
  String? blogCounters;
  String? closeCategory;
  String? showDateAfter;
  String? substituteGallery;
  String? galleryInsteadImage;
  String? galleryMaxSlides;
  String? substituteAudio;
  String? substituteVideo;
  String? showShare;
  String? showShareCounters;
  String? shareCaption;
  String? the0;
  int? time;
  List<dynamic>? fonts;
  List<dynamic>? icons;
  List<dynamic>? dynamicElementsIds;
  String? status;
  String? css;

  ValueClass({
    this.bodyPaddings,
    this.themeSkin,
    this.bodyScheme,
    this.bodyFilled,
    this.bgCustom,
    this.bgColor,
    this.bgPattern,
    this.bgPatternCustom,
    this.bgImage,
    this.bgImageCustom,
    this.bgImageCustomPosition,
    this.bgImageLoad,
    this.topPanelStyle,
    this.topPanelImage,
    this.topPanelPosition,
    this.topPanelScheme,
    this.pushyPanelScheme,
    this.showPageTitle,
    this.showBreadcrumbs,
    this.menuMain,
    this.showTopPanelTop,
    this.menuUser,
    this.menuToc,
    this.menuTocHome,
    this.menuTocTop,
    this.logo,
    this.logoRetina,
    this.logoFixed,
    this.logoText,
    this.logoHeight,
    this.logoOffset,
    this.showSlider,
    this.sliderDisplay,
    this.sliderHeight,
    this.sliderEngine,
    this.sliderCategory,
    this.sliderPosts,
    this.sliderOrderby,
    this.sliderOrder,
    this.sliderInterval,
    this.sliderPagination,
    this.sliderInfobox,
    this.sliderInfoCategory,
    this.sliderInfoReviews,
    this.sliderInfoDescriptions,
    this.showSidebarMain,
    this.sidebarMainScheme,
    this.sidebarMain,
    this.showSidebarFooter,
    this.sidebarFooterScheme,
    this.sidebarFooter,
    this.sidebarFooterColumns,
    this.showContactsInFooter,
    this.contactsScheme,
    this.logoFooter,
    this.logoFooterRetina,
    this.logoFooterHeight,
    this.showCopyrightInFooter,
    this.copyrightScheme,
    this.menuFooter,
    this.footerCopyright,
    this.customCode,
    this.customCss,
    this.blogStyle,
    this.hoverStyle,
    this.hoverDir,
    this.articleStyle,
    this.dedicatedLocation,
    this.showFilters,
    this.blogSort,
    this.blogOrder,
    this.postsPerPage,
    this.postExcerptMaxlength,
    this.postExcerptMaxlengthMasonry,
    this.singleStyle,
    this.icon,
    this.alterThumbSize,
    this.showFeaturedImage,
    this.showPostTitle,
    this.showPostTitleOnQuotes,
    this.showPostInfo,
    this.showPostAuthor,
    this.showPostTags,
    this.showPostRelated,
    this.postRelatedCount,
    this.postRelatedColumns,
    this.showPostComments,
    this.blogPagination,
    this.blogCounters,
    this.closeCategory,
    this.showDateAfter,
    this.substituteGallery,
    this.galleryInsteadImage,
    this.galleryMaxSlides,
    this.substituteAudio,
    this.substituteVideo,
    this.showShare,
    this.showShareCounters,
    this.shareCaption,
    this.the0,
    this.time,
    this.fonts,
    this.icons,
    this.dynamicElementsIds,
    this.status,
    this.css,
  });

  factory ValueClass.fromJson(Map<String, dynamic> json) => ValueClass(
        bodyPaddings: json["body_paddings"],
        themeSkin: json["theme_skin"],
        bodyScheme: json["body_scheme"],
        bodyFilled: json["body_filled"],
        bgCustom: json["bg_custom"],
        bgColor: json["bg_color"],
        bgPattern: json["bg_pattern"],
        bgPatternCustom: json["bg_pattern_custom"],
        bgImage: json["bg_image"],
        bgImageCustom: json["bg_image_custom"],
        bgImageCustomPosition: json["bg_image_custom_position"],
        bgImageLoad: json["bg_image_load"],
        topPanelStyle: json["top_panel_style"],
        topPanelImage: json["top_panel_image"],
        topPanelPosition: json["top_panel_position"],
        topPanelScheme: json["top_panel_scheme"],
        pushyPanelScheme: json["pushy_panel_scheme"],
        showPageTitle: json["show_page_title"],
        showBreadcrumbs: json["show_breadcrumbs"],
        menuMain: json["menu_main"],
        showTopPanelTop: json["show_top_panel_top"],
        menuUser: json["menu_user"],
        menuToc: json["menu_toc"],
        menuTocHome: json["menu_toc_home"],
        menuTocTop: json["menu_toc_top"],
        logo: json["logo"],
        logoRetina: json["logo_retina"],
        logoFixed: json["logo_fixed"],
        logoText: json["logo_text"],
        logoHeight: json["logo_height"],
        logoOffset: json["logo_offset"],
        showSlider: json["show_slider"],
        sliderDisplay: json["slider_display"],
        sliderHeight: json["slider_height"],
        sliderEngine: json["slider_engine"],
        sliderCategory: json["slider_category"],
        sliderPosts: json["slider_posts"],
        sliderOrderby: json["slider_orderby"],
        sliderOrder: json["slider_order"],
        sliderInterval: json["slider_interval"],
        sliderPagination: json["slider_pagination"],
        sliderInfobox: json["slider_infobox"],
        sliderInfoCategory: json["slider_info_category"],
        sliderInfoReviews: json["slider_info_reviews"],
        sliderInfoDescriptions: json["slider_info_descriptions"],
        showSidebarMain: json["show_sidebar_main"],
        sidebarMainScheme: json["sidebar_main_scheme"],
        sidebarMain: json["sidebar_main"],
        showSidebarFooter: json["show_sidebar_footer"],
        sidebarFooterScheme: json["sidebar_footer_scheme"],
        sidebarFooter: json["sidebar_footer"],
        sidebarFooterColumns: json["sidebar_footer_columns"],
        showContactsInFooter: json["show_contacts_in_footer"],
        contactsScheme: json["contacts_scheme"],
        logoFooter: json["logo_footer"],
        logoFooterRetina: json["logo_footer_retina"],
        logoFooterHeight: json["logo_footer_height"],
        showCopyrightInFooter: json["show_copyright_in_footer"],
        copyrightScheme: json["copyright_scheme"],
        menuFooter: json["menu_footer"],
        footerCopyright: json["footer_copyright"],
        customCode: json["custom_code"],
        customCss: json["custom_css"],
        blogStyle: json["blog_style"],
        hoverStyle: json["hover_style"],
        hoverDir: json["hover_dir"],
        articleStyle: json["article_style"],
        dedicatedLocation: json["dedicated_location"],
        showFilters: json["show_filters"],
        blogSort: json["blog_sort"],
        blogOrder: json["blog_order"],
        postsPerPage: json["posts_per_page"],
        postExcerptMaxlength: json["post_excerpt_maxlength"],
        postExcerptMaxlengthMasonry: json["post_excerpt_maxlength_masonry"],
        singleStyle: json["single_style"],
        icon: json["icon"],
        alterThumbSize: json["alter_thumb_size"],
        showFeaturedImage: json["show_featured_image"],
        showPostTitle: json["show_post_title"],
        showPostTitleOnQuotes: json["show_post_title_on_quotes"],
        showPostInfo: json["show_post_info"],
        showPostAuthor: json["show_post_author"],
        showPostTags: json["show_post_tags"],
        showPostRelated: json["show_post_related"],
        postRelatedCount: json["post_related_count"],
        postRelatedColumns: json["post_related_columns"],
        showPostComments: json["show_post_comments"],
        blogPagination: json["blog_pagination"],
        blogCounters: json["blog_counters"],
        closeCategory: json["close_category"],
        showDateAfter: json["show_date_after"],
        substituteGallery: json["substitute_gallery"],
        galleryInsteadImage: json["gallery_instead_image"],
        galleryMaxSlides: json["gallery_max_slides"],
        substituteAudio: json["substitute_audio"],
        substituteVideo: json["substitute_video"],
        showShare: json["show_share"],
        showShareCounters: json["show_share_counters"],
        shareCaption: json["share_caption"],
        the0: json["0"],
        time: json["time"],
        fonts: json["fonts"] == null
            ? []
            : List<dynamic>.from(json["fonts"]!.map((x) => x)),
        icons: json["icons"] == null
            ? []
            : List<dynamic>.from(json["icons"]!.map((x) => x)),
        dynamicElementsIds: json["dynamic_elements_ids"] == null
            ? []
            : List<dynamic>.from(json["dynamic_elements_ids"]!.map((x) => x)),
        status: json["status"],
        css: json["css"],
      );

  Map<String, dynamic> toJson() => {
        "body_paddings": bodyPaddings,
        "theme_skin": themeSkin,
        "body_scheme": bodyScheme,
        "body_filled": bodyFilled,
        "bg_custom": bgCustom,
        "bg_color": bgColor,
        "bg_pattern": bgPattern,
        "bg_pattern_custom": bgPatternCustom,
        "bg_image": bgImage,
        "bg_image_custom": bgImageCustom,
        "bg_image_custom_position": bgImageCustomPosition,
        "bg_image_load": bgImageLoad,
        "top_panel_style": topPanelStyle,
        "top_panel_image": topPanelImage,
        "top_panel_position": topPanelPosition,
        "top_panel_scheme": topPanelScheme,
        "pushy_panel_scheme": pushyPanelScheme,
        "show_page_title": showPageTitle,
        "show_breadcrumbs": showBreadcrumbs,
        "menu_main": menuMain,
        "show_top_panel_top": showTopPanelTop,
        "menu_user": menuUser,
        "menu_toc": menuToc,
        "menu_toc_home": menuTocHome,
        "menu_toc_top": menuTocTop,
        "logo": logo,
        "logo_retina": logoRetina,
        "logo_fixed": logoFixed,
        "logo_text": logoText,
        "logo_height": logoHeight,
        "logo_offset": logoOffset,
        "show_slider": showSlider,
        "slider_display": sliderDisplay,
        "slider_height": sliderHeight,
        "slider_engine": sliderEngine,
        "slider_category": sliderCategory,
        "slider_posts": sliderPosts,
        "slider_orderby": sliderOrderby,
        "slider_order": sliderOrder,
        "slider_interval": sliderInterval,
        "slider_pagination": sliderPagination,
        "slider_infobox": sliderInfobox,
        "slider_info_category": sliderInfoCategory,
        "slider_info_reviews": sliderInfoReviews,
        "slider_info_descriptions": sliderInfoDescriptions,
        "show_sidebar_main": showSidebarMain,
        "sidebar_main_scheme": sidebarMainScheme,
        "sidebar_main": sidebarMain,
        "show_sidebar_footer": showSidebarFooter,
        "sidebar_footer_scheme": sidebarFooterScheme,
        "sidebar_footer": sidebarFooter,
        "sidebar_footer_columns": sidebarFooterColumns,
        "show_contacts_in_footer": showContactsInFooter,
        "contacts_scheme": contactsScheme,
        "logo_footer": logoFooter,
        "logo_footer_retina": logoFooterRetina,
        "logo_footer_height": logoFooterHeight,
        "show_copyright_in_footer": showCopyrightInFooter,
        "copyright_scheme": copyrightScheme,
        "menu_footer": menuFooter,
        "footer_copyright": footerCopyright,
        "custom_code": customCode,
        "custom_css": customCss,
        "blog_style": blogStyle,
        "hover_style": hoverStyle,
        "hover_dir": hoverDir,
        "article_style": articleStyle,
        "dedicated_location": dedicatedLocation,
        "show_filters": showFilters,
        "blog_sort": blogSort,
        "blog_order": blogOrder,
        "posts_per_page": postsPerPage,
        "post_excerpt_maxlength": postExcerptMaxlength,
        "post_excerpt_maxlength_masonry": postExcerptMaxlengthMasonry,
        "single_style": singleStyle,
        "icon": icon,
        "alter_thumb_size": alterThumbSize,
        "show_featured_image": showFeaturedImage,
        "show_post_title": showPostTitle,
        "show_post_title_on_quotes": showPostTitleOnQuotes,
        "show_post_info": showPostInfo,
        "show_post_author": showPostAuthor,
        "show_post_tags": showPostTags,
        "show_post_related": showPostRelated,
        "post_related_count": postRelatedCount,
        "post_related_columns": postRelatedColumns,
        "show_post_comments": showPostComments,
        "blog_pagination": blogPagination,
        "blog_counters": blogCounters,
        "close_category": closeCategory,
        "show_date_after": showDateAfter,
        "substitute_gallery": substituteGallery,
        "gallery_instead_image": galleryInsteadImage,
        "gallery_max_slides": galleryMaxSlides,
        "substitute_audio": substituteAudio,
        "substitute_video": substituteVideo,
        "show_share": showShare,
        "show_share_counters": showShareCounters,
        "share_caption": shareCaption,
        "0": the0,
        "time": time,
        "fonts": fonts == null ? [] : List<dynamic>.from(fonts!.map((x) => x)),
        "icons": icons == null ? [] : List<dynamic>.from(icons!.map((x) => x)),
        "dynamic_elements_ids": dynamicElementsIds == null
            ? []
            : List<dynamic>.from(dynamicElementsIds!.map((x) => x)),
        "status": status,
        "css": css,
      };
}
