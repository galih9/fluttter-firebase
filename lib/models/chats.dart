class ChatTextModel {
  final String avatar;
  final String name;
  final String message;
  final String time;
  final int unreadMessages;

  ChatTextModel(
      {required this.avatar,
      required this.name,
      required this.message,
      required this.time,
      required this.unreadMessages});
}
