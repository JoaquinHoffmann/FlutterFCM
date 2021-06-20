const functions = require("firebase-functions");
var admin = require("firebase-admin");
//var serviceAccount = require("C:/Users/joaqu/Documents/Flutter/flutter_fcm/functions/claveCuentaServicio.json");
admin.initializeApp({
  //credential: admin.credential.cert(serviceAccount)
});
//////////////////////////////////////////////////////////////////////////
// Esta función acumulará los tokens de todos los usuarios en un documento
// dentro de la colección users
//////////////////////////////////////////////////////////////////////////
exports.acumularTokens = functions.region('southamerica-east1').firestore.document('users/{userid}')
.onCreate(async (userSnapshot, context) => {
  const foto = userSnapshot.data();
  const nombre2 = String(foto.name);
  const token = String(foto.dispositivo);
  console.log('El usuario :', nombre2, ' inició sesión');
  console.log('Se usó el dispositivo:', token);
  const acumulado = admin.firestore().collection('users').doc('Dispositivos').update({
    dispositivos: admin.firestore.FieldValue.arrayUnion(`(${nombre2}, ${token})`)
  })
});
/////////////////////////////////////////////////////////////////
//Esta función notifica al creador que se ha creado su propuesta
/////////////////////////////////////////////////////////////////
exports.notificarCreador = functions.region('southamerica-east1').firestore.document('places/{placeid}')
.onCreate(async (placeSnapshot, context) => {
  const foto = placeSnapshot.data();
  const creadorID = String(placeSnapshot.get("userDirection"));
  const nombreProp = foto.name;
  justUser = creadorID.replace("users/","");
  console.log('El dueño es: ', justUser);
  const creadorDoc = await admin.firestore().collection('users').doc(justUser).get();
  //firebase.firestore().collection('status').doc(creadorID).get();
  if (creadorDoc.empty) {
    console.log('No se encontró al creador');
    return;
  } else {
    console.log('Document token:', creadorDoc.data().dispositivo);
    token = creadorDoc.data().dispositivo;
    var message = {
      notification: {
        title: `Creaste la propuesta: ${nombreProp}`,
        body: 'Esta propuesta será votada y comentada por la comunidad, gracias por ayudar al desarrollo de tú comunidad'}
    };
    admin.messaging().sendToDevice(token,message)
        .then((response) => {
            // Response is a message ID string.
            console.log('Successfully sent message:', response);
        })
        .catch((error) => {
            console.log('Error enviando el mensaje:', error);
        });
  };
});
/////////////////////////////////////////////////////////////////
// Esta funcion envía una notificación general cuando se crea una propuesta
/////////////////////////////////////////////////////////////////
exports.generalPropuesta = functions.region('southamerica-east1').firestore.document('places/{placeid}')
.onCreate(async (placeSnapshot, context) => {
  const foto = placeSnapshot.data();
  const nombreProp = foto.name;
  const listaUsuarios = await admin.firestore().collection('users').doc('Dispositivos').get();
  //firebase.firestore().collection('status').doc(creadorID).get();
  if (listaUsuarios.empty) {
    console.log('No encuentro a los usuarios');
    return;
  } else {
    tokens = listaUsuarios.data().dispositivos;
    console.log('Mandando mails....', tokens[1]);
    var message = {
      notification: {
        title: `Se creó la propuesta: ${nombreProp}`,
        body: 'Puedes ayudar votando y/o comentando esta propuesta, gracias por involucrarte con la comunidad'}
    };
    for (let i = 0; i <= tokens.leght; i++){
      console.log('Empezando mail ', i);
      token = tokens[i][1];
      admin.messaging().sendToDevice(token,message)
          .then((response) => {
              // Response is a message ID string.
              console.log('Successfully sent message:', response);
          })
          .catch((error) => {
              console.log('Error enviando el mensaje:', error);
          });
        }
  };
});