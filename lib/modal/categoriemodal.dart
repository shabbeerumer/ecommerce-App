/// categories : [{"name":"Women Dress","subcategory":["Wedding & Event","Tops & Sets","Watches"]},{"name":"Men Clothing & Fashion","subcategory":["Outwear & jackets","Formal Dress","Accessories"]},{"name":"Computer & Accessories","subcategory":["Laptop","Gaming PC","Official Equipment"]},{"name":"Auto Mobile","subcategory":["Cars","bike"]},{"name":"Kids & Toys","subcategory":["Shoes & Bags","Baby Clothing","Girls Toys"]},{"name":"Toys","subcategory":["Cycling","Sneakers","Swiming"]},{"name":"Jewelery","subcategory":["Necklace","Gold","Earing"]},{"name":"Cellphone & Tab","subcategory":["Sparts phone","Tablets","Accessories"]},{"name":"Furniture","subcategory":["Sofa","Bed","Home textile"]}]

class Categoriemodal {
  Categoriemodal({
    List<Categories>? categories,
  }) {
    _categories = categories;
  }

  Categoriemodal.fromJson(dynamic json) {
    if (json['categories'] != null) {
      _categories = [];
      json['categories'].forEach((v) {
        _categories?.add(Categories.fromJson(v));
      });
    }
  }
  List<Categories>? _categories;
  Categoriemodal copyWith({
    List<Categories>? categories,
  }) =>
      Categoriemodal(
        categories: categories ?? _categories,
      );
  List<Categories>? get categories => _categories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_categories != null) {
      map['categories'] = _categories?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// name : "Women Dress"
/// subcategory : ["Wedding & Event","Tops & Sets","Watches"]

class Categories {
  Categories({
    String? name,
    List<String>? subcategory,
  }) {
    _name = name;
    _subcategory = subcategory;
  }

  Categories.fromJson(dynamic json) {
    _name = json['name'];
    _subcategory =
        json['subcategory'] != null ? json['subcategory'].cast<String>() : [];
  }
  String? _name;
  List<String>? _subcategory;
  Categories copyWith({
    String? name,
    List<String>? subcategory,
  }) =>
      Categories(
        name: name ?? _name,
        subcategory: subcategory ?? _subcategory,
      );
  String? get name => _name;
  List<String>? get subcategory => _subcategory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['subcategory'] = _subcategory;
    return map;
  }
}
