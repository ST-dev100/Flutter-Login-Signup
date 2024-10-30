import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
  }) async {
    String res = "Some error occurred";
    try {
      // Create user with email and password
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Add user details to Firestore (assuming you want to store user data)
      await _firestore.collection('users').doc(credential.user!.uid).set({
        'name': name,
        'email': email,
        'uid': credential.user!.uid,
        'createdAt': DateTime.now(),
      });

      res = "Success";
      print('User creation successful: $res'); // Print success message
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuth-specific errors
      res = e.message ?? "An error occurred";
      print('User creation failed: $res'); // Print failure message
    } catch (err) {
      // Handle other exceptions
      res = err.toString();
      print('User creation failed: $res'); // Print other error message
    }
    return res;
  }

  Future<String> signInUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";

    // Check if email and password are not empty
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        // Sign in user with email and password
        UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        res = "Success";
        print('User sign-in successful: $res'); // Print success message
      } on FirebaseAuthException catch (e) {
        // Handle FirebaseAuth-specific errors
        res = e.message ?? "An error occurred";
        print('User sign-in failed: $res'); // Print failure message
      } catch (err) {
        // Handle other exceptions
        res = err.toString();
        print('User sign-in failed: $res'); // Print other error message
      }
    } else {
      res = "Email and password cannot be empty.";
      print(res); // Print message for empty fields
    }

    return res;
  }

  Future<void> signOut()async
  {
    await _auth.signOut();
  }

}
