const functions = require("firebase-functions");

var admin = require("firebase-admin");

var serviceAccount = require("C:/Users/joaqu/Documents/Flutter/flutter_fcm/serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

exports.sendPushNotification = functions.firestore.document('/places/{notificationId}').onCreate((snap, context) => {
    var values = snap.data();
    var token = values.fcmToken;     
    
    var payload = {
      notification: {
        title: "Tutulo correspondiente", //values.title,
        body: "Cuerpo correspondiente"//values.message
        }    
    }   
    
    return admin.messaging().sendToDevice(token, payload);
  });