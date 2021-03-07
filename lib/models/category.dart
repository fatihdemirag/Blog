class Category {
  String title,description;
  int id;

  Category({this.id, this.title,this.description});

  factory Category.fromJson(Map<String,dynamic> json)
  {
    return Category(
      title:json["name"],
      id:json["id"],
      description:json["description"],
    );
  }
}
