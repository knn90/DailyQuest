final class RemoteUser {
  final String id;

  const RemoteUser({required this.id});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = id;
    return data;
  }

  static RemoteUser fromJson(Map<String, dynamic> json) {
    return RemoteUser(id: json['user_id']);
  }
}
