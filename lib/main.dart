import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'call_page.dart';
import 'call_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterForegroundTask.init(
    androidNotificationOptions: AndroidNotificationOptions(
      channelId: 'call_channel',
      channelName: 'Panggilan',
      channelDescription: 'Sedang melakukan panggilan',
      channelImportance: NotificationChannelImportance.LOW,
      priority: NotificationPriority.LOW,
      onlyAlertOnce: true,
      showWhen: false,
      visibility: NotificationVisibility.VISIBILITY_PUBLIC,
    ),
    iosNotificationOptions: const IOSNotificationOptions(),
    foregroundTaskOptions:  ForegroundTaskOptions(
      eventAction: ForegroundTaskEventAction.repeat(5000),
      allowWakeLock: true,
      allowWifiLock: true,
    ),
  );

  FlutterForegroundTask.initCommunicationPort();
  FlutterForegroundTask.requestNotificationPermission();

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController userID = TextEditingController(text: 'user_1');
  final TextEditingController userName = TextEditingController(text: 'Iwan');

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // 🔁 kalau app dibuka dari notifikasi → balik ke call
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isCallActive && currentCallID != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CallPage(
              userID: currentUserID!,
              userName: currentUserName!,
              callID: currentCallID!,
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    userID.dispose();
    userName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Video Call')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: userID,
              decoration: const InputDecoration(labelText: 'User ID'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: userName,
              decoration: const InputDecoration(labelText: 'User Name'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              child: const Text('START CALL'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CallPage(
                      userID: userID.text.trim(),
                      userName: userName.text.trim(),
                      callID: 'room_123',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
