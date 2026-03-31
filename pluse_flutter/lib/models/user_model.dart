class User {
  final String id;
  final String name;
  final String avatarUrl;
  final String? role;
  final bool isHost;

  User({
    required this.id,
    required this.name,
    required this.avatarUrl,
    this.role,
    this.isHost = false,
  });
}

class Participant {
  final User user;
  final bool isCameraOn;
  final bool isMicOn;
  final bool isScreenSharing;

  Participant({
    required this.user,
    this.isCameraOn = true,
    this.isMicOn = true,
    this.isScreenSharing = false,
  });
}