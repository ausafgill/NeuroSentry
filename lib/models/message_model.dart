class MessageModel {
  final String message;
  final String senderId;
  final DateTime timestamp;

  MessageModel({
    required this.message,
    required this.senderId,
    required this.timestamp,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      message: map['message'],
      senderId: map['senderId'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'senderId': senderId,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
