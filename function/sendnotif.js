var admin = require("firebase-admin");

var serviceAccount = require("C:/Users/joaqu/Documents/Flutter/flutter_fcm/serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

// This registration token comes from the client FCM SDKs.
var registrationToken = 'enKUHVltRBiJ38Q_l7rM4O:APA91bHk2Vivp4sP7h51ta-_BKK9l30Q4uf7RVBklepmeR6hurCHSa77cXslvwmVVDIGMgTpQlLoiBYG6SYd2xJ_gV4WjZmxkTxwT-1cTK9tslTCyP3ia6VKfFXmBNDNKs4i0CjqI48L';

var message = {
  notification: {
    title: '850',
    body: '2:45'
  },
  token: registrationToken
};

// Send a message to the device corresponding to the provided
// registration token.

admin.messaging().send(message)
  .then((response) => {
    console.log('Mensaje enviado: ', response);
  })
  .catch((error) => {
    console.log('Error enviando el mensaje: ', error);
  });

// admin.messaging().sendToTopic('Samsung',message)
//   .then((response) => {
//     // Response is a message ID string.
//     console.log('Successfully sent message:', response);
//   })
//   .catch((error) => {
//     console.log('Error sending message:', error);
//   });