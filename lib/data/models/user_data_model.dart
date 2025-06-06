class UserDataModel {
  static UserDataModel? currentUser;

  String name;
  String id;
  String email;
  List<String> favoriteEventsIds;
  UserDataModel({
    required this.name,
    required this.id,
    required this.email,
    required this.favoriteEventsIds,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'favoriteEventsIds': favoriteEventsIds,
      };

  UserDataModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          email: json['email'],
          name: json['name'],
          favoriteEventsIds:
              json['favoriteEventsIds'] != null ? List<String>.from(json['favoriteEventsIds']) : [],
        );
}
