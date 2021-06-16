import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:flutter_fcm/User/bloc/bloc_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_fcm/User/ui/screens/sign_in_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  print(message.data);
  flutterLocalNotificationsPlugin.show(
      message.data.hashCode,
      message.data['title'],
      message.data['body'],
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channel.description,
        ),
      ));
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String token;
  List subscribed = [];
  List topics = [
    'Samsung',
    'Apple',
    'Huawei',
    'Nokia',
    'Sony',
    'HTC',
    'Lenovo'
  ];
  @override
  void initState() {
    super.initState();
    var initialzationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
    InitializationSettings(android: initialzationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: android?.smallIcon,
              ),
            ));
      }
    });
    getToken();
    //getTopics();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: UserBloc(),
      child: MaterialApp(
        //Queremos exponer el bloc desde el widget más alto, que es este
        title: 'Hola mundo',
        theme: ThemeData(),
        home: SignInScreen(),
      ),
    );
  }
  getToken() async {
  var token = await FirebaseMessaging.instance.getToken();
  setState(() {
    token = token; //Para que el token esté dispónible en el resto del programa
  });
  print('Tu token es:\n\n\n $token \n\n\n');
}
getTopics() async {
    await FirebaseFirestore.instance
        .collection('topics')
        .get()
        .then((value) => value.docs.forEach((element) {
      if (token == element.id) {
        // En este caso estamos tomando element = documento de la colección
        // Da una lista con los documentos suscritos por el usuario (que tienen la palabra 'subscribed' dentro y coicide el token)
        subscribed = element.data().keys.toList();
      }
    }));
    setState(() {
      subscribed = subscribed;
    });
  }
}



  


/*return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('appbar'),
          ),
          body: ListView.builder(
            itemCount: topics.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(topics[index]),
              // El trailing a continuación revisa primero que los topicos estén suscritos
              trailing: subscribed.contains(topics[index])
                  ? ElevatedButton(
                onPressed: () async {
                  // Al apretar en un un tópico suscrito se desinscribe y elimina el campo
                  print('Hola1');
                  await FirebaseMessaging.instance
                      .unsubscribeFromTopic(topics[index]);
                  await FirebaseFirestore.instance
                      .collection('topics')
                      .doc(token)
                      .update({topics[index]: FieldValue.delete()});
                  setState(() {
                    subscribed.remove(topics[index]);
                  });
                },
                child: Text('unsubscribe'),
              )
                  : ElevatedButton(
                  onPressed: () async {
                    print('object');
                    await FirebaseMessaging.instance
                        .subscribeToTopic(topics[index]);

                    await FirebaseFirestore.instance
                        .collection('topics')
                        .doc(token)
                        .set({topics[index]: 'subscribe'},
                        SetOptions(merge: true));
                    setState(() {
                      subscribed.add(topics[index]);
                    });
                  },
                   child: Text('subscribe')
                  ),
            ),
          ),
    ));*/