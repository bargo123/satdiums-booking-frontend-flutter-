import 'package:flutter/material.dart';
import 'package:stdbook/core/widgets/custom_container.dart';
import 'package:stdbook/screens/login/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = LoginController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var hight = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            width: width,
            height: hight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(-0.2, -.1),
                stops: [
                  2,
                  1,
                ],
                colors: [Color(0xff0c3d27), Color(0xff54c56d)],
                tileMode: TileMode.clamp,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: hight * 0.15,
                ),
                Container(
                  width: width * 0.85,
                  child: const Text(
                    'Welcome',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
                SizedBox(
                  height: hight * 0.02,
                ),
                Container(
                  width: width * 0.85,
                  child: const Text(
                    'Login to access your account',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: hight * 0.05,
                ),
                CustomContainer(
                  borderRadius: BorderRadius.circular(30),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 10,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 15,
                          child: TextField(
                            controller: emailController,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                labelText: 'Email address',
                                labelStyle: TextStyle(fontSize: 20, color: Color(0xff666666)),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xff666666)))),
                          ),
                        ),
                        Expanded(
                          flex: 15,
                          child: TextField(
                            controller: passwordController,
                            cursorColor: Colors.black,
                            obscureText: true,
                            decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(fontSize: 20, color: Color(0xff666666)),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xff666666)))),
                          ),
                        ),
                        Expanded(
                          flex: 20,
                          child: FlatButton(
                            padding: EdgeInsets.all(0),
                            child: Container(
                              height: hight * 0.07,
                              width: width * 0.6,
                              child: Center(
                                  child: Text(
                                'Sign in',
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              )),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Color(0xff0c3d27),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () async {
                              await loginController.signIn(emailController.text, passwordController.text);
                            },
                          ),
                        ),
                        Text('or', style: TextStyle(color: Color(0xff666666), fontSize: 25)),
                        Expanded(
                          flex: 20,
                          child: FlatButton(
                            padding: EdgeInsets.all(0),
                            child: Container(
                              height: hight * 0.07,
                              width: width * 0.6,
                              child: Center(
                                  child: Text(
                                'Sign in with Google',
                                style: TextStyle(color: Color(0xff0c3d27), fontSize: 20),
                              )),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xff0c3d27)),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: null,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(),
                        ),
                      ],
                    ),
                  ),
                  height: hight * 0.55,
                  width: width * 0.85,
                ),
              ],
            )),
      ),
    );
  }
}
