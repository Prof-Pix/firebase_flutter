/* eslint-disable object-curly-spacing */
// The Cloud Functions for Firebase SDK to create Cloud Functions and triggers.
const functions = require("firebase-functions");
// const { onRequest } = require("firebase-functions/v2/https");
// const { onDocumentCreated } = require("firebase-functions/v2/firestore");

// The Firebase Admin SDK to access Firestore.
const admin = require("firebase-admin");
// const admin = require("firebase-admin/firestore");

admin.initializeApp();

exports.newUserSignUp = functions.auth.user().onCreate((user) => {
  const initialData = {
    name: user.displayName || "", // Use display name if available
    username: "",
    buttons: {
      greetings: {
        // Example category
        categoryId: "43535345",
        buttons: [
          {
            buttonId: "47568",
            buttonName: "Hello",
            language: "en",
            speechText: "Hello there!",
          },
          {
            buttonId: "86979",
            buttonName: "Welcome",
            language: "en",
            speechText: "Welcome!",
          },
        ],
      },
      // Add more categories as needed
    },
  };

  return admin.firestore().collection("users").doc(user.uid).set(initialData);
});
