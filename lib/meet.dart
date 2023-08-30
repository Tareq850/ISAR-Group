import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';
import 'abacus.dart';
import 'draw.dart';

class VideoConferencePage extends StatefulWidget {
  final conferenceID;
  final user;
  final id;
  final course_id;

  const VideoConferencePage(this.conferenceID, this.user, this.id, this.course_id, {Key? key})
      : super(key: key);

  @override
  State<VideoConferencePage> createState() => VideoConferencePageState();
}
class VideoConferencePageState extends State<VideoConferencePage> {
  List<IconData> customIcons = [
    Icons.phone,
    Icons.cookie,
    Icons.speaker,
    Icons.air,
    Icons.blender,
    Icons.file_copy,
    Icons.place,
    Icons.phone_android,
    Icons.phone_iphone,
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: ZegoUIKitPrebuiltVideoConference(
        appID: 454540219, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
        appSign: "c329bbbcd8db9dd6d6e3a48584eb344ee4f9cc04dc67c139369251f5ad0be412", // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
        userID: widget.id.toString(),
        userName: widget.user['name'].toString(),
        conferenceID: widget.course_id.toString(),
        config: ZegoUIKitPrebuiltVideoConferenceConfig(

          avatarBuilder: (BuildContext context, Size size, ZegoUIKitUser? user, Map extraInfo) {
            return user != null
                ? Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
            )
                : const SizedBox();
          },
          bottomMenuBarConfig: ZegoBottomMenuBarConfig(
            maxCount: 5,
            extendButtons: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(60, 60), backgroundColor: const Color(0xffffffff).withOpacity(0.6),
                    shape: const CircleBorder(),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return DrawingPage();
                    }));
                  },
                  child: Icon(customIcons[1]),
                ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(60, 60), backgroundColor: const Color(0xffffffff).withOpacity(0.6),
                  shape: const CircleBorder(),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return Abacus();
                  }));
                },
                child: Icon(customIcons[2]),
              ),
            ],
            buttons: [
              ZegoMenuBarButtonName.toggleCameraButton,
              ZegoMenuBarButtonName.toggleMicrophoneButton,
              ZegoMenuBarButtonName.switchAudioOutputButton,
              ZegoMenuBarButtonName.leaveButton,
              ZegoMenuBarButtonName.switchCameraButton,
              ZegoMenuBarButtonName.chatButton,
            ],

          ),
          onLeaveConfirmation: (BuildContext context) async {
            return await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: AlertDialog(
                    backgroundColor: Color(0xff01953D),
                    title: const Text("مغادرة الجلسة",
                        style: TextStyle(color: Colors.white)),
                    content: const Text(
                        "هل أنت متأكد من رغبتك في مغادرة الجلسة؟",
                        style: TextStyle(color: Colors.white)),
                    actions: [
                      ElevatedButton(
                        child: const Text("تراجع",),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                      ElevatedButton(
                        child: const Text("تأكيد"),
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),

    );
  }
}

/*class VideoConferencePageState extends State<VideoConferencePage> {
  /*final serverText = TextEditingController();
  final roomText = TextEditingController(text: "omni_room_sample_1234");
  final subjectText = TextEditingController(text: "Subject1");
  final nameText = TextEditingController(text: "User1");
  final emailText = TextEditingController(text: "fake1@email.com");
  final iosAppBarRGBAColor =
  TextEditingController(text: "#0080FF80"); //transparent blue
  bool? isAudioOnly = false;
  bool? isAudioMuted = false;
  bool? isVideoMuted = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _openDrawingPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return DrawingPage();
    }));
  }*/

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('${widget.conferenceID['course_name']}'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0, vertical: 20
          ),
          child: meetConfig(),
        ),
      ),
    );
  }

  Widget meetConfig() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 64.0,
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Theme.of(context).colorScheme.secondary)),
                    onPressed: _openDrawingPage,
                    child: Text(
                      'فتح لوحة الرسم',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ),
              ),
              const Expanded(flex: 1, child: SizedBox()),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 64.0,
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Theme.of(context).colorScheme.secondary)),
                    onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context){return Abacus();}));},
                    child: Text(
                      'فتح اباكوس',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 50),
          SizedBox(
            height: 64.0,
            width: double.maxFinite,
            child: widget.user['type'] == 'طالب'
                ? ElevatedButton(
              onPressed: () {
                _startJitsiMeeting();
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Theme.of(context).primaryColor)),
                  child: const Text(
                    "انضم الى الجلسة",
                    style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
                : ElevatedButton(
                    onPressed: () {
                     _joinMeeting();
                  },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Theme.of(context).primaryColor)),
                    child: const Text(
                      "ابدأ الجلسة",
                      style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          const SizedBox(
            height: 48.0,
          ),
        ],
      ),
    );
  }

  _joinMeeting() async {
    final String? serverUrl =
    serverText.text.trim().isEmpty ? null : serverText.text;
    Map<String, Object> featureFlags = {
      'add-people.enabled': true,
      'audio-focus.disabled': false,
      'calendar.enabled': true,
      'pip-while-screen-sharing.enabled': true,
      'pip.enabled': true,
      'recording.enabled': true,
      'start page.enabled' : true
    };

    Map<String, Object?> configOverrides = {
      // الأمور المتعلقة بواجهة المستخدم والأدوات
      'toolbarButtons': ['microphone', 'camera', 'tileview', 'fullscreen'],
      'overflowMenuButtons': ['chat', 'raisehand', 'participants', 'invite', 'settings', 'tileview', 'filmstrip'],
      'filmStripOnly': true,
      'disableInviteFunctions': true,
      'disableDeepLinking': true,

      // الأمور المتعلقة بالصوت والفيديو
      'startAudioMuted': 2, // 0: غير مكتوم, 1: مكتوم, 2: مكتوم افتراضيا
      'startVideoMuted': 2, // 0: غير مكتوم, 1: مكتوم, 2: مكتوم افتراضيا
      'startWithAudioMuted': true,
      'startWithVideoMuted': true,
      //'preferredVideoQuality': FeatureFlagVideoQuality.LOW,

      // الأمور المتعلقة بالشاشة المشتركة
      'desktopSharingFrameRate': 30,
      'desktopSharingScreen': 'screen',
      'desktopSharingSourceDevice': 'screen',

      // الأمور المتعلقة بالتسجيل والبث المباشر
      'liveStreamingEnabled': true,
      'fileRecordingsEnabled': true,
      'fileRecordingsServiceEnabled': true,
      'fileRecordingsServiceSharingEnabled': true,

      // الأمور المتعلقة بالترجمة واللغة
      'transcribingEnabled': true,
      'transcribingInterimResults': true,
      'transcribingLanguage': 'ar',
      'closeCaptionEnabled': true,
      'channelLastN': 4,

      // أمور متنوعة
      'disableJoinLeaveNotifications': false,
      'disableRemoteMute': false,
      'enableCalendarIntegration': true,
      'enableClosePage': false,
      'disableAutoFocus': false,
      'disableAudioLevels': false,
    };

    var options = JitsiMeetingOptions(
      roomNameOrUrl: widget.course_id,
      serverUrl: serverUrl,
      subject: widget.conferenceID['course_name'],
      //token: widget.user['token'],
      isAudioMuted: isAudioMuted,
      isAudioOnly: isAudioOnly,
      isVideoMuted: isVideoMuted,
      userDisplayName: widget.user['name'],
      userEmail: widget.user['email'],
      featureFlags: featureFlags,
      configOverrides: configOverrides,
    );

    await JitsiMeetWrapper.joinMeeting(
      options: options,
      listener: JitsiMeetingListener(
        onOpened: () => debugPrint("onOpened"),
        onConferenceWillJoin: (url) {
          debugPrint("onConferenceWillJoin: url: $url");
        },
        onConferenceJoined: (url) {
          debugPrint("onConferenceJoined: url: $url");
        },
        onConferenceTerminated: (url, error) {
          debugPrint("onConferenceTerminated: url: $url, error: $error");
        },
        onAudioMutedChanged: (isMuted) {
          debugPrint("onAudioMutedChanged: isMuted: $isMuted");
        },
        onVideoMutedChanged: (isMuted) {
          debugPrint("onVideoMutedChanged: isMuted: $isMuted");
        },
        onScreenShareToggled: (participantId, isSharing) {
          debugPrint(
            "onScreenShareToggled: participantId: $participantId, "
                "isSharing: $isSharing",
          );
        },
        onParticipantJoined: (email, name, role, participantId) {
          debugPrint(
            "onParticipantJoined: email: $email, name: $name, role: $role, "
                "participantId: $participantId",
          );
        },
        onParticipantLeft: (participantId) {
          debugPrint("onParticipantLeft: participantId: $participantId");
        },
        onParticipantsInfoRetrieved: (participantsInfo, requestId) {
          debugPrint(
            "onParticipantsInfoRetrieved: participantsInfo: $participantsInfo, "
                "requestId: $requestId",
          );
        },
        onChatMessageReceived: (senderId, message, isPrivate) {
          debugPrint(
            "onChatMessageReceived: senderId: $senderId, message: $message, "
                "isPrivate: $isPrivate",
          );
        },
        onChatToggled: (isOpen) => debugPrint("onChatToggled: isOpen: $isOpen"),
        onClosed: () => debugPrint("onClosed"),
      ),);
  }

  void _startJitsiMeeting() async {
    final String? serverUrl =
    serverText.text.trim().isEmpty ? null : serverText.text;
    Map<String, Object> featureFlags = {
      'add-people.enabled': false,
      'calendar.enabled': false,
      'filmstrip.enabled': false,
      'invite.enabled': false,
      'kick-out.enabled': false,
      'pip.enabled': true,
      'pip-while-screen-sharing.enabled': true,
    };
    Map<String, Object?> configOverrides = {
      // الأمور المتعلقة بواجهة المستخدم والأدوات
      'toolbarButtons': ['microphone', 'camera', 'tileview', 'fullscreen'],
      'overflowMenuButtons': ['chat', 'raisehand', 'participants', 'filmstrip'],
      'filmStripOnly': true,
      'disableInviteFunctions': true,
      'disableDeepLinking': true,

      // الأمور المتعلقة بالصوت والفيديو
      'startAudioMuted': 2, // 0: غير مكتوم, 1: مكتوم, 2: مكتوم افتراضيا
      'startVideoMuted': 2, // 0: غير مكتوم, 1: مكتوم, 2: مكتوم افتراضيا
      'startWithAudioMuted': true,
      'startWithVideoMuted': true,
      //'preferredVideoQuality': FeatureFlagVideoQuality.LOW,

      // الأمور المتعلقة بالشاشة المشتركة
      'desktopSharingFrameRate': 30,
      'desktopSharingScreen': 'screen',
      'desktopSharingSourceDevice': 'screen',

      // الأمور المتعلقة بالتسجيل والبث المباشر
      'liveStreamingEnabled': false,
      'fileRecordingsEnabled': false,
      'fileRecordingsServiceEnabled': false,
      'fileRecordingsServiceSharingEnabled': false,

      // الأمور المتعلقة بالترجمة واللغة
      'transcribingEnabled': true,
      'transcribingInterimResults': true,
      'transcribingLanguage': 'ar',
      'closeCaptionEnabled': true,
      'channelLastN': 4,

      // أمور متنوعة
      'disableJoinLeaveNotifications': false,
      'disableRemoteMute': false,
      'enableCalendarIntegration': false,
      'enableClosePage': false,
      'disableAutoFocus': false,
      'disableAudioLevels': false,
    };

    var options = JitsiMeetingOptions(
      roomNameOrUrl: widget.course_id,
      serverUrl: serverUrl,
      subject: widget.conferenceID['course_name'],
      //token: tokenText.text,
      isAudioMuted: isAudioMuted,
      isAudioOnly: isAudioOnly,
      isVideoMuted: isVideoMuted,
      userDisplayName: widget.user['name'],
      userEmail: widget.user['email'],
      featureFlags: featureFlags,
      configOverrides : configOverrides,
    );
    await JitsiMeetWrapper.joinMeeting(
      options: options,
      listener: JitsiMeetingListener(
        onOpened: () => debugPrint("onOpened"),
        onConferenceWillJoin: (url) {
          debugPrint("onConferenceWillJoin: url: $url");
        },
        onConferenceJoined: (url) {
          debugPrint("onConferenceJoined: url: $url");
        },
        onConferenceTerminated: (url, error) {
          debugPrint("onConferenceTerminated: url: $url, error: $error");
        },
        onAudioMutedChanged: (isMuted) {
          debugPrint("onAudioMutedChanged: isMuted: $isMuted");
        },
        onVideoMutedChanged: (isMuted) {
          debugPrint("onVideoMutedChanged: isMuted: $isMuted");
        },
        onScreenShareToggled: (participantId, isSharing) {
          debugPrint(
            "onScreenShareToggled: participantId: $participantId, "
                "isSharing: $isSharing",
          );
        },
        onParticipantJoined: (email, name, role, participantId) {
          debugPrint(
            "onParticipantJoined: email: $email, name: $name, role: طالب, "
                "participantId: $participantId",
          );
        },
        onParticipantLeft: (participantId) {
          debugPrint("onParticipantLeft: participantId: $participantId");
        },
        onParticipantsInfoRetrieved: (participantsInfo, requestId) {
          debugPrint(
            "onParticipantsInfoRetrieved: participantsInfo: $participantsInfo, "
                "requestId: $requestId",
          );
        },
        onChatMessageReceived: (senderId, message, isPrivate) {
          debugPrint(
            "onChatMessageReceived: senderId: $senderId, message: $message, "
                "isPrivate: $isPrivate",
          );
        },
        onChatToggled: (isOpen) => debugPrint("onChatToggled: isOpen: $isOpen"),
        onClosed: () => debugPrint("onClosed"),
      ),);
  }
}*/






