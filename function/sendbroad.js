var admin = require("firebase-admin");

var serviceAccount = require("C:/Users/joaqu/Documents/Flutter/flutter_fcm/serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

var db = admin.firestore();

async function start(){
    var topics = [];
    const col = await db.collection('topics').get();
    col.forEach((doc)=>{
        topics.push(doc.id);
    })
    console.log(topics)
    var message = {
        notification: {
          title: '850',
          body: '2:45'}
    };
    admin.messaging().sendToDevice(topics,message)
        .then((response) => {
            // Response is a message ID string.
            console.log('Successfully sent message:', response);
        })
        .catch((error) => {
            console.log('Error enviando el mensaje:', error);
        });      
}
// This registration token comes from the client FCM SDKs.

//token: registrationToken
start();