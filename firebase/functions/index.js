const functions = require("firebase-functions");
const request = require('request');

var admin = require("firebase-admin");

var serviceAccount = require("../anilist-67a8a-firebase-adminsdk-iqlms-6684604cfc.json");

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: "https://anilist-67a8a-default-rtdb.firebaseio.com"
});

exports.getUserName = functions.https.onCall(async (_, context) => {
    const uid = context.auth.uid;
    var response = await admin.firestore().collection('users').doc(uid).get();
    return (response.get('name'));
});