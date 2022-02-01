import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utiles/app_config.dart' as config;
import 'package:passcode_screen/passcode_screen.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
// import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:flutter_grid_button/flutter_grid_button.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashWidgetState createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashPage> {

  final StreamController<bool> _verificationNotifier =
  StreamController<bool>.broadcast();
  bool isAuthenticated = false;
  var array = [0,1,2,3,4,5,6,7,8,9,10,11];
  late String text = "";


  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }

  _onPasscodeEntered(String enteredPasscode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedPasscode = '1234';
    if(prefs.containsKey("pincode")){
      storedPasscode = prefs.getString("pincode");
    }
    bool isValid = storedPasscode == enteredPasscode;

    _verificationNotifier.add(isValid);
    if (isValid) {
      setState(() {
        this.isAuthenticated = isValid;
      });
      Navigator.of(context).pushReplacementNamed('/nav');
    }
  }

  _onPasscodeCancelled() {
    Navigator.maybePop(context);
  }
  _resetAppPassword() {
    Navigator.maybePop(context).then((result) {
      if (!result) {
        return;
      }
      print(result);
      // Navigator.maybePop(context);
    });
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.transparent,
        body:  Stack(
          children: [
            Container(
              width: config.App(context).appWidth(100),
              height: config.App(context).appHeight(100),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      const Color(0xff001B30),
                      const Color(0xff003271),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.0],
                    tileMode: TileMode.clamp),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: config.App(context).appWidth(30), left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/img/fyfy_pay_logo.png', width: config.App(context).appWidth(60), fit: BoxFit.fitWidth,)
                  ],
                )
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: config.App(context).appWidth(100),
                height: config.App(context).appWidth(80),
                child: GridButton(
                  textStyle: TextStyle(color: Colors.grey),
                  borderColor: Colors.grey[300],
                  borderWidth: 1,
                  onPressed: (dynamic val) {
                    if(val.toString() == "←") {
                      if(text.length > 0) {
                        setState(() {
                          text = text.substring(0, text.length - 1);
                        });
                      }
                    } else if(val.toString() == "⌫") {
                      if(text.length > 0) {
                        setState(() {
                          text = "";
                        });
                      }
                    } else {
                      _onKeyboardTap(val.toString());
                    }
                  },
                  items: [

                    [
                      GridButtonItem(title: "1", textStyle: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.w600)),
                      GridButtonItem(title: "2", textStyle: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.w600)),
                      GridButtonItem(title: "3", textStyle: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.w600)),
                    ],
                    [
                      GridButtonItem(title: "4", textStyle: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.w600)),
                      GridButtonItem(title: "5", textStyle: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.w600)),
                      GridButtonItem(title: "6", textStyle: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.w600)),
                    ],
                    [
                      GridButtonItem(title: "7", textStyle: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.w600)),
                      GridButtonItem(title: "8", textStyle: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.w600)),
                      GridButtonItem(title: "9", textStyle: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.w600)),
                    ],
                    [
                      GridButtonItem(title: "⌫", textStyle: TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold)),
                      GridButtonItem(title: "0", textStyle: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.w600)),
                      GridButtonItem(title: "←", textStyle: TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ],
                ),
              )
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: config.App(context).appWidth(70),
                child: Column(
                  children: [

                    // NumericKeyboard(
                    //   onKeyboardTap: _onKeyboardTap,
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   textColor: Colors.white,
                    //   rightIcon: Icon(Icons.cleaning_services_rounded, size: 32, color: Colors.white,),
                    //   rightButtonFn: () {
                    //     setState(() {
                    //       if(text.length > 0) {
                    //         text = "";
                    //       }
                    //
                    //     });
                    //   },
                    //   leftIcon: Icon(Icons.backspace, color: Colors.white,),
                    //   leftButtonFn: () {
                    //     setState(() {
                    //       if(text.length > 0) {
                    //         text = text.substring(0, text.length - 1);
                    //       }
                    //
                    //     });
                    //   },
                    //   // leftIcon: Icon(Icons.check, color: Color(0xff00264E),),
                    //   // mainAxisAlignment: MainAxisAlignment.spaceEvenly
                    // ),
                  ],
                )
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: config.App(context).appWidth(105),
                  child: Column(
                    children: [
                      Text("Enter pin code", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w200)),
                      SizedBox(height: 15),
                      SizedBox(
                        width: config.App(context).appWidth(40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 16, height: 16,
                              decoration: BoxDecoration(
                                color: text.length >= 1 ? Colors.white : Colors.white.withOpacity(0.0),
                                shape: BoxShape.circle,
                                border : Border.all(width: 1, color: Colors.white)
                              ),
                            ),
                            Container(
                              width: 16, height: 16,
                              decoration: BoxDecoration(
                                  color: text.length >= 2 ? Colors.white : Colors.white.withOpacity(0.0),
                                  shape: BoxShape.circle,
                                  border : Border.all(width: 1, color: Colors.white)
                              ),
                            ),
                            Container(
                              width: 16, height: 16,
                              decoration: BoxDecoration(
                                  color: text.length >= 3 ? Colors.white : Colors.white.withOpacity(0.0),
                                  shape: BoxShape.circle,
                                  border : Border.all(width: 1, color: Colors.white)
                              ),
                            ),
                            Container(
                              width: 16, height: 16,
                              decoration: BoxDecoration(
                                  color: text.length >= 4 ? Colors.white : Colors.white.withOpacity(0.0),
                                  shape: BoxShape.circle,
                                  border : Border.all(width: 1, color: Colors.white)
                              ),
                            ),
                          ],
                        )
                      )
                    ],
                  )
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: config.App(context).appWidth(40)),

              // child: ListView(
              //   children: [
              //     SizedBox(
              //       width: config.App(context).appWidth(100),
              //       height: config.App(context).appWidth(150),
              //       child: PasscodeScreen(
              //           title: Text(
              //             'Enter pin code',
              //             textAlign: TextAlign.center,
              //             style: TextStyle(color: Colors.white, fontSize: 28),
              //           ),
              //           circleUIConfig: CircleUIConfig(
              //               borderColor: Colors.white,
              //               fillColor: Color(0xff00264E),
              //               circleSize: 30),
              //           keyboardUIConfig: KeyboardUIConfig(
              //               digitTextStyle: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.w700),
              //               digitBorderWidth: 2, primaryColor: Color(0xff00264E).withOpacity(0.0)),
              //           cancelButton: Icon(
              //             Icons.arrow_back,
              //             color: Colors.white,
              //           ),
              //           digits: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'],
              //           deleteButton: Text(
              //             'Cancel',
              //             style: const TextStyle(fontSize: 16, color: Colors.white),
              //             semanticsLabel: 'Delete',
              //           ),
              //           passwordEnteredCallback: _onPasscodeEntered,
              //           shouldTriggerVerification: _verificationNotifier.stream,
              //           backgroundColor: Colors.transparent,
              //           cancelCallback: _onPasscodeCancelled,
              //           passwordDigits: 4,
              //           bottomWidget: Align(
              //             alignment: Alignment.bottomCenter,
              //             child: Container(
              //               margin: const EdgeInsets.only(bottom: 10.0, top: 20.0),
              //               child: TextButton(
              //                 child: Text(
              //                   "Reset passcode",
              //                   textAlign: TextAlign.center,
              //                   style: const TextStyle(
              //                       fontSize: 16,
              //                       color: Colors.white,
              //                       fontWeight: FontWeight.w300),
              //                 ),
              //                 onPressed: _resetAppPassword,
              //                 // splashColor: Colors.white.withOpacity(0.4),
              //                 // highlightColor: Colors.white.withOpacity(0.2),
              //                 // ),
              //               ),
              //             ),
              //           )
              //       ),
              //     )
              //   ],
              // ),
            ),

          ],
        )
    );
  }

  _onKeyboardTap(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(()  {
      text = text + value;
      if(text.length == 4) {
        String? storedPasscode = '1234';
        if(prefs.containsKey("pincode")){
          storedPasscode = prefs.getString("pincode");
        }
        bool isValid = storedPasscode == text;
        _verificationNotifier.add(isValid);
        if (isValid) {
          setState(() {
            this.isAuthenticated = isValid;
          });
          Navigator.of(context).pushReplacementNamed('/nav');
        } else {
          text = "";
        }
      }
    });
  }


}
