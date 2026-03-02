class Category {
  final String? id;
  final String? name;
  final String? slug;
  final String? image;

  Category({
    this.id,
    this.name,
    this.slug,
    this.image,
  });
}

class CategoryResponse {
  final String? message;
  final List<Category>? data;

  CategoryResponse({
    this.message,
    this.data,
  });
}
