class Env {
  static String projectId = "absence-36087";
  static String database =
      "https://absence-36087-default-rtdb.asia-southeast1.firebasedatabase.app";
  static String firestoreDb =
      "https://firestore.googleapis.com/v1/projects/$projectId/databases/(default)/documents";
  static String apiKey = "AIzaSyCcgDslBWNxP7VwQckeRBCvLEKmWfMHs9Y";
  static String firebaseStorage = 'https://firebasestorage.googleapis.com/v0/b';

  static String get imageApi => "${firebaseStorage}absence-36087.appspot.com";
}
