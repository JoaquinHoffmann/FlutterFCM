var admin = require("firebase-admin");

var serviceAccount = require("C:/Users/joaqu/Documents/Flutter/flutter_fcm/serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

// This registration token comes from the client FCM SDKs.
var registrationToken = 'f_Lx9Ok8Rl6OeAfqhlJQaW:APA91bHjS-a357fwa2L20zdGg98otQKJOmOMUEY_gT3ezXa_3WR7ORU1ItqxgTfjk0zEvCG5N7nutuiBx-KajZbKLKOdE0ZPkM0bnOW5fXb47sNKCRsSMrDqpOl8PIhXGMKNegqOzmnQ';

var message = {
  notification: {
    title: '850',
    body: '2:45'
  },
  //token: registrationToken
};

// Send a message to the device corresponding to the provided
// registration token.

// admin.messaging().send(message)
//   .then((response) => {
//     console.log('Mensaje enviado: ', response);
//   })
//   .catch((error) => {
//     console.log('Error enviando el mensaje: ', error);
//   });

admin.messaging().sendToTopic('Samsung',message)
  .then((response) => {
    // Response is a message ID string.
    console.log('Successfully sent message:', response);
  })
  .catch((error) => {
    console.log('Error enviando el mensaje:', error);
  });