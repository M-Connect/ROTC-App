import 'package:flutter/material.dart';

//Author: Christine Thomas
// This class creates the UI for the RegistrationPage
// TextFormFields to be modularized
// validation needs to be fixed
class RegistrationPage extends StatelessWidget {
  
  // variables
  static final SizedBox spaceBetweenFields = SizedBox(height: 20.0);
  //static final invalidCharacters = RegExp(r'^[0-9_\=@,\.;:]+$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(25.0, 30.0, 35.0, 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 3.0, bottom: 6.0),
              child: Text(
                'First Name *',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Simon',
                //floatingLabelBehavior: FloatingLabelBehavior.always,
                //labelText: ' First Name *',
              ),
              onSaved: (String value) {},
              validator: (String value) {
                return value.contains('@') ? 'Do not use the @ char.' : null;
              },
            ),
            spaceBetweenFields,
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 3.0, bottom: 6.0),
                  child: Text(
                    'Last Name *',
                   //textAlign: TextAlign.left,
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Riley',
                    //floatingLabelBehavior: FloatingLabelBehavior.always,
                    //labelText: ' First Name *',
                  ),
                  onSaved: (String value) {},
                  validator: (String value) {
                    return value.contains('_') ? 'Do not use the _ char.' : null;
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
