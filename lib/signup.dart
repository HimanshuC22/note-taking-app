import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'constants.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Notes"),
      ),
      body: SignupForm(),
    );
  }
}

class SignupForm extends StatelessWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passController = TextEditingController();
    final confPassController = TextEditingController();
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
              child: TextField(
                keyboardType: TextInputType.visiblePassword,
                controller: confPassController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Confirm Password",
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
                  String EMAIL, PASSWORD1, PASSWORD2;
                  EMAIL = emailController.text;
                  PASSWORD1 = passController.text;
                  PASSWORD2 = confPassController.text;

                  if (EMAIL == "") {
                    // EMPTY MAIL
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
                    if (PASSWORD1 == "" || PASSWORD2 == "") {
                      // EMPTY PASSWORDS
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              "Error",
                              textAlign: TextAlign.center,
                            ),
                            content: Text(
                              "Passwords Empty",
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
                      if (PASSWORD2 != PASSWORD1)
                        {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  "Error",
                                  textAlign: TextAlign.center,
                                ),
                                content: Text(
                                  "Passwords do not match!",
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
                      else
                        {
                          // USER REGISTER
                          registerUser(EMAIL, PASSWORD1, context);
                        }
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

void registerUser(String EMAIL, String PASSWORD, BuildContext context) async
{
  final user = ParseUser(EMAIL, PASSWORD, EMAIL);
  var response = await user.signUp();
  if(response.success)
    {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Success",
              textAlign: TextAlign.center,
            ),
            content: Text(
              "Account Created Successfully!",
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
  else
    {
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

