/*import 'package:algitsin/core/extensions/size_extention.dart';
import 'package:algitsin/feature/service/auth/google_signin_provider.dart';
import 'package:algitsin/feature/view/login_page.dart';
import 'package:algitsin/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

class LoggedinWidget extends StatefulWidget {
  const LoggedinWidget({Key? key}) : super(key: key);

  @override
  State<LoggedinWidget> createState() => _LoggedinWidgetState();
}

class _LoggedinWidgetState extends State<LoggedinWidget> {

  String userId="";
    final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.greenAccent,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
     
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title.toString()),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body.toString())],
                  ),
                ),
              );
            });
      }
    });
}



  void showNotification() {
    setState(() {
      userId=user.uid;
    });
    flutterLocalNotificationsPlugin.show(
        0,
        "USER ID : $userId",
        "Title body is here",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name, channelDescription: channel.description,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.photoURL!),
            ),
            SizedBox(
              height: 10.0.h,
            ),
            Text(user.displayName!),
            Text(user.email!),
            ElevatedButton(
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSigninProvider>(context, listen: false);
                  provider.googleOut().then((value) =>
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SellerLogin())));
                },
                child: const Text("Çıkış Yap")),
              
          ],
        ),
      ),
    
    );
  }
}
*/
