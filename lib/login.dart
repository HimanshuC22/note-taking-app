import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_taking_app/notes.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Notes"),
      ),
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passController = TextEditingController();
    emailController.text = "22himanshu14@gmail.com";
    passController.text = "qwerty123";
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding * 2),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: kDefaultPadding),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: kDefaultPadding),
              child: TextField(
                keyboardType: TextInputType.visiblePassword,
                controller: passController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: kDefaultPadding),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.25),
                    blurRadius: 50.0,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              height: kDefaultHeight,
              width: double.infinity,
              child: RawMaterialButton(
                onPressed: () {
                  String EMAIL, PASSWORD;
                  EMAIL = emailController.text;
                  PASSWORD = passController.text;

                  if (EMAIL == "") {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "Error",
                            textAlign: TextAlign.center,
                          ),
                          content: Text(
                            "Email is Empty",
                            textAlign: TextAlign.center,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    if (PASSWORD == "") {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              "Error",
                              textAlign: TextAlign.center,
                            ),
                            content: Text(
                              "Password is Empty",
                              textAlign: TextAlign.center,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      // EVERYTHING OK
                      loginUser(EMAIL, PASSWORD, context);
                    }
                  }
                },
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: kDefaultTextSize,
                  ),
                ),
                fillColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void loginUser(String EMAIL, String PASSWORD, BuildContext context) async {
  final user = ParseUser(EMAIL, PASSWORD, null);
  var response = await user.login();

  if (response.success) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Notes(email: EMAIL,)),
        (route) => false);
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Error",
            textAlign: TextAlign.center,
          ),
          content: Text(
            response.error!.message,
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
