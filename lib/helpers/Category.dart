class Category {
  final Map<int, List<String>> _categories = {
    0: ["General", "true"],
    1: ["Business", "false"],
    2: ["Technology", "false"],
    3: ["Sports", "false"],
    4: ["Entertainment", "false"],
    5: ["Health", "false"],
    6: ["Science", "false"]
  };

  String category(int index) {
    return _categories[index][0];
  }

  Future<String> selectedCategory(int index, int oldIndex) async {
    _categories[oldIndex][1] = "false";
    _categories[index][1] = "true";
    return _categories[index][0];
  }

  int get length => _categories.length;

  String selected(int index) => _categories[index][1];
}
