import 'user_model.dart';

enum MeetingStatus { ongoing, upcoming, ended }

class Meeting {
  final String id;
  final String title;
  final String? description;
  final User host;
  final List<User> participants;
  final DateTime startTime;
  final Duration duration;
  final MeetingStatus status;
  final String? meetingLink;
  final bool isAiAssisted;

  Meeting({
    required this.id,
    required this.title,
    this.description,
    required this.host,
    required this.participants,
    required this.startTime,
    required this.duration,
    this.status = MeetingStatus.upcoming,
    this.meetingLink,
    this.isAiAssisted = false,
  });

  String get formattedTime {
    final hour = startTime.hour.toString().padLeft(2, '0');
    final minute = startTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String get durationText {
    final hours = duration.inHours;
    final mins = duration.inMinutes % 60;
    if (hours > 0) {
      return '${hours}h ${mins > 0 ? '${mins}m' : ''}';
    }
    return '${mins}m';
  }
}