// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyDlx1NiL0Yg6bWJ0ym9Pv0crkavRw_d2yM",
  authDomain: "hirata-5433b.firebaseapp.com",
  projectId: "hirata-5433b",
  storageBucket: "hirata-5433b.firebasestorage.app",
  messagingSenderId: "52922543080",
  appId: "1:52922543080:web:0f1f6e5d86d678e77f925d",
  measurementId: "G-ZSYJJEVCBS"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);

export { app, analytics };
