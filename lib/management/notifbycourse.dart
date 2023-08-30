import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../provider.dart';

class NotificationCourse extends StatefulWidget {
  final info;
  final id;

  NotificationCourse(this.info, this.id);

  @override
  State<StatefulWidget> createState() {
    return NotificationCourseState();
  }
}

class NotificationCourseState extends State<NotificationCourse> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String _serverToken =
      "AAAAZS7Rjuo:APA91bGnYS0IT1ABn3nne49G0TV1428f7LO91K5LcVW9cglqA2l88mCpt3-ZCtK-kej1MpWbrWnzMf8PaAeDhSGoqPjEeJTwIGkC4odtulnHNtV3ju1ZCVZi1PtdhwSG7qXy5pE-5yc4";

  String _title = "";
  String _body = "";

  String _selectedType = "اختر فئة";

  Future<void> _sendNotification(String title, String body, String type) async {
    final response = await http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$_serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body,
            'title': title,
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'name': 'test',
            'lastname': 'tareq',
          },
          'to': '/topics/$type',
        },
      ),
    );

    if (response.statusCode == 200) {
      print("Notification sent successfully");
    } else {
      print("Failed to send notification");
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthP prov = Provider.of<AuthP>(context);

    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text(" إرسال إشعار الى  ${widget.info['course_name']}"),
            centerTitle: true,
            backgroundColor: Theme.of(context).colorScheme.primary,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('home');
              },
            ),),
          body: Container(
            margin: const EdgeInsets.all(10),
            child: ListView(
              shrinkWrap: false,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Form(
                      key: _formKey,
                      child:
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Column(
                          children: [
                            TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  _title = value;
                                });
                              },
                              onSaved: (val) {
                                _title = val!;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "يرجى كتابة العنوان";
                                }
                                return null;
                              },
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                labelText: "العنوان",
                                labelStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                focusColor: Theme.of(context).primaryColor,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.0,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.0,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),),
                                suffixText: "${_title.length}",
                              ),),
                            const SizedBox(height: 10),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "يرجى كتابة الموضوع";
                                }
                                return null;
                              },
                              onSaved: (val) {
                                _body = val!;
                              },
                              onChanged: (value) {
                                setState(() {
                                  _body = value;
                                });
                              },
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.password,
                                  color: Theme.of(context).colorScheme.primary,),
                                labelText: "الموضوع",
                                labelStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,),
                                focusColor: Theme.of(context).colorScheme.primary,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.0,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.0,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),),
                                suffixText: "${_body.length}",
                              ),
                            ),
                            const SizedBox(height: 40),
                            SizedBox(
                              width: 230,
                              height: 50,
                              child: MaterialButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    showDialog<void>(
                                      context: context,
                                      builder: (BuildContext dialogContext) {
                                        return const AlertDialog(
                                          title: Text('انتظر من فضلك..'),
                                          content: SizedBox(
                                            height: 200,
                                            width: 200,
                                            child: Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                    await _sendNotification(_title, _body, widget.id);
                                    await prov.sendNotification(_title, _body, widget.info['course_name'], DateTime.now());
                                    Navigator.of(context).pushNamed('home');
                                  }
                                },
                                color: Theme.of(context).colorScheme.primary,
                                elevation: 0,
                                highlightColor:
                                Theme.of(context).colorScheme.primary,
                                focusColor: Theme.of(context).colorScheme.primary,
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "إرسال الإشعار",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 30),
                                    Icon(Icons.login, color: Colors.white),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

