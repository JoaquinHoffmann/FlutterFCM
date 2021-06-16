const functions = require("firebase-functions");

var admin = require("firebase-admin");

var serviceAccount = require("C:/Users/joaqu/Documents/Flutter/flutter_fcm/serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

exports.sendChatNotifications = functions.firestore.document('channels/{cid}/thread/{did}').onCreate(async (threadSnapshot, context) => {
  const thread = threadSnapshot.data();
  const senderId = thread.senderID;

  console.log(`Finding channel participants with channel ${context.params.cid}`);
  const participants = await admin.firestore().collection('channel_participation').where('channel', '==', context.params.cid).get();
  if (participants.empty) {
    console.log('There are no participants to send to.');
    return;
  }

  participants.forEach(async (snapshot) => {
    const uid = snapshot.data().user;
    if (uid === senderId) { return; }

    const user = await admin.firestore().doc(`users/${uid}`).get();

    const payload = {
      notification: {
        title: thread.senderFirstName,
        body: thread.content,
        icon: thread.senderProfilePictureURL,
        image: thread.url,
        sound: 'default',
      }
    };
    await admin.messaging().sendToDevice([user.data().fcmToken], payload);
  });
});