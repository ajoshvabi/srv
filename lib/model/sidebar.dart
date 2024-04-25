class SidebarItem {
  final String id;
  final int order;
  final String englishName;
  final String malayalamName;
  final int status;
  final List<dynamic> subMenu;

  SidebarItem({
    required this.id,
    required this.order,
    required this.englishName,
    required this.malayalamName,
    required this.status,
    required this.subMenu,
  });

  factory SidebarItem.fromJson(Map<String, dynamic> json) {
    return SidebarItem(
      id: json['_id'],
      order: json['order'],
      englishName: json['english_name'],
      malayalamName: json['malayalam_name'],
      status: json['status'],
      subMenu: json['sub_menu'] ?? [],
    );
  }
}
