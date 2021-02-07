import 'package:flutter/material.dart';

// Author: Christine Thomas
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
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(25.0, 30.0, 35.0, 8.0),
          width: MediaQuery.of(context).size.width,
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
                  hintText: 'John',
                ),
                onSaved: (String value) {},
                validator: (String value) {
                  return value.contains('_')
                      ? 'Letters and hyphens only.'
                      : null;
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
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Doe',
                    ),
                    onSaved: (String value) {},
                    validator: (String value) {
                      return value.contains('_')
                          ? 'Letters and hyphens only.'
                          : null;
                    },
                  ),
                ],
              ),
              spaceBetweenFields,
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 3.0, bottom: 6.0),
                    child: Text(
                      'Nickname ',
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '\"The Deer\"',
                    ),
                    onSaved: (String value) {},
                    validator: (String value) {
                      return value.contains('_')
                          ? 'Only type in letters and numbers.'
                          : null;
                    },
                  ),
                ],
              ),
              spaceBetweenFields,
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 3.0, bottom: 6.0),
                    child: Text(
                      'Email  *',
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'johndoe@rotc.com',
                    ),
                    onSaved: (String value) {},
                    validator: (String value) {
                      return value.contains('@')
                          ? null
                          : 'Invalid email type, must contain @ symbol.';
                    },
                  ),
                ],
              ),
              spaceBetweenFields,
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 3.0, bottom: 6.0),
                    child: Text(
                      'Password *',
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    onSaved: (String value) {},
                    validator: (String value) {
                      return value.isEmpty ? 'Field cannot be blank.' : null;
                    },
                  ),
                ],
              ),
              spaceBetweenFields,
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 3.0, bottom: 6.0),
                    child: Text(
                      'Confirm Password *',
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    onSaved: (String value) {},
                    validator: (String value) {
                      return value.isEmpty ? 'Field cannot be blank.' : null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(250.0, 15.0, 0.0, 30.0),
                    child: SizedBox(
                      width: 100.0,
                      height: 45.0,
                      child: RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        onPressed: () {},
                        child: Text('Submit'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
