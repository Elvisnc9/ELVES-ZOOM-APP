import 'package:flutter_riverpod/legacy.dart';
import '../models/meeting_model.dart';
import '../models/user_model.dart';

final meetingsProvider = StateNotifierProvider<MeetingsNotifier, List<Meeting>>((ref) {
  return MeetingsNotifier();
});

final currentFilterProvider = StateProvider<MeetingStatus>((ref) => MeetingStatus.ongoing);

class MeetingsNotifier extends StateNotifier<List<Meeting>> {
  MeetingsNotifier() : super(_dummyMeetings);

  static final List<Meeting> _dummyMeetings = [
    Meeting(
      id: '1',
      title: 'Weekly Design Sync',
      description: 'UI/UX team weekly sync',
      host: User(
        id: 'h1',
        name: 'Alex Chen',
        avatarUrl: 'https://i.pravatar.cc/150?img=11',
        role: 'Product Designer',
      ),
      participants: [
        User(id: 'p1', name: 'Sarah Miller', avatarUrl: 'https://i.pravatar.cc/150?img=5'),
        User(id: 'p2', name: 'James Wilson', avatarUrl: 'https://i.pravatar.cc/150?img=3'),
        User(id: 'p3', name: 'Emma Davis', avatarUrl: 'https://i.pravatar.cc/150?img=9'),
      ],
      startTime: DateTime.now().add(const Duration(minutes: 30)),
      duration: const Duration(minutes: 45),
      status: MeetingStatus.upcoming,
      isAiAssisted: true,
    ),
    Meeting(
      id: '2',
      title: 'Client Feedback Session',
      host: User(
        id: 'h2',
        name: 'Maria Garcia',
        avatarUrl: 'https://i.pravatar.cc/150?img=24',
        role: 'Project Manager',
      ),
      participants: [
        User(id: 'p4', name: 'John Doe', avatarUrl: 'https://i.pravatar.cc/150?img=12'),
        User(id: 'p5', name: 'Lisa Wong', avatarUrl: 'https://i.pravatar.cc/150?img=16'),
      ],
      startTime: DateTime.now(),
      duration: const Duration(hours: 1),
      status: MeetingStatus.ongoing,
    ),
    Meeting(
      id: '3',
      title: 'Engineering Standup',
      host: User(
        id: 'h3',
        name: 'David Kim',
        avatarUrl: 'https://i.pravatar.cc/150?img=33',
      ),
      participants: [
        User(id: 'p6', name: 'Chris Lee', avatarUrl: 'https://i.pravatar.cc/150?img=59'),
      ],
      startTime: DateTime.now().subtract(const Duration(hours: 2)),
      duration: const Duration(minutes: 15),
      status: MeetingStatus.ended,
    ),
  ];

  List<Meeting> getByStatus(MeetingStatus status) {
    return state.where((m) => m.status == status).toList();
  }

  void joinMeeting(String meetingId) {
    // Logic to join meeting
  }
}