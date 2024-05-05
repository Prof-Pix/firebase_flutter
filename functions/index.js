/* eslint-disable object-curly-spacing */

// const { onRequest } = require("firebase-functions/v2/https");
// const { onDocumentCreated } = require("firebase-functions/v2/firestore");

// The Cloud Functions for Firebase SDK to create Cloud Functions and triggers.
const functions = require("firebase-functions");
// The Firebase Admin SDK to access Firestore.
const admin = require("firebase-admin");

admin.initializeApp();

// For UUID (random generated id)
const { v4: uuidv4 } = require("uuid");

exports.newUserSignUp = functions.auth.user().onCreate((user) => {
  const initialUserData = {
    name: "",
    username: "",
    registrationDate: "",
    buttonCategories: [
      {
        categoryId: uuidv4(),
        categoryName: "SpeakEase",
        categoryButtons: [
          {
            buttonId: uuidv4(),
            buttonName: "Hello",
            language: "en-US",
            speechText: "Hello there!",
          },
        ],
      },
    ],
  };

  const userRef = admin.firestore().collection("users").doc(user.uid);
  return userRef.set(initialUserData);
});

