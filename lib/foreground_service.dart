import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'call_manager.dart';

Future<void> startCallForegroundService() async {
  if (await FlutterForegroundTask.isRunningService) return;

  await FlutterForegroundTask.startService(
    serviceTypes: [ForegroundServiceTypes.phoneCall],
    notificationTitle: 'Panggilan video Anda',
    notificationText: 'Ketuk untuk kembali ke panggilan',
    notificationButtons: const [
      NotificationButton(id: 'end_call', text: 'Tutup'),
    ],
    callback: startCallback,
  );
}

Future<void> stopCallForegroundService() async {
  if (await FlutterForegroundTask.isRunningService) {
    await FlutterForegroundTask.stopService();
  }
}

@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(CallTaskHandler());
}

class CallTaskHandler extends TaskHandler {
  @override
  void onNotificationPressed() {
    FlutterForegroundTask.launchApp();
  }

  @override
  void onButtonPressed(String id) {
    if (id == 'end_call') {
      isCallActive = false;
      FlutterForegroundTask.stopService();
    }
  }

  @override
  Future<void> onStart(DateTime t, TaskStarter s) async {}

  @override
  void onRepeatEvent(DateTime t) {}

  @override
  Future<void> onDestroy(DateTime t, bool isTimeout) async {}
}
