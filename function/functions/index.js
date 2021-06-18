const functions = require("firebase-functions");

var admin = require("firebase-admin");

var serviceAccount = require("C:/Users/joaqu/Documents/Flutter/flutter_fcm/serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

exports.sendChatNotifications = functions.region('southamerica-east1').firestore.document('places/{placeid}')
.onCreate(async (placeSnapshot, context) => {
  const foto = placeSnapshot.data();
  const creadorID = String(foto.userOwner);
  justUser = creadorID.replace("users/","");
  console.log('El duenio sera: ', justUser);
  const creadorDoc = await admin.firestore().collection('users').doc(justUser).get();
  //firebase.firestore().collection('status').doc(creadorID).get();
  if (creadorDoc.empty) {
    console.log('No se encontró al creador');
    return;
  } else {
    console.log('Document token:', creadorDoc.data().dispositivo);
  }

  // participants.forEach(async (snapshot) => {
  //   const uid = snapshot.data().user;
  //   if (uid === creadorId) { return; }
    
  //   const user = await admin.firestore().doc(`users/${uid}`).get(); //Objeto escucha
  //   const payload = {
  //     notification: {
  //       title: 'Notificacion de envío',//thread.senderFirstName,
  //       body: foto.description,
  //       //icon: thread.senderProfilePictureURL,
  //       //image: thread.url,
  //       sound: 'default',
  //     }
  //   };
  //   await admin.messaging().sendToDevice([user.data().fcmToken], payload);
  // });
});

// exports.makeUppercase = functions.region('southamerica-east1').firestore.document('places/{placeId}')
// .onCreate((snap, context) => {
//   const original = snap.data().original;
//   console.log('Hola mundo', context.params.placeId, original);
//   const uppercase = "procesada";//original.toUpperCase();
//   return snap.ref.set({uppercase}, {merge: true});
// });


//////////////////////////////////////////////////////////////////////////////////////////////
/////// PARA USAR EMULADORES:                         ////////////////////////////////////////
///////- firebase init emulators                      ////////////////////////////////////////
///////- firebase emulators:start                     ////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////

