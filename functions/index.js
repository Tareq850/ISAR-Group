/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.deleteOldDocuments = functions.pubsub.schedule('every 24 hours').timeZone('Etc/GMT')
  .onRun(async (context) => {
    const thresholdTimestamp = admin.firestore.Timestamp.now(); // الوقت الحالي
    const collectionRef = admin.firestore().collection('conferance'); // استبدل بمرجع جدولك

    const querySnapshot = await collectionRef.where('date', '<', thresholdTimestamp).get();

    const deletePromises = querySnapshot.docs.map(docSnapshot => docSnapshot.ref.delete());
    await Promise.all(deletePromises);

    return null;
  });


// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
