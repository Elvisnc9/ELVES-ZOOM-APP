import 'package:flutter_riverpod/legacy.dart';

final callStateProvider = StateNotifierProvider<CallStateNotifier, CallState>((ref) {
  return CallStateNotifier();
});

class CallState {
  final bool isMuted;
  final bool isCameraOn;
  final bool isSpeakerOn;
  final bool isScreenSharing;
  final Duration callDuration;
  final String? activeMeetingId;

  CallState({
    this.isMuted = false,
    this.isCameraOn = true,
    this.isSpeakerOn = true,
    this.isScreenSharing = false,
    this.callDuration = Duration.zero,
    this.activeMeetingId,
  });

  CallState copyWith({
    bool? isMuted,
    bool? isCameraOn,
    bool? isSpeakerOn,
    bool? isScreenSharing,
    Duration? callDuration,
    String? activeMeetingId,
  }) {
    return CallState(
      isMuted: isMuted ?? this.isMuted,
      isCameraOn: isCameraOn ?? this.isCameraOn,
      isSpeakerOn: isSpeakerOn ?? this.isSpeakerOn,
      isScreenSharing: isScreenSharing ?? this.isScreenSharing,
      callDuration: callDuration ?? this.callDuration,
      activeMeetingId: activeMeetingId ?? this.activeMeetingId,
    );
  }
}

class CallStateNotifier extends StateNotifier<CallState> {
  CallStateNotifier() : super(CallState());

  void toggleMute() => state = state.copyWith(isMuted: !state.isMuted);
  void toggleCamera() => state = state.copyWith(isCameraOn: !state.isCameraOn);
  void toggleSpeaker() => state = state.copyWith(isSpeakerOn: !state.isSpeakerOn);
  void toggleScreenShare() => state = state.copyWith(isScreenSharing: !state.isScreenSharing);
  
  void startCall(String meetingId) {
    state = state.copyWith(activeMeetingId: meetingId);
    _startTimer();
  }

  void endCall() {
    state = CallState();
  }

  void _startTimer() {
    // In real app, use Timer.periodic
  }
}