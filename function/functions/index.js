const functions = require("firebase-functions");

var admin = require("firebase-admin");

var serviceAccount = require("C:/Users/joaqu/Documents/Flutter/flutter_fcm/serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

export.mensajeGeneral(){
    var usuarios = [];
    const col = await db.collection('users').get();
    col.forEach((doc)=>{
        usuarios.push(doc.id);
    })
    console.log(topics)
    var message = {
        notification: {
          title: 'Gracias por elegir Civilis',
          body: 'Te enviaremos información cada vez que llegue una propuesta e tú interés'}
    };
    admin.messaging().sendToDevice(usuarios,message)
        .then((response) => {
            // Response is a message ID string.
            console.log('Mensaje enviado con éxito:', response);
        })
        .catch((error) => {
            console.log('Error enviando el mensaje:', error);
        });
}
// This registration token comes from the client FCM SDKs.

//token: registrationToken



exports.sendPushNotification = functions.firestore.document('/places/{notificationId}').onCreate((snap, context) => {
    var values = snap.data();
    var token = values.fcmToken;     
    
    var payload = {
      notification: {
        title: "Tutulo correspondiente", //values.title,
        body: "Cuerpo correspondiente"//values.message
        }    
    }   

    return mensajeGeneral();
    //return admin.messaging().sendToDevice(token, payload);
  });