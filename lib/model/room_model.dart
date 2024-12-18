class RoomModel {
  String roomId = '';
  String title = '';
  String description = '';

  RoomModel({required this.title, required this.roomId});

  RoomModel.fromJson(Map<String, dynamic> json) {
    roomId = json['room_id'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['room_id'] = roomId;
    data['description'] = description;
    return data;
  }
}
