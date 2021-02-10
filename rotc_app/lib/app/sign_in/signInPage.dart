import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/*
Sawyer Kisha
02/02/2021
1.0 - Prototype 01
Ui for the sign in page
*/

class SignInPage extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign-In'),
      ),
      body: Container(
        padding: EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text('Username / Email: '),
            ),
            TextFormField(
              controller: email,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Username / Email',
              ),
              onSaved: (String value) {},
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text('Password: '),
                ),
                TextFormField(
                  controller: password,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                  ),
                  obscureText: true,
                  onSaved: (String value) {},
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: ElevatedButton(
                          child: Text('Sign In'),
                          onPressed: () async {
                            UserCredential user = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: email.text, password: password.text);
                            if (user != null) {
                              Navigator.pushNamed(context, '/cadreHome');
                            }
                          },
                        ),
                      ),

                      //added forgot password button - MRU
                      SizedBox(height: 1.0),
                      Column(
                        children: [
                          TextButton(
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Colors.blueAccent,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/forgotPassword');
                            },
                          )
                        ],
                      ),
                    ])
              ],
            ),
          ],
        ),
      ),
    );
  }
}
