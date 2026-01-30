import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'foreground_service.dart';
import 'call_manager.dart';

class CallPage extends StatefulWidget {
  final String userID;
  final String userName;
  final String callID;

  const CallPage({
    super.key,
    required this.userID,
    required this.userName,
    required this.callID,
  });

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  @override
  void initState() {
    super.initState();

    isCallActive = true;
    currentUserID = widget.userID;
    currentUserName = widget.userName;
    currentCallID = widget.callID;

    startCallForegroundService(); // 🔥 START SEKALI
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FlutterForegroundTask.minimizeApp(); // ✅ BENAR
        return false;
      },
      child: Scaffold(
        body: ZegoUIKitPrebuiltCall(
          appID: 708812434,
          appSign: "1898b0c9b245ef493e1a9fa9d536d2b974022617c23bc7ab0e882023ada10555",
          userID: widget.userID,
          userName: widget.userName,
          callID: widget.callID,

          events: ZegoUIKitPrebuiltCallEvents(
            onCallEnd: (event, defaultAction) {
              isCallActive = false;
              stopCallForegroundService();
              defaultAction.call();
            },
          ),

          config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
            ..pip = ZegoCallPIPConfig(
              enableWhenBackground: false,
            ),
        ),
      ),
    );
  }
}
