class Product {
    int id;
    String title;
    dynamic price;
    String description;
    String category;
    String image;
    //Rating rating;

    Product({
        required this.id,
        required this.title,
        required this.price,
        required this.description,
        required this.category,
        required this.image,
        //required this.rating,
    });
    factory Product.fromJson(Map<String, dynamic> json){
        return Product(
          id: json['id']??0, 
          title: json['title']??'', 
          price: json['price']??0,
          description: json['description']??'', 
          category: json['category']??'',
          image: json['image']??'' ) ;
    }
}

enum Category {
    ELECTRONICS,
    JEWELERY,
    MEN_S_CLOTHING,
    WOMEN_S_CLOTHING
}

class Rating {
    double rate;
    int count;

    Rating({
        required this.rate,
        required this.count,
    });

}
